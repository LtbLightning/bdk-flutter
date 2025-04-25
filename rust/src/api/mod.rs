// use std::{ fmt::Debug, sync::Mutex };

// use error::LockError;

pub mod bitcoin;
pub mod descriptor;
pub mod electrum;
pub mod error;
pub mod esplora;
pub mod key;
pub mod store;
pub mod tx_builder;
pub mod types;
pub mod wallet;

// pub(crate) fn handle_mutex<T, F, R, E>(lock: &Mutex<T>, operation: F) -> Result<Result<R, E>, E>
//     where T: Debug, F: FnOnce(&mut T) -> Result<R, E>
// {
//     match lock.lock() {
//         Ok(mut mutex_guard) => Ok(operation(&mut *mutex_guard)),
//         Err(poisoned) => {
//             drop(poisoned.into_inner());
//             Err(E::Generic { error_message: "Poison Error!".to_string() })
//         }
//     }
// }
