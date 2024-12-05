use std::{fmt::Debug, sync::Mutex};

use error::BdkError;

pub mod blockchain;
pub mod descriptor;
pub mod error;
pub mod key;
pub mod psbt;
pub mod types;
pub mod wallet;

pub(crate) fn execute_with_lock<T, F, R>(lock: &Mutex<T>, operation: F) -> Result<R, BdkError>
where
    T: Debug,
    F: FnOnce(&mut T) -> R,
{
    lock.lock()
        .map_err(|poisoned| {
            drop(poisoned.into_inner());
            BdkError::Generic("Poison Error!".to_string())
        })
        .map(|mut guard| operation(&mut *guard))
}
