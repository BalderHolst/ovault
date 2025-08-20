//! This module defines the [Frontmatter] struct, which represents the frontmatter of a note.

#[cfg(feature = "python")]
use pyo3::{prelude::*, pyclass, pymethods, types::*};
use yaml_rust2::Yaml;

/// At what length of an array should we switch to using syntax `-` instead of `[]`?
const BRACKET_THESHOLD: usize = 3;

/// Represents an item in the frontmatter of a note.
#[derive(Debug, Clone)]
pub enum FrontmatterItem {
    /// A real number (floating point).
    Real(f64),
    /// An integer number.
    Integer(i64),
    /// A string value.
    String(String),
    /// A boolean value.
    Boolean(bool),
    /// An array of frontmatter items.
    Array(Vec<FrontmatterItem>),
    /// A hash (key-value pairs) of frontmatter items.
    Hash(Frontmatter),
    /// Represents a `null` YAML value, similar to `None` in Python.
    Null,
}

#[cfg(feature = "python")]
impl<'py> IntoPyObject<'py> for FrontmatterItem {
    type Target = PyAny;
    type Output = Bound<'py, PyAny>;
    type Error = PyErr;

    fn into_pyobject(self, py: Python<'py>) -> Result<Self::Output, Self::Error> {
        use pyo3::IntoPyObjectExt;

        match self {
            FrontmatterItem::Real(v) => v.into_bound_py_any(py),
            FrontmatterItem::Integer(i) => i.into_bound_py_any(py),
            FrontmatterItem::String(s) => s.into_bound_py_any(py),
            FrontmatterItem::Boolean(b) => b.into_bound_py_any(py),
            FrontmatterItem::Array(items) => {
                let list = PyList::empty(py);
                for item in items {
                    let py_item = item.into_pyobject(py)?;
                    list.append(py_item)?;
                }
                list.into_bound_py_any(py)
            }
            FrontmatterItem::Hash(frontmatter) => {
                let list = PyList::empty(py);
                for (k, v) in frontmatter.items.iter() {
                    let py_key = k.into_bound_py_any(py)?;
                    let py_value = v.clone().into_pyobject(py)?;
                    let py_tuple = PyTuple::new(py, [py_key, py_value].iter())?;
                    list.append(py_tuple)?;
                }
                list.into_bound_py_any(py)
            }
            FrontmatterItem::Null => PyNone::get(py).into_bound_py_any(py),
        }
    }
}

impl From<Vec<FrontmatterItem>> for FrontmatterItem {
    fn from(items: Vec<FrontmatterItem>) -> Self {
        FrontmatterItem::Array(items)
    }
}

impl From<Vec<(String, FrontmatterItem)>> for FrontmatterItem {
    fn from(items: Vec<(String, FrontmatterItem)>) -> Self {
        FrontmatterItem::Hash(Frontmatter { items })
    }
}

impl From<Yaml> for FrontmatterItem {
    fn from(value: Yaml) -> Self {
        match value {
            Yaml::Real(_) => Self::Real(value.as_f64().expect("Expected a real number")),
            Yaml::Integer(i) => Self::Integer(i),
            Yaml::String(s) => Self::String(s),
            Yaml::Boolean(b) => Self::Boolean(b),
            Yaml::Array(yamls) => yamls
                .into_iter()
                .map(FrontmatterItem::from)
                .collect::<Vec<_>>()
                .into(),
            Yaml::Hash(map) => map
                .into_iter()
                .map(|(k, v)| {
                    let key = k.as_str().expect("Expected a string key").to_string();
                    let value = FrontmatterItem::from(v);
                    (key, value)
                })
                .collect::<Vec<_>>()
                .into(),
            // Don't know how to handle `Alias` and `BadValue`, so we return None
            Yaml::Alias(_) | Yaml::Null | Yaml::BadValue => FrontmatterItem::Null,
        }
    }
}

