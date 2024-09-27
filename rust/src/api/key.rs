use crate::api::types::{Network, WordCount};
use crate::frb_generated::RustOpaque;
pub use bdk_wallet::bitcoin;
use bdk_wallet::bitcoin::secp256k1::Secp256k1;
pub use bdk_wallet::keys;
use bdk_wallet::keys::bip39::Language;
use bdk_wallet::keys::{DerivableKey, GeneratableKey};
use bdk_wallet::miniscript::descriptor::{DescriptorXKey, Wildcard};
use bdk_wallet::miniscript::BareCtx;
use flutter_rust_bridge::frb;
use std::str::FromStr;

use super::error::{Bip32Error, Bip39Error, DescriptorError, DescriptorKeyError};

pub struct FfiMnemonic {
    pub ptr: RustOpaque<bdk_wallet::keys::bip39::Mnemonic>,
}
impl From<keys::bip39::Mnemonic> for FfiMnemonic {
    fn from(value: keys::bip39::Mnemonic) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}
impl FfiMnemonic {
    /// Generates Mnemonic with a random entropy
    pub fn new(word_count: WordCount) -> Result<Self, Bip39Error> {
        //TODO; Resolve the unwrap()
        let generated_key: keys::GeneratedKey<_, BareCtx> =
            keys::bip39::Mnemonic::generate((word_count.into(), Language::English)).unwrap();
        keys::bip39::Mnemonic::parse_in(Language::English, generated_key.to_string())
            .map(|e| e.into())
            .map_err(Bip39Error::from)
    }

    /// Parse a Mnemonic with given string
    pub fn from_string(mnemonic: String) -> Result<Self, Bip39Error> {
        keys::bip39::Mnemonic::from_str(&mnemonic)
            .map(|m| m.into())
            .map_err(Bip39Error::from)
    }

    /// Create a new Mnemonic in the specified language from the given entropy.
    /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
    pub fn from_entropy(entropy: Vec<u8>) -> Result<Self, Bip39Error> {
        keys::bip39::Mnemonic::from_entropy(entropy.as_slice())
            .map(|m| m.into())
            .map_err(Bip39Error::from)
    }

    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}

pub struct FfiDerivationPath {
    pub ptr: RustOpaque<bdk_wallet::bitcoin::bip32::DerivationPath>,
}
impl From<bitcoin::bip32::DerivationPath> for FfiDerivationPath {
    fn from(value: bitcoin::bip32::DerivationPath) -> Self {
        FfiDerivationPath {
            ptr: RustOpaque::new(value),
        }
    }
}

impl FfiDerivationPath {
    pub fn from_string(path: String) -> Result<Self, Bip32Error> {
        bitcoin::bip32::DerivationPath::from_str(&path)
            .map(|e| e.into())
            .map_err(Bip32Error::from)
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}

#[derive(Debug)]
pub struct FfiDescriptorSecretKey {
    pub ptr: RustOpaque<bdk_wallet::keys::DescriptorSecretKey>,
}
impl From<keys::DescriptorSecretKey> for FfiDescriptorSecretKey {
    fn from(value: keys::DescriptorSecretKey) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}
impl FfiDescriptorSecretKey {
    pub fn create(
        network: Network,
        mnemonic: FfiMnemonic,
        password: Option<String>,
    ) -> Result<Self, DescriptorError> {
        let mnemonic = (*mnemonic.ptr).clone();
        let xkey: keys::ExtendedKey = (mnemonic, password).into_extended_key()?;
        let xpriv = match xkey.into_xprv(network.into()) {
            Some(e) => Ok(e),
            None => Err(DescriptorError::MissingPrivateData),
        };
        let descriptor_secret_key = keys::DescriptorSecretKey::XPrv(DescriptorXKey {
            origin: None,
            xkey: xpriv?,
            derivation_path: bitcoin::bip32::DerivationPath::master(),
            wildcard: Wildcard::Unhardened,
        });
        Ok(descriptor_secret_key.into())
    }

