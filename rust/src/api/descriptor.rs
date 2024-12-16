use crate::api::error::BdkError;
use crate::api::key::{BdkDescriptorPublicKey, BdkDescriptorSecretKey};
use crate::api::types::{KeychainKind, Network};
use crate::frb_generated::RustOpaque;
use bdk::bitcoin::bip32::Fingerprint;
use bdk::bitcoin::key::Secp256k1;
pub use bdk::descriptor::IntoWalletDescriptor;
pub use bdk::keys;
use bdk::template::{
    Bip44, Bip44Public, Bip49, Bip49Public, Bip84, Bip84Public, Bip86, Bip86Public,
    DescriptorTemplate,
};
use flutter_rust_bridge::frb;
use std::str::FromStr;

#[derive(Debug)]
pub struct BdkDescriptor {
    pub extended_descriptor: RustOpaque<bdk::descriptor::ExtendedDescriptor>,
    pub key_map: RustOpaque<bdk::keys::KeyMap>,
}

impl BdkDescriptor {
    #[frb(sync)]
    pub fn create(descriptor: String, network: Network) -> Result<Self, BdkError> {
        let secp = Secp256k1::new();
        let (extended_descriptor, key_map) =
            descriptor.into_wallet_descriptor(&secp, network.into())?;
        Ok(Self {
            extended_descriptor: RustOpaque::new(extended_descriptor),
            key_map: RustOpaque::new(key_map),
        })
    }
    #[frb(sync)]
    pub fn new_bip44(
        secret_key: BdkDescriptorSecretKey,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let derivable_key = &*secret_key.ptr;
        match derivable_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip44(derivable_key, keychain_kind.into()).build(network.into())?;
                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
                })
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
    pub fn new_bip44_public(
        public_key: BdkDescriptorPublicKey,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str())
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        let derivable_key = &*public_key.ptr;
        match derivable_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip44Public(derivable_key, fingerprint, keychain_kind.into())
                        .build(network.into())?;

                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
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
    pub fn new_bip49(
        secret_key: BdkDescriptorSecretKey,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let derivable_key = &*secret_key.ptr;
        match derivable_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip49(derivable_key, keychain_kind.into()).build(network.into())?;
                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
                })
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
    pub fn new_bip49_public(
        public_key: BdkDescriptorPublicKey,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str())
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        let derivable_key = &*public_key.ptr;

        match derivable_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip49Public(derivable_key, fingerprint, keychain_kind.into())
                        .build(network.into())?;

                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
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
    pub fn new_bip84(
        secret_key: BdkDescriptorSecretKey,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let derivable_key = &*secret_key.ptr;
        match derivable_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip84(derivable_key, keychain_kind.into()).build(network.into())?;
                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
                })
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
    pub fn new_bip84_public(
        public_key: BdkDescriptorPublicKey,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str())
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        let derivable_key = &*public_key.ptr;

        match derivable_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip84Public(derivable_key, fingerprint, keychain_kind.into())
                        .build(network.into())?;

                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
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
    pub fn new_bip86(
        secret_key: BdkDescriptorSecretKey,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let derivable_key = &*secret_key.ptr;

        match derivable_key {
            keys::DescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip86(derivable_key, keychain_kind.into()).build(network.into())?;
                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
                })
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
    pub fn new_bip86_public(
        public_key: BdkDescriptorPublicKey,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: Network,
    ) -> Result<Self, BdkError> {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str())
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        let derivable_key = &*public_key.ptr;

        match derivable_key {
            keys::DescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip86Public(derivable_key, fingerprint, keychain_kind.into())
                        .build(network.into())?;

                Ok(Self {
                    extended_descriptor: RustOpaque::new(extended_descriptor),
                    key_map: RustOpaque::new(key_map),
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
    pub fn to_string_private(&self) -> String {
        let descriptor = &self.extended_descriptor;
        let key_map = &*self.key_map;
        descriptor.to_string_with_secret(key_map)
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.extended_descriptor.to_string()
    }
    #[frb(sync)]
    pub fn max_satisfaction_weight(&self) -> Result<usize, BdkError> {
        self.extended_descriptor
            .max_weight_to_satisfy()
            .map_err(|e| e.into())
    }
}