#[cfg(feature = "python")]
impl<'py> FromPyObject<'py> for FrontmatterItem {
    fn extract_bound(obj: &Bound<'py, PyAny>) -> PyResult<Self> {
        match obj {
            obj if obj.is_instance_of::<PyFloat>() => Ok(FrontmatterItem::Real(obj.extract()?)),
            obj if obj.is_instance_of::<PyInt>() => Ok(FrontmatterItem::Integer(obj.extract()?)),
            obj if obj.is_instance_of::<PyString>() => Ok(FrontmatterItem::String(obj.extract()?)),
            obj if obj.is_instance_of::<PyBool>() => Ok(FrontmatterItem::Boolean(obj.extract()?)),
            obj if obj.is_instance_of::<PyList>() => {
                let list: Vec<FrontmatterItem> = obj
                    .downcast::<PyList>()?
                    .iter()
                    .map(|item| item.extract())
                    .collect::<PyResult<Vec<_>>>()?;
                Ok(FrontmatterItem::Array(list))
            }
            // TODO: Not sure if this should exist as dict does not keep order.
            obj if obj.is_instance_of::<PyDict>() => {
                let mut map = Frontmatter::default();
                for (k, v) in obj.downcast::<PyDict>()?.iter() {
                    let key: String = k.extract()?;
                    let value: FrontmatterItem = v.extract()?;
                    map.items.push((key, value));
                }
                Ok(FrontmatterItem::Hash(map))
            }
            obj if obj.is_instance_of::<Frontmatter>() => {
                let map: Frontmatter = obj.extract()?;
                Ok(FrontmatterItem::Hash(map))
            }
            obj if obj.is_instance_of::<PyNone>() => Ok(FrontmatterItem::Null),
            other => Err(pyo3::exceptions::PyTypeError::new_err(format!(
                "Unsupported type for FrontmatterItem: {:?}",
                other.get_type()
            ))),
        }
    }
}

/// Represents the frontmatter of a note, which is a collection of ordered key-value pairs.
/// This class acts like a dictionary, where keys are strings and values can be various types,
/// including numbers, strings, booleans, arrays
///
/// The main difference from a standard dictionary is that the order of items is preserved
#[derive(Debug, Default, Clone)]
#[cfg_attr(feature = "python", pyclass(name = "Frontmatter"))]
pub struct Frontmatter {
    items: Vec<(String, FrontmatterItem)>,
}

impl From<Vec<(String, FrontmatterItem)>> for Frontmatter {
    fn from(items: Vec<(String, FrontmatterItem)>) -> Self {
        Frontmatter { items }
    }
}

impl Frontmatter {
    /// Create a new empty [Frontmatter].
    pub fn new() -> Self {
        Frontmatter { items: Vec::new() }
    }

    /// Clears all items
    pub fn clear(&mut self) {
        self.items.clear();
    }

    /// Returns the number of items in the frontmatter.
    pub fn len(&self) -> usize {
        self.items.len()
    }

    /// Checks if the frontmatter is empty.
    pub fn is_empty(&self) -> bool {
        self.items.is_empty()
    }

    /// Retrieves a reference to the value associated with a specific key.
    pub fn get(&self, key: &str) -> Option<&FrontmatterItem> {
        self.items.iter().find(|(k, _)| k == key).map(|(_, v)| v)
    }

    /// Retrieves a mutable reference to the value associated with a specific key.
    pub fn get_mut(&mut self, key: &str) -> Option<&mut FrontmatterItem> {
        self.items
            .iter_mut()
            .find(|(k, _)| k == key)
            .map(|(_, v)| v)
    }

    /// Checks if the frontmatter contains a specific key.
    pub fn contains(&self, key: &str) -> bool {
        self.items.iter().any(|(k, _)| k == key)
    }

    /// Sets the value for a specific key, or adds the key-value pair if it does not exist.
    pub fn set(&mut self, key: &str, value: FrontmatterItem) {
        let inner_value = self
            .items
            .iter_mut()
            .find(|(k, _)| *k == key)
            .map(|(_, v)| v);

        match inner_value {
            Some(v) => {
                *v = value;
            }
            None => {
                self.items.push((key.to_string(), value));
            }
        }
    }

    /// Deletes a key-value pair from the frontmatter by key.
    pub fn remove(&mut self, key: &str) {
        self.items.retain(|(k, _)| *k != key);
    }

