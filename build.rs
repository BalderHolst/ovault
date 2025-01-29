fn main() {
    #[cfg(feature = "python")]
    {
        use std::path::PathBuf;
        let root = PathBuf::from(concat!(env!("CARGO_MANIFEST_DIR"), "/src"));
        let out_path = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join(format!("{}.pyi", env!("CARGO_PKG_NAME")));
        if out_path.exists() {
            std::fs::remove_file(&out_path).unwrap();
        }
        stubify::stubify(root, &out_path);
    }
}

#[cfg(feature = "python")]
mod stubify {
    use std::{
        collections::HashMap,
        fmt::Display,
        fs::{self, OpenOptions},
        io::Write,
        path::PathBuf,
    };

    use quote::ToTokens;
    use syn::{self, GenericArgument, Item, ItemImpl, ItemStruct, Type, Visibility};

    enum PyType {
        Int,
        Float,
        Str,
        Bool,
        List(Box<PyType>),
        Tuple(Vec<PyType>),
        Dict(Box<PyType>, Box<PyType>),
        Any,
        None,
        Optional(Box<PyType>),
    }

    impl PyType {
        fn try_from_str(t: &str) -> Self {
            match t {
                "String" => Self::Str,
                "usize" => Self::Int,
                _ => panic!("I don't know how to convert type '{}' to python", t),
            }
        }

        fn try_from_type(t: &Type) -> Self {
            match t {
                Type::Path(p) => {
                    let t = p.path.segments.last().unwrap();
                    let t_ident = &t.ident.to_string();
                    if t.arguments.is_empty() {
                        return Self::try_from_str(&t_ident);
                    }

                    let syn::PathArguments::AngleBracketed(args) = &t.arguments else {
                        panic!("I don't know how to convert '{:?}' to python", t)
                    };
                    let args: Vec<_> = args
                        .args
                        .iter()
                        .map(|a| match a {
                            GenericArgument::Type(t) => t,
                            _ => panic!("Generic '{}' is not type.", t.to_token_stream()),
                        })
                        .collect();

                    match t_ident.as_str() {
                        "Option" => {
                            Self::Optional(Box::new(Self::try_from_type(args.first().unwrap())))
                        }
                        "Vec" => {
                            Self::List(Box::new(Self::try_from_type(args.first().unwrap())))
                        }
                        "PyResult" => {
                            Self::try_from_type(args.first().unwrap())
                        }
                        _ => panic!("I don't know how to convert '{:?}' to python", t),
                    }
                }
                _ => panic!("I don't know how to convert '{:?}' to python", t),
            }
        }
    }

