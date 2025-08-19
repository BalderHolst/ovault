#[cfg(feature = "python")]
use pyo3::{prelude::*, pyclass, pymethods, types::*};

#[derive(Debug, Clone)]
enum FrontmatterItem {
    Real(f64),
    Integer(i64),
    String(String),
    Boolean(bool),
    Array(Vec<FrontmatterItem>),
    Hash(Frontmatter),
    None,
}

/// Represents the style of lists in frontmatter YAML serialization.
#[cfg_attr(feature = "python", pyclass)]
#[derive(Debug, Clone, Copy, Default, PartialEq)]
pub enum ListStyle {
    #[default]
    /// Dashed list style, e.g.:
    /// - item1
    /// - item2
    /// - item3
    Dashed,
    /// Bracketed list style, e.g.:
    /// [item1, item2, item3]
    Bracketed,
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
            FrontmatterItem::None => PyNone::get(py).into_bound_py_any(py),
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
            obj if obj.is_instance_of::<PyNone>() => Ok(FrontmatterItem::None),
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
#[cfg_attr(feature = "python", pyclass)]
#[derive(Debug, Default, Clone)]
pub struct Frontmatter {
    items: Vec<(String, FrontmatterItem)>,
}

impl From<Vec<(String, FrontmatterItem)>> for Frontmatter {
    fn from(items: Vec<(String, FrontmatterItem)>) -> Self {
        Frontmatter { items }
    }
}

#[cfg(feature = "python")]
#[pymethods]
impl Frontmatter {
    /// Creates a new empty `Frontmatter`.
    #[new]
    pub fn new() -> Self {
        Frontmatter { items: Vec::new() }
    }

    /// Creates a copy of this `Frontmatter`.
    pub fn copy<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, Self>> {
        Bound::new(py, self.clone())
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

    /// Checks if the frontmatter contains a specific key.
    pub fn contains<'py>(&self, key: Bound<'py, PyString>) -> PyResult<bool> {
        let key: String = key.extract()?;
        let found = self.items.iter().any(|(k, _)| *k == key);
        Ok(found)
    }

