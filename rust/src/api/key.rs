use crate::api::error::BdkError;
use crate::api::types::{Network, WordCount};
use crate::frb_generated::RustOpaque;
pub use bdk::bitcoin;
use bdk::bitcoin::secp256k1::Secp256k1;
pub use bdk::keys;
use bdk::keys::bip39::Language;
use bdk::keys::{DerivableKey, GeneratableKey};
use bdk::miniscript::descriptor::{DescriptorXKey, Wildcard};
use bdk::miniscript::BareCtx;
use flutter_rust_bridge::frb;
use std::str::FromStr;

pub struct BdkMnemonic {
    pub ptr: RustOpaque<bdk::keys::bip39::Mnemonic>,
}
impl From<keys::bip39::Mnemonic> for BdkMnemonic {
    fn from(value: keys::bip39::Mnemonic) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}
impl BdkMnemonic {
    #[frb(sync)]
    /// Generates Mnemonic with a random entropy
    pub fn create(word_count: WordCount) -> Result<Self, BdkError> {
        let generated_key: keys::GeneratedKey<_, BareCtx> =
            (match keys::bip39::Mnemonic::generate((word_count.into(), Language::English)) {
                Ok(value) => Ok(value),
                Err(Some(err)) => Err(BdkError::Bip39(err.to_string())),
                Err(None) => Err(BdkError::Generic("".to_string())), // If
            })?;

        keys::bip39::Mnemonic::parse_in(Language::English, generated_key.to_string())
            .map(|e| e.into())
            .map_err(|e| BdkError::Bip39(e.to_string()))
    }
    #[frb(sync)]
    /// Parse a Mnemonic with given string
    pub fn from_string(mnemonic: String) -> Result<Self, BdkError> {
        keys::bip39::Mnemonic::from_str(&mnemonic)
            .map(|m| m.into())
            .map_err(|e| BdkError::Bip39(e.to_string()))
    }
    #[frb(sync)]
    /// Create a new Mnemonic in the specified language from the given entropy.
    /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
    pub fn from_entropy(entropy: Vec<u8>) -> Result<Self, BdkError> {
        keys::bip39::Mnemonic::from_entropy(entropy.as_slice())
            .map(|m| m.into())
            .map_err(|e| BdkError::Bip39(e.to_string()))
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}

pub struct BdkDerivationPath {
    pub ptr: RustOpaque<bdk::bitcoin::bip32::DerivationPath>,
}
impl From<bitcoin::bip32::DerivationPath> for BdkDerivationPath {
    fn from(value: bitcoin::bip32::DerivationPath) -> Self {
        BdkDerivationPath {
            ptr: RustOpaque::new(value),
        }
    }
}

impl BdkDerivationPath {
    #[frb(sync)]
    pub fn from_string(path: String) -> Result<Self, BdkError> {
        bitcoin::bip32::DerivationPath::from_str(&path)
            .map(|e| e.into())
            .map_err(|e| BdkError::Generic(e.to_string()))
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}

#[derive(Debug)]
pub struct BdkDescriptorSecretKey {
    pub ptr: RustOpaque<bdk::keys::DescriptorSecretKey>,
}
impl From<keys::DescriptorSecretKey> for BdkDescriptorSecretKey {
    fn from(value: keys::DescriptorSecretKey) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}
impl BdkDescriptorSecretKey {
    #[frb(sync)]
    pub fn create(
        network: Network,
        mnemonic: BdkMnemonic,
        password: Option<String>,
    ) -> Result<Self, BdkError> {
        let mnemonic = (*mnemonic.ptr).clone();
        let xkey: keys::ExtendedKey = (mnemonic, password)
            .into_extended_key()
            .map_err(|e| BdkError::Key(e.to_string()))?;
        let xpriv = if let Some(e) = xkey.into_xprv(network.into()) {
            Ok(e)
        } else {
            Err(BdkError::Generic(
                "private data not found in the key!".to_string(),
            ))
        };
        let descriptor_secret_key = keys::DescriptorSecretKey::XPrv(DescriptorXKey {
            origin: None,
            xkey: xpriv?,
            derivation_path: bitcoin::bip32::DerivationPath::master(),
            wildcard: Wildcard::Unhardened,
        });
        Ok(descriptor_secret_key.into())
    }
    #[frb(sync)]
    pub fn derive(ptr: BdkDescriptorSecretKey, path: BdkDerivationPath) -> Result<Self, BdkError> {
        let secp = Secp256k1::new();
        let descriptor_secret_key = (*ptr.ptr).clone();
        match descriptor_secret_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derived_xprv = descriptor_x_key
                    .xkey
                    .derive_priv(&secp, &(*path.ptr).clone())
                    .map_err(|e| BdkError::Bip32(e.to_string()))?;
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
            keys::DescriptorSecretKey::Single(_) => Err(BdkError::Generic(
                "Cannot derive from a single key".to_string(),
            )),
            keys::DescriptorSecretKey::MultiXPrv(_) => Err(BdkError::Generic(
                "Cannot derive from a multi key".to_string(),
            )),
        }
    }
    #[frb(sync)]
    pub fn extend(ptr: BdkDescriptorSecretKey, path: BdkDerivationPath) -> Result<Self, BdkError> {
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
            keys::DescriptorSecretKey::Single(_) => Err(BdkError::Generic(
                "Cannot derive from a single key".to_string(),
            )),
            keys::DescriptorSecretKey::MultiXPrv(_) => Err(BdkError::Generic(
                "Cannot derive from a multi key".to_string(),
            )),
        }
    }
    #[frb(sync)]
    pub fn as_public(ptr: BdkDescriptorSecretKey) -> Result<BdkDescriptorPublicKey, BdkError> {
        let secp = Secp256k1::new();
        let descriptor_public_key = ptr
            .ptr
            .to_public(&secp)
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        Ok(descriptor_public_key.into())
    }
    #[frb(sync)]
    /// Get the private key as bytes.
    pub fn secret_bytes(&self) -> Result<Vec<u8>, BdkError> {
        let descriptor_secret_key = &*self.ptr;
        match descriptor_secret_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                Ok(descriptor_x_key.xkey.private_key.secret_bytes().to_vec())
            }
            keys::DescriptorSecretKey::Single(_) => Err(BdkError::Generic(
                "Cannot derive from a single key".to_string(),
            )),
            keys::DescriptorSecretKey::MultiXPrv(_) => Err(BdkError::Generic(
                "Cannot derive from a multi key".to_string(),
            )),
        }
    }
    pub fn from_string(secret_key: String) -> Result<Self, BdkError> {
        let key = keys::DescriptorSecretKey::from_str(&*secret_key)
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        Ok(key.into())
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}
#[derive(Debug)]
pub struct BdkDescriptorPublicKey {
    pub ptr: RustOpaque<bdk::keys::DescriptorPublicKey>,
}
impl From<keys::DescriptorPublicKey> for BdkDescriptorPublicKey {
    fn from(value: keys::DescriptorPublicKey) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}

