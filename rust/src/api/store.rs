use std::sync::MutexGuard;

use crate::frb_generated::RustOpaque;

use super::error::SqliteError;

pub struct FfiConnection(pub RustOpaque<std::sync::Mutex<bdk_wallet::rusqlite::Connection>>);

impl FfiConnection {
    pub fn new(path: String) -> Result<Self, SqliteError> {
        let connection = bdk_wallet::rusqlite::Connection::open(path)?;
        Ok(Self(RustOpaque::new(std::sync::Mutex::new(connection))))
    }

    pub fn new_in_memory() -> Result<Self, SqliteError> {
        let connection = bdk_wallet::rusqlite::Connection::open_in_memory()?;
        Ok(Self(RustOpaque::new(std::sync::Mutex::new(connection))))
    }

    pub(crate) fn get_store(&self) -> MutexGuard<bdk_wallet::rusqlite::Connection> {
        self.0.lock().expect("must lock")
    }
}