    /// Retrieves the value associated with a specific key.
    pub fn get_item<'py>(
        &self,
        py: Python<'py>,
        key: Bound<'py, PyString>,
    ) -> PyResult<Option<Bound<'py, PyAny>>> {
        use pyo3::IntoPyObjectExt;
        let key: String = key.extract()?;
        let value = self.items.iter().find(|(k, _)| *k == key).map(|(_, v)| v);
        match value {
            Some(v) => Ok(Some(v.clone().into_bound_py_any(py)?)),
            None => Ok(None),
        }
    }

    /// Sets the value for a specific key, or adds the key-value pair if it does not exist.
    pub fn set_item<'py>(
        &mut self,
        key: Bound<'py, PyString>,
        value: Bound<'py, PyAny>,
    ) -> PyResult<()> {
        let key: String = key.extract()?;
        let value: FrontmatterItem = value.extract()?;

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
                self.items.push((key, value));
            }
        }
        Ok(())
    }

    /// Deletes a key-value pair from the frontmatter by key.
    pub fn del_item<'py>(&mut self, key: Bound<'py, PyString>) -> PyResult<()> {
        let key: String = key.to_string();
        self.items.retain(|(k, _)| *k != key);
        Ok(())
    }

    /// Returns a list of keys in the frontmatter.
    pub fn keys<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyList>> {
        PyList::new(py, self.items.iter().map(|(k, _)| k.clone()))
    }

    /// Returns a list of values in the frontmatter.
    pub fn values<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyList>> {
        PyList::new(py, self.items.iter().map(|(_, v)| v.clone()))
    }

    /// Returns a list of key-value pairs as tuples in the frontmatter.
    pub fn items<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyList>> {
        let mut py_tuples = Vec::with_capacity(self.items.len());
        for (k, v) in &self.items {
            let py_key = PyString::new(py, k);
            let py_value = v.clone().into_pyobject(py)?;
            py_tuples.push((py_key, py_value));
        }
        PyList::new(py, py_tuples.into_iter())
    }

    /// Returns a python dictionary representation of the frontmatter.
    pub fn dict<'py>(&self, py: Python<'py>) -> PyResult<Bound<'py, PyDict>> {
        let dict = PyDict::new(py);
        for (k, v) in &self.items {
            let py_key = PyString::new(py, k);
            let py_value = v.clone().into_pyobject(py)?;
            dict.set_item(py_key, py_value)?;
        }
        Ok(dict)
    }

    /// Converts the frontmatter to a YAML string representation.
    #[pyo3(signature = (indent = 2, list_style = ListStyle::default()))]
    pub fn yaml(&self, indent: usize, list_style: ListStyle) -> PyResult<String> {
        fn to_yaml(
            indent: usize,
            list_style: ListStyle,
            item: FrontmatterItem,
            level: usize,
        ) -> PyResult<String> {
            Ok(match item {
                FrontmatterItem::Real(f) => f.to_string(),
                FrontmatterItem::Integer(i) => i.to_string(),
                FrontmatterItem::String(s) => s,
                FrontmatterItem::Boolean(b) => b.to_string(),
                FrontmatterItem::Array(list) => match list_style {
                    ListStyle::Dashed => {
                        let mut s = "\n".to_string();
                        let len = list.len();
                        for (i, item) in list.into_iter().enumerate() {
                            s += &" ".repeat(indent * level);
                            s += "- ";
                            s += &to_yaml(indent, list_style, item, level + 1)?;
                            if i < len - 1 {
                                s += "\n";
                            }
                        }
                        s
                    }
                    ListStyle::Bracketed => {
                        let mut s = "[".to_string();
                        let len = list.len();
                        for (i, item) in list.into_iter().enumerate() {
                            if matches!(item, FrontmatterItem::Hash(_)) {
                                return Err(pyo3::exceptions::PyTypeError::new_err(
                                    "Nested hashes (key-value pairs) are not supported in bracketed lists",
                                ));
                            }
                            s += &to_yaml(indent, list_style, item, level)?;
                            if i < len - 1 {
                                s += ", ";
                            }
                        }
                        s += "]";
                        s
                    }
                },
                FrontmatterItem::Hash(frontmatter) => {
                    let mut s = String::new();
                    for (k, v) in frontmatter.items.iter() {
                        s += &" ".repeat(indent * level);
                        s += &format!("{}: ", k);
                        s += &to_yaml(indent, list_style, v.clone(), level + 1)?;
                        s += "\n";
                    }
                    s
                }
                FrontmatterItem::None => "null".to_string(),
            })
        }

        to_yaml(indent, list_style, FrontmatterItem::Hash(self.clone()), 0)
    }

    /// Sets an item in the frontmatter, similar to dictionary assignment.
    pub fn __setitem__<'py>(
        &mut self,
        key: Bound<'py, PyString>,
        item: Bound<'py, PyAny>,
    ) -> PyResult<()> {
        self.set_item(key, item)
    }

    /// Gets the value for a specific key, similar to dictionary access.
    pub fn __getitem__<'py>(
        &self,
        py: Python<'py>,
        key: Bound<'py, PyString>,
    ) -> PyResult<Option<Bound<'py, PyAny>>> {
        self.get_item(py, key)
    }

    /// Returns a string representation of the frontmatter, showing its keys.
    pub fn __repr__<'py>(&self) -> String {
        let keys = self
            .items
            .iter()
            .map(|(k, _)| k.as_str())
            .collect::<Vec<_>>();
        format!("Frontmatter(keys: {})", keys.join(", "))
    }

    /// Returns the number of items in the frontmatter
    pub fn __len__(&self) -> usize {
        self.len()
    }

    /// Deletes a key from the frontmatter
    pub fn __delitem__<'py>(&mut self, key: Bound<'py, PyString>) -> PyResult<()> {
        self.del_item(key)
    }
}
