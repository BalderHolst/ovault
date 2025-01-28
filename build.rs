fn main() {
    #[cfg(feature = "python")]
    {
        use std::path::PathBuf;
        let root = PathBuf::from(concat!(env!("CARGO_MANIFEST_DIR"), "/src"));
        let out_path = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join("target")
            .join("python")
            .join(env!("CARGO_PKG_NAME"))
            .join("__init__.py");
        if out_path.exists() {
            std::fs::remove_file(&out_path).unwrap();
        }
        stubify::stubify(root, &out_path);
        todo!();
    }
}

#[cfg(feature = "python")]
mod stubify {
    use std::{
        fs::{self, OpenOptions},
        io::Write,
        path::PathBuf,
    };

    use quote::ToTokens;
    use syn::{self, Visibility};

    pub fn stubify(path: PathBuf, out_path: &PathBuf) {
        for entry in std::fs::read_dir(path).unwrap() {
            let entry = entry.unwrap();
            let path = entry.path();
            if path.is_dir() {
                stubify(path, &out_path);
            } else {
                let ext = path.extension().unwrap();
                if ext != "rs" {
                    continue;
                }
                let content = std::fs::read_to_string(&path).unwrap();
                let ast = syn::parse_file(&content).unwrap();
                let mut new_content = String::new();
                for item in ast.items {
                    match item {
                        syn::Item::Struct(s) => {
                            let Visibility::Public(_) = s.vis else {
                                continue;
                            };

                            println!("{:?}", s.ident);

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

                            dbg!(is_pyclass);

                            if !is_pyclass {
                                continue;
                            }

                            let mut body = String::new();

                            if !docstring.is_empty() {
                                body.push_str("    \"\"\"\n");
                                for doc in docstring {
                                    body.push_str(&format!("    {}\n", doc));
                                }
                                body.push_str("    \"\"\"\n");
                            }

                            if body.is_empty() {
                                body.push_str("    pass\n");
                            }

                            new_content.push_str(&format!("class {}:\n{}\n\n", s.ident, body));
                        }
                        _ => {}
                    }
                }

                if !fs::exists(out_path).unwrap() {
                    let path = PathBuf::from(out_path);
                    fs::create_dir_all(path.parent().unwrap()).unwrap();
                }

                OpenOptions::new()
                    .write(true)
                    .append(true)
                    .create(true)
                    .open(out_path)
                    .unwrap()
                    .write_all(new_content.as_bytes())
                    .unwrap();
            }
        }
    }
}