    /// Returns an iterator over the keys in the frontmatter.
    pub fn keys(&self) -> impl Iterator<Item = &str> {
        self.items.iter().map(|(k, _)| k.as_str())
    }

    /// Returns an iterator over the values in the frontmatter.
    pub fn values(&self) -> impl Iterator<Item = &FrontmatterItem> {
        self.items.iter().map(|(_, v)| v)
    }

    /// Returns an iterator over the key-value pairs in the frontmatter.
    pub fn iter(&self) -> impl Iterator<Item = (&str, &FrontmatterItem)> {
        self.items.iter().map(|(k, v)| (k.as_str(), v))
    }

    // TODO: Maybe use "[]" style for small lists without maps?
    /// Converts the frontmatter to a YAML string representation.
    pub fn to_yaml(&self, indent: usize) -> String {
        fn to_yaml(indent: usize, item: FrontmatterItem, level: usize) -> String {
            match item {
                FrontmatterItem::Real(f) => f.to_string(),
                FrontmatterItem::Integer(i) => i.to_string(),
                FrontmatterItem::String(s) => s,
                FrontmatterItem::Boolean(b) => b.to_string(),
                FrontmatterItem::Array(list)
                    if list.len() <= BRACKET_THESHOLD
                        && !list.iter().any(|i| matches!(i, FrontmatterItem::Hash(_))) =>
                {
                    let mut s = "[".to_string();
                    let len = list.len();
                    for (i, item) in list.into_iter().enumerate() {
                        s += &to_yaml(indent, item, level);
                        if i < len - 1 {
                            s += ", ";
                        }
                    }
                    s += "]";
                    s
                }
                FrontmatterItem::Array(list) => {
                    let mut s = "\n".to_string();
                    let len = list.len();
                    for (i, item) in list.into_iter().enumerate() {
                        s += &" ".repeat(indent * level);
                        s += "- ";
                        s += &to_yaml(indent, item, level + 1);
                        if i < len - 1 {
                            s += "\n";
                        }
                    }
                    s
                }
                FrontmatterItem::Hash(frontmatter) => {
                    let mut s = String::new();
                    for (i, (k, v)) in frontmatter.items.iter().enumerate() {
                        s += &" ".repeat(indent * level);
                        s += &format!("{}: ", k);
                        s += &to_yaml(indent, v.clone(), level + 1);
                        if i < frontmatter.items.len() - 1 {
                            s += "\n";
                        }
                    }
                    s
                }
                FrontmatterItem::Null => "null".to_string(),
            }
        }

        to_yaml(indent, FrontmatterItem::Hash(self.clone()), 0)
    }
}

impl IntoIterator for Frontmatter {
    type Item = (String, FrontmatterItem);
    type IntoIter = std::vec::IntoIter<Self::Item>;

    fn into_iter(self) -> Self::IntoIter {
        self.items.into_iter()
    }
}

#[allow(non_snake_case)]
#[cfg(feature = "python")]
#[pymethods]
impl Frontmatter {
    /// Creates a new empty `Frontmatter`.
    #[new]
    pub fn py_new() -> Self {
        Self::new()
    }

    /// Creates a copy of this `Frontmatter`.
    #[pyo3(name = "copy")]
    pub fn py_copy<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, Self>> {
        Bound::new(py, self.clone())
    }

    /// Clears all items
    #[pyo3(name = "clear")]
    pub fn py_clear(&mut self) {
        self.clear();
    }

    /// Returns the number of items in the frontmatter.
    #[pyo3(name = "len")]
    pub fn py_len(&self) -> usize {
        self.len()
    }

    /// Checks if the frontmatter is empty.
    #[pyo3(name = "is_empty")]
    pub fn py_is_empty(&self) -> bool {
        self.is_empty()
    }

