use std::{sync::MutexGuard, time::Duration};

use crate::frb_generated::RustOpaque;

use super::error::SqliteError;

pub struct FfiConnection(pub RustOpaque<std::sync::Mutex<bdk_wallet::rusqlite::Connection>>);

impl FfiConnection {
    pub fn new(path: String) -> Result<Self, SqliteError> {
        let mut connection = bdk_wallet::rusqlite::Connection::open(path)?;
        connection.busy_timeout(Duration::from_secs(30))?;
        Ok(Self(RustOpaque::new(std::sync::Mutex::new(connection))))
    }

    pub fn new_in_memory() -> Result<Self, SqliteError> {
        let mut connection = bdk_wallet::rusqlite::Connection::open_in_memory()?;
        connection.busy_timeout(Duration::from_secs(30))?;
        Ok(Self(RustOpaque::new(std::sync::Mutex::new(connection))))
    }

    pub(crate) fn get_store(&self) -> MutexGuard<bdk_wallet::rusqlite::Connection> {
        self.0.lock().expect("must lock")
    }
}
