use std::{fmt::Debug, sync::Mutex};

use error::BdkError;

pub mod blockchain;
pub mod descriptor;
pub mod error;
pub mod key;
pub mod psbt;
pub mod types;
pub mod wallet;

pub(crate) fn handle_mutex<T, F, R>(lock: &Mutex<T>, operation: F) -> Result<R, BdkError>
where
    T: Debug,
    F: FnOnce(&mut T) -> R,
{
    match lock.lock() {
        Ok(mut mutex_guard) => Ok(operation(&mut *mutex_guard)),
        Err(poisoned) => {
            drop(poisoned.into_inner());
            Err(BdkError::Generic("Poison Error!".to_string()))
        }
    }
}