    /// Checks if the frontmatter contains a specific key.
    #[pyo3(name = "contains")]
    pub fn py_contains<'py>(&self, key: Bound<'py, PyString>) -> PyResult<bool> {
        let key: String = key.extract()?;
        Ok(self.contains(&key))
    }

    // TODO: Find a way to return a reference to the item
    /// Retrieves the value associated with a specific key.
    #[pyo3(name = "get_item")]
    pub fn py_get_item<'py>(
        &self,
        py: Python<'py>,
        key: Bound<'py, PyString>,
    ) -> PyResult<Option<Bound<'py, PyAny>>> {
        let key: String = key.extract()?;
        let value = self.get(&key);
        match value {
            Some(v) => Ok(Some(v.clone().into_pyobject(py)?)),
            None => Ok(None),
        }
    }

    /// Sets the value for a specific key, or adds the key-value pair if it does not exist.
    #[pyo3(name = "set_item")]
    pub fn py_set_item<'py>(
        &mut self,
        key: Bound<'py, PyString>,
        value: Bound<'py, PyAny>,
    ) -> PyResult<()> {
        let key: String = key.extract()?;
        let value: FrontmatterItem = value.extract()?;
        self.set(&key, value);
        Ok(())
    }

    /// Deletes a key-value pair from the frontmatter by key.
    #[pyo3(name = "del_item")]
    pub fn py_del_item<'py>(&mut self, key: Bound<'py, PyString>) -> PyResult<()> {
        let key: String = key.to_string();
        self.remove(&key);
        Ok(())
    }

    /// Returns a list of keys in the frontmatter.
    #[pyo3(name = "keys")]
    pub fn py_keys<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyList>> {
        PyList::new(py, self.items.iter().map(|(k, _)| k.clone()))
    }

    /// Returns a list of values in the frontmatter.
    #[pyo3(name = "values")]
    pub fn py_values<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyList>> {
        PyList::new(py, self.items.iter().map(|(_, v)| v.clone()))
    }

    /// Returns a list of key-value pairs as tuples in the frontmatter.
    #[pyo3(name = "items")]
    pub fn py_items<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyList>> {
        let mut py_tuples = Vec::with_capacity(self.items.len());
        for (k, v) in self.iter() {
            let py_key = PyString::new(py, k);
            let py_value = v.clone().into_pyobject(py)?;
            py_tuples.push((py_key, py_value));
        }
        PyList::new(py, py_tuples)
    }

    /// Returns a python dictionary representation of the frontmatter.
    #[pyo3(name = "dict")]
    pub fn py_dict<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyDict>> {
        let dict = PyDict::new(py);
        for (k, v) in self.iter() {
            let py_key = PyString::new(py, k);
            let py_value = v.clone().into_pyobject(py)?;
            dict.set_item(py_key, py_value)?;
        }
        Ok(dict)
    }

    /// Converts the frontmatter to a YAML string representation.
    #[pyo3(signature = (indent = 2))]
    #[pyo3(name = "yaml")]
    pub fn py_yaml(&self, indent: usize) -> String {
        self.to_yaml(indent)
    }

    /// Sets an item in the frontmatter, similar to dictionary assignment.
    #[pyo3(name = "__setitem__")]
    pub fn py___setitem__<'py>(
        &mut self,
        key: Bound<'py, PyString>,
        item: Bound<'py, PyAny>,
    ) -> PyResult<()> {
        self.py_set_item(key, item)
    }

    /// Gets the value for a specific key, similar to dictionary access.
    #[pyo3(name = "__getitem__")]
    pub fn py___getitem__<'py>(
        &self,
        py: Python<'py>,
        key: Bound<'py, PyString>,
    ) -> PyResult<Option<Bound<'py, PyAny>>> {
        self.py_get_item(py, key)
    }

    /// Returns a string representation of the frontmatter, showing its keys.
    #[pyo3(name = "__repr__")]
    pub fn py___repr__(&self) -> String {
        let keys = self
            .items
            .iter()
            .map(|(k, _)| k.as_str())
            .collect::<Vec<_>>();
        format!("Frontmatter(keys: {})", keys.join(", "))
    }

    /// Returns the number of items in the frontmatter
    #[pyo3(name = "__len__")]
    pub fn py___len__(&self) -> usize {
        self.py_len()
    }

    /// Deletes a key from the frontmatter
    #[pyo3(name = "__delitem__")]
    pub fn py___delitem__<'py>(&mut self, key: Bound<'py, PyString>) -> PyResult<()> {
        self.py_del_item(key)
    }
}