    impl Display for PyType {
        fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            match self {
                Self::Int => write!(f, "int"),
                Self::Float => write!(f, "float"),
                Self::Str => write!(f, "str"),
                Self::Bool => write!(f, "bool"),
                Self::List(t) => write!(f, "list[{}]", t),
                Self::Tuple(ts) => {
                    let ts = ts.iter().map(ToString::to_string).collect::<Vec<String>>();
                    write!(f, "tuple[{}]", ts.join(", "))
                }
                Self::Dict(k, v) => write!(f, "dict[{}, {}]", k, v),
                Self::Any => write!(f, "Any"),
                Self::None => write!(f, "None"),
                Self::Optional(t) => write!(f, "Optional[{}]", t),
            }
        }
    }

    struct PyMethod {
        name: String,
        doc: Vec<String>,
        args: Vec<(String, PyType)>,
        ret: PyType,
    }

    impl Display for PyMethod {
        fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            let mut meta = String::new();

            if !self.doc.is_empty() {
                meta.push_str("    \"\"\"\n");
                for doc in &self.doc {
                    meta.push_str(&format!("    {}\n", doc));
                }
                meta.push_str("    \"\"\"\n");
            }

            let args = self
                .args
                .iter()
                .map(|(name, ty)| format!("{}: {}", name, ty))
                .collect::<Vec<String>>();

            let args = args.join(", ");
            write!(
                f,
                "{}    def {}({}) -> {}:",
                meta, self.name, args, self.ret
            )
        }
    }

    struct PyClass {
        name: String,
        doc: Vec<String>,
        rust_file: PathBuf,
        methods: Vec<PyMethod>,
    }

    impl Display for PyClass {
        fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            let mut meta = String::new();

            meta.push_str(&format!("# {}\n", self.rust_file.display()));

            let mut body = String::new();

            if !self.doc.is_empty() {
                body.push_str("    \"\"\"\n");
                for doc in &self.doc {
                    body.push_str(&format!("    {}\n", doc));
                }
                body.push_str("    \"\"\"\n");
            }

            for method in &self.methods {
                body.push_str(&format!("{}\n", method));
            }

            if body.is_empty() {
                body.push_str("    pass");
            }

            write!(f, "{}class {}:\n{}", meta, self.name, body)
        }
    }

    struct Stubifier {
        classes: Vec<PyClass>,
        impls: HashMap<String, Vec<PyMethod>>,
    }

    impl Stubifier {
        const STUB_MSG: &str = "\
# This file is generated by build.rs.
# Do not edit it manually.

";
        fn new() -> Self {
            Self {
                classes: vec![],
                impls: HashMap::new(),
            }
        }

        fn get_class_mut(&mut self, name: &str) -> Option<&mut PyClass> {
            self.classes.iter_mut().find(|c| c.name == name)
        }

        fn handle_struct(&mut self, path: &PathBuf, s: ItemStruct) {
            let Visibility::Public(_) = s.vis else {
                return;
            };

            let mut is_pyclass = false;
            let mut docstring = vec![];

            for attr in &s.attrs {
                if attr.to_token_stream().to_string().contains("pyclass") {
                    is_pyclass = true;
                }

                match &attr.meta {
                    syn::Meta::Path(_path) => {}
                    syn::Meta::List(_meta_list) => {}
                    syn::Meta::NameValue(meta_name_value) => {
                        if !meta_name_value.path.is_ident("doc") {
                            continue;
                        }
                        docstring.push(
                            meta_name_value
                                .value
                                .to_token_stream()
                                .to_string()
                                .strip_prefix("\"")
                                .unwrap()
                                .strip_suffix("\"")
                                .unwrap()
                                .trim()
                                .to_string(),
                        );
                    }
                }
            }

            if !is_pyclass {
                return;
            }

            self.classes.push(PyClass {
                name: s.ident.to_string(),
                doc: docstring,
                rust_file: path
                    .strip_prefix(concat!(env!("CARGO_MANIFEST_DIR"), "/src"))
                    .unwrap()
                    .to_path_buf(),
                methods: vec![],
            });
        }

        fn handle_impl(&mut self, path: &PathBuf, i: ItemImpl) {
            let mut is_pymethods = false;
            for attr in &i.attrs {
                if attr.to_token_stream().to_string().contains("pymethods") {
                    is_pymethods = true;
                }
            }

            if !is_pymethods {
                return;
            }

            let class_name = i.self_ty.to_token_stream().to_string();

            let Some(class) = self.get_class_mut(&class_name) else {
                return;
            };

            for item in &i.items {
                match item {
                    syn::ImplItem::Fn(f) => {
                        let name = f.sig.ident.to_string();
                        let ret = match &f.sig.output {
                            syn::ReturnType::Default => PyType::None,
                            syn::ReturnType::Type(_, t) => PyType::try_from_type(t),
                        };
                        class.methods.push(PyMethod {
                            name,
                            doc: vec![],
                            args: vec![],
                            ret,
                        });
                    }
                    _ => {}
                }
            }
        }

        fn visit_items<T: Fn(&mut Self, &PathBuf, Item) -> ()>(
            &mut self,
            path: &PathBuf,
            handler: T,
        ) {
            fn find_files(path: &PathBuf) -> Vec<PathBuf> {
                let mut files = vec![];
                for entry in std::fs::read_dir(path).unwrap() {
                    let entry = entry.unwrap();
                    let path = entry.path();
                    if path.is_dir() {
                        files.extend(find_files(&path));
                    } else {
                        let ext = path.extension().unwrap();
                        if ext != "rs" {
                            continue;
                        }
                        files.push(path);
                    }
                }
                files
            }

            for path in find_files(path) {
                let content = std::fs::read_to_string(&path).unwrap();
                let ast = syn::parse_file(&content).unwrap();
                for item in ast.items {
                    handler(self, &path, item);
                }
            }
        }

        fn collect_classes(&mut self, path: &PathBuf) {
            self.visit_items(path, |stubifier, path, item| match item {
                syn::Item::Struct(s) => stubifier.handle_struct(&path, s),
                _ => {}
            });
        }

        fn collect_impls(&mut self, path: &PathBuf) {
            self.visit_items(path, |stubifier, path, item| match item {
                syn::Item::Impl(s) => stubifier.handle_impl(&path, s),
                _ => {}
            });
        }

        fn write(&self, out_path: &PathBuf) {
            if !fs::exists(out_path).unwrap() {
                let path = PathBuf::from(out_path);
                fs::create_dir_all(path.parent().unwrap()).unwrap();
                fs::write(out_path, Self::STUB_MSG).unwrap();
            }

            let stub = self
                .classes
                .iter()
                .map(PyClass::to_string)
                .collect::<Vec<String>>()
                .join("\n\n");

            OpenOptions::new()
                .write(true)
                .append(true)
                .create(true)
                .open(out_path)
                .unwrap()
                .write_all(stub.as_bytes())
                .unwrap();
        }
    }

    pub fn stubify(path: PathBuf, out_path: &PathBuf) {
        let stubifier = &mut Stubifier::new();
        stubifier.collect_classes(&path);
        stubifier.collect_impls(&path);
        stubifier.write(out_path);
    }
}