    pub fn derive(
        ptr: FfiDescriptorSecretKey,
        path: FfiDerivationPath,
    ) -> Result<Self, DescriptorKeyError> {
        let secp = Secp256k1::new();
        let descriptor_secret_key = (*ptr.ptr).clone();
        match descriptor_secret_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derived_xprv = descriptor_x_key
                    .xkey
                    .derive_priv(&secp, &(*path.ptr).clone())
                    .map_err(DescriptorKeyError::from)?;
                let key_source = match descriptor_x_key.origin.clone() {
                    Some((fingerprint, origin_path)) => {
                        (fingerprint, origin_path.extend(&(*path.ptr).clone()))
                    }
                    None => (
                        descriptor_x_key.xkey.fingerprint(&secp),
                        (*path.ptr).clone(),
                    ),
                };
                let derived_descriptor_secret_key =
                    keys::DescriptorSecretKey::XPrv(DescriptorXKey {
                        origin: Some(key_source),
                        xkey: derived_xprv,
                        derivation_path: bitcoin::bip32::DerivationPath::default(),
                        wildcard: descriptor_x_key.wildcard,
                    });
                Ok(derived_descriptor_secret_key.into())
            }
            keys::DescriptorSecretKey::Single(_) => Err(DescriptorKeyError::InvalidKeyType),
            keys::DescriptorSecretKey::MultiXPrv(_) => Err(DescriptorKeyError::InvalidKeyType),
        }
    }
    pub fn extend(
        ptr: FfiDescriptorSecretKey,
        path: FfiDerivationPath,
    ) -> Result<Self, DescriptorKeyError> {
        let descriptor_secret_key = (*ptr.ptr).clone();
        match descriptor_secret_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let extended_path = descriptor_x_key.derivation_path.extend((*path.ptr).clone());
                let extended_descriptor_secret_key =
                    keys::DescriptorSecretKey::XPrv(DescriptorXKey {
                        origin: descriptor_x_key.origin.clone(),
                        xkey: descriptor_x_key.xkey,
                        derivation_path: extended_path,
                        wildcard: descriptor_x_key.wildcard,
                    });
                Ok(extended_descriptor_secret_key.into())
            }
            keys::DescriptorSecretKey::Single(_) => Err(DescriptorKeyError::InvalidKeyType),
            keys::DescriptorSecretKey::MultiXPrv(_) => Err(DescriptorKeyError::InvalidKeyType),
        }
    }
    #[frb(sync)]
    pub fn as_public(
        ptr: FfiDescriptorSecretKey,
    ) -> Result<FfiDescriptorPublicKey, DescriptorKeyError> {
        let secp = Secp256k1::new();
        let descriptor_public_key = ptr.ptr.to_public(&secp)?;
        Ok(descriptor_public_key.into())
    }
    #[frb(sync)]
    /// Get the private key as bytes.
    pub fn secret_bytes(&self) -> Result<Vec<u8>, DescriptorKeyError> {
        let descriptor_secret_key = &*self.ptr;
        match descriptor_secret_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                Ok(descriptor_x_key.xkey.private_key.secret_bytes().to_vec())
            }
            keys::DescriptorSecretKey::Single(_) => Err(DescriptorKeyError::InvalidKeyType),
            keys::DescriptorSecretKey::MultiXPrv(_) => Err(DescriptorKeyError::InvalidKeyType),
        }
    }

    pub fn from_string(secret_key: String) -> Result<Self, DescriptorKeyError> {
        let key =
            keys::DescriptorSecretKey::from_str(&*secret_key).map_err(DescriptorKeyError::from)?;
        Ok(key.into())
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}
#[derive(Debug)]
pub struct FfiDescriptorPublicKey {
    pub ptr: RustOpaque<bdk_wallet::keys::DescriptorPublicKey>,
}
impl From<keys::DescriptorPublicKey> for FfiDescriptorPublicKey {
    fn from(value: keys::DescriptorPublicKey) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}

impl FfiDescriptorPublicKey {
    pub fn from_string(public_key: String) -> Result<Self, DescriptorKeyError> {
        match keys::DescriptorPublicKey::from_str(public_key.as_str()) {
            Ok(e) => Ok(e.into()),
            Err(e) => Err(e.into()),
        }
    }
    pub fn derive(
        ptr: FfiDescriptorPublicKey,
        path: FfiDerivationPath,
    ) -> Result<Self, DescriptorKeyError> {
        let secp = Secp256k1::new();
        let descriptor_public_key = (*ptr.ptr).clone();
        match descriptor_public_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let derived_xpub = descriptor_x_key
                    .xkey
                    .derive_pub(&secp, &(*path.ptr).clone())
                    .map_err(DescriptorKeyError::from)?;
                let key_source = match descriptor_x_key.origin.clone() {
                    Some((fingerprint, origin_path)) => {
                        (fingerprint, origin_path.extend(&(*path.ptr).clone()))
                    }
                    None => (descriptor_x_key.xkey.fingerprint(), (*path.ptr).clone()),
                };
                let derived_descriptor_public_key =
                    keys::DescriptorPublicKey::XPub(DescriptorXKey {
                        origin: Some(key_source),
                        xkey: derived_xpub,
                        derivation_path: bitcoin::bip32::DerivationPath::default(),
                        wildcard: descriptor_x_key.wildcard,
                    });
                Ok(Self {
                    ptr: RustOpaque::new(derived_descriptor_public_key),
                })
            }
            keys::DescriptorPublicKey::Single(_) => Err(DescriptorKeyError::InvalidKeyType),
            keys::DescriptorPublicKey::MultiXPub(_) => Err(DescriptorKeyError::InvalidKeyType),
        }
    }

    pub fn extend(
        ptr: FfiDescriptorPublicKey,
        path: FfiDerivationPath,
    ) -> Result<Self, DescriptorKeyError> {
        let descriptor_public_key = (*ptr.ptr).clone();
        match descriptor_public_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let extended_path = descriptor_x_key
                    .derivation_path
                    .extend(&(*path.ptr).clone());
                let extended_descriptor_public_key =
                    keys::DescriptorPublicKey::XPub(DescriptorXKey {
                        origin: descriptor_x_key.origin.clone(),
                        xkey: descriptor_x_key.xkey,
                        derivation_path: extended_path,
                        wildcard: descriptor_x_key.wildcard,
                    });
                Ok(Self {
                    ptr: RustOpaque::new(extended_descriptor_public_key),
                })
            }
            keys::DescriptorPublicKey::Single(_) => Err(DescriptorKeyError::InvalidKeyType),
            keys::DescriptorPublicKey::MultiXPub(_) => Err(DescriptorKeyError::InvalidKeyType),
        }
    }

    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}