impl BdkDescriptorPublicKey {
    #[frb(sync)]
    pub fn from_string(public_key: String) -> Result<Self, BdkError> {
        keys::DescriptorPublicKey::from_str(public_key.as_str())
            .map_err(|e| BdkError::Generic(e.to_string()))
            .map(|e| e.into())
    }
    #[frb(sync)]
    pub fn derive(ptr: BdkDescriptorPublicKey, path: BdkDerivationPath) -> Result<Self, BdkError> {
        let secp = Secp256k1::new();
        let descriptor_public_key = (*ptr.ptr).clone();
        match descriptor_public_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let derived_xpub = descriptor_x_key
                    .xkey
                    .derive_pub(&secp, &(*path.ptr).clone())
                    .map_err(|e| BdkError::Bip32(e.to_string()))?;
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
            keys::DescriptorPublicKey::Single(_) => Err(BdkError::Generic(
                "Cannot derive from a single key".to_string(),
            )),
            keys::DescriptorPublicKey::MultiXPub(_) => Err(BdkError::Generic(
                "Cannot derive from a multi key".to_string(),
            )),
        }
    }
    #[frb(sync)]
    pub fn extend(ptr: BdkDescriptorPublicKey, path: BdkDerivationPath) -> Result<Self, BdkError> {
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
            keys::DescriptorPublicKey::Single(_) => Err(BdkError::Generic(
                "Cannot extend from a single key".to_string(),
            )),
            keys::DescriptorPublicKey::MultiXPub(_) => Err(BdkError::Generic(
                "Cannot extend from a multi key".to_string(),
            )),
        }
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}
