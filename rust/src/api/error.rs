use crate::api::types::{KeychainKind, Network, OutPoint, Variant};
use bdk::descriptor::error::Error as BdkDescriptorError;

#[derive(Debug)]
pub enum BdkError {
    /// Hex decoding error
    Hex(HexError),
    /// Encoding error
    Consensus(ConsensusError),
    VerifyTransaction(String),
    /// Address error.
    Address(AddressError),
    /// Error related to the parsing and usage of descriptors
    Descriptor(DescriptorError),
    /// Wrong number of bytes found when trying to convert to u32
    InvalidU32Bytes(Vec<u8>),
    /// Generic error
    Generic(String),
    /// This error is thrown when trying to convert Bare and Public key script to address
    ScriptDoesntHaveAddressForm,
    /// Cannot build a tx without recipients
    NoRecipients,
    /// `manually_selected_only` option is selected but no utxo has been passed
    NoUtxosSelected,
    /// Output created is under the dust limit, 546 satoshis
    OutputBelowDustLimit(usize),
    /// Wallet's UTXO set is not enough to cover recipient's requested plus fee
    InsufficientFunds {
        /// Sats needed for some transaction
        needed: u64,
        /// Sats available for spending
        available: u64,
    },
    /// Branch and bound coin selection possible attempts with sufficiently big UTXO set could grow
    /// exponentially, thus a limit is set, and when hit, this error is thrown
    BnBTotalTriesExceeded,
    /// Branch and bound coin selection tries to avoid needing a change by finding the right inputs for
    /// the desired outputs plus fee, if there is not such combination this error is thrown
    BnBNoExactMatch,
    /// Happens when trying to spend an UTXO that is not in the internal database
    UnknownUtxo,
    /// Thrown when a tx is not found in the internal database
    TransactionNotFound,
    /// Happens when trying to bump a transaction that is already confirmed
    TransactionConfirmed,
    /// Trying to replace a tx that has a sequence >= `0xFFFFFFFE`
    IrreplaceableTransaction,
    /// When bumping a tx the fee rate requested is lower than required
    FeeRateTooLow {
        /// Required fee rate (satoshi/vbyte)
        needed: f32,
    },
    /// When bumping a tx the absolute fee requested is lower than replaced tx absolute fee
    FeeTooLow {
        /// Required fee absolute value (satoshi)
        needed: u64,
    },
    /// Node doesn't have data to estimate a fee rate
    FeeRateUnavailable,
    MissingKeyOrigin(String),
    /// Error while working with keys
    Key(String),
    /// Descriptor checksum mismatch
    ChecksumMismatch,
    /// Spending policy is not compatible with this [KeychainKind]
    SpendingPolicyRequired(KeychainKind),
    /// Error while extracting and manipulating policies
    InvalidPolicyPathError(String),
    /// Signing error
    Signer(String),
    /// Invalid network
    InvalidNetwork {
        /// requested network, for example what is given as bdk-cli option
        requested: Network,
        /// found network, for example the network of the bitcoin node
        found: Network,
    },
    /// Requested outpoint doesn't exist in the tx (vout greater than available outputs)
    InvalidOutpoint(OutPoint),
    /// Encoding error
    Encode(String),
    /// Miniscript error
    Miniscript(String),
    /// Miniscript PSBT error
    MiniscriptPsbt(String),
    /// BIP32 error
    Bip32(String),
    /// BIP39 error
    Bip39(String),
    /// A secp256k1 error
    Secp256k1(String),
    /// Error serializing or deserializing JSON data
    Json(String),
    /// Partially signed bitcoin transaction error
    Psbt(String),
    /// Partially signed bitcoin transaction parse error
    PsbtParse(String),
    ///  sync attempt failed due to missing scripts in cache which
    /// are needed to satisfy `stop_gap`.
    MissingCachedScripts(usize, usize),
    /// Electrum client error
    Electrum(String),
    /// Esplora client error
    Esplora(String),
    /// Sled database error
    Sled(String),
    /// Rpc client error
    Rpc(String),
    /// Rusqlite client error
    Rusqlite(String),
    InvalidInput(String),
    InvalidLockTime(String),
    InvalidTransaction(String),
}

impl From<bdk::Error> for BdkError {
    fn from(value: bdk::Error) -> Self {
        match value {
            bdk::Error::InvalidU32Bytes(e) => BdkError::InvalidU32Bytes(e),
            bdk::Error::Generic(e) => BdkError::Generic(e),
            bdk::Error::ScriptDoesntHaveAddressForm => BdkError::ScriptDoesntHaveAddressForm,
            bdk::Error::NoRecipients => BdkError::NoRecipients,
            bdk::Error::NoUtxosSelected => BdkError::NoUtxosSelected,
            bdk::Error::OutputBelowDustLimit(e) => BdkError::OutputBelowDustLimit(e),
            bdk::Error::InsufficientFunds { needed, available } => {
                BdkError::InsufficientFunds { needed, available }
            }
            bdk::Error::BnBTotalTriesExceeded => BdkError::BnBTotalTriesExceeded,
            bdk::Error::BnBNoExactMatch => BdkError::BnBNoExactMatch,
            bdk::Error::UnknownUtxo => BdkError::UnknownUtxo,
            bdk::Error::TransactionNotFound => BdkError::TransactionNotFound,
            bdk::Error::TransactionConfirmed => BdkError::TransactionConfirmed,
            bdk::Error::IrreplaceableTransaction => BdkError::IrreplaceableTransaction,
            bdk::Error::FeeRateTooLow { required } => BdkError::FeeRateTooLow {
                needed: required.as_sat_per_vb(),
            },
            bdk::Error::FeeTooLow { required } => BdkError::FeeTooLow { needed: required },
            bdk::Error::FeeRateUnavailable => BdkError::FeeRateUnavailable,
            bdk::Error::MissingKeyOrigin(e) => BdkError::MissingKeyOrigin(e),
            bdk::Error::Key(e) => BdkError::Key(e.to_string()),
            bdk::Error::ChecksumMismatch => BdkError::ChecksumMismatch,
            bdk::Error::SpendingPolicyRequired(e) => BdkError::SpendingPolicyRequired(e.into()),
            bdk::Error::InvalidPolicyPathError(e) => {
                BdkError::InvalidPolicyPathError(e.to_string())
            }
            bdk::Error::Signer(e) => BdkError::Signer(e.to_string()),
            bdk::Error::InvalidNetwork { requested, found } => BdkError::InvalidNetwork {
                requested: requested.into(),
                found: found.into(),
            },
            bdk::Error::InvalidOutpoint(e) => BdkError::InvalidOutpoint(e.into()),
            bdk::Error::Descriptor(e) => BdkError::Descriptor(e.into()),
            bdk::Error::Encode(e) => BdkError::Encode(e.to_string()),
            bdk::Error::Miniscript(e) => BdkError::Miniscript(e.to_string()),
            bdk::Error::MiniscriptPsbt(e) => BdkError::MiniscriptPsbt(e.to_string()),
            bdk::Error::Bip32(e) => BdkError::Bip32(e.to_string()),
            bdk::Error::Secp256k1(e) => BdkError::Secp256k1(e.to_string()),
            bdk::Error::Json(e) => BdkError::Json(e.to_string()),
            bdk::Error::Hex(e) => BdkError::Hex(e.into()),
            bdk::Error::Psbt(e) => BdkError::Psbt(e.to_string()),
            bdk::Error::PsbtParse(e) => BdkError::PsbtParse(e.to_string()),
            bdk::Error::MissingCachedScripts(e) => {
                BdkError::MissingCachedScripts(e.missing_count, e.last_count)
            }
            bdk::Error::Electrum(e) => BdkError::Electrum(e.to_string()),
            bdk::Error::Esplora(e) => BdkError::Esplora(e.to_string()),
            bdk::Error::Sled(e) => BdkError::Sled(e.to_string()),
            bdk::Error::Rpc(e) => BdkError::Rpc(e.to_string()),
            bdk::Error::Rusqlite(e) => BdkError::Rusqlite(e.to_string()),
            _ => BdkError::Generic("".to_string()),
        }
    }
}
#[derive(Debug)]
pub enum DescriptorError {
    InvalidHdKeyPath,
    InvalidDescriptorChecksum,
    HardenedDerivationXpub,
    MultiPath,
    Key(String),
    Policy(String),
    InvalidDescriptorCharacter(u8),
    Bip32(String),
    Base58(String),
    Pk(String),
    Miniscript(String),
    Hex(String),
}
impl From<BdkDescriptorError> for BdkError {
    fn from(value: BdkDescriptorError) -> Self {
        BdkError::Descriptor(value.into())
    }
}
impl From<BdkDescriptorError> for DescriptorError {
    fn from(value: BdkDescriptorError) -> Self {
        match value {
            BdkDescriptorError::InvalidHdKeyPath => DescriptorError::InvalidHdKeyPath,
            BdkDescriptorError::InvalidDescriptorChecksum => {
                DescriptorError::InvalidDescriptorChecksum
            }
            BdkDescriptorError::HardenedDerivationXpub => DescriptorError::HardenedDerivationXpub,
            BdkDescriptorError::MultiPath => DescriptorError::MultiPath,
            BdkDescriptorError::Key(e) => DescriptorError::Key(e.to_string()),
            BdkDescriptorError::Policy(e) => DescriptorError::Policy(e.to_string()),
            BdkDescriptorError::InvalidDescriptorCharacter(e) => {
                DescriptorError::InvalidDescriptorCharacter(e)
            }
            BdkDescriptorError::Bip32(e) => DescriptorError::Bip32(e.to_string()),
            BdkDescriptorError::Base58(e) => DescriptorError::Base58(e.to_string()),
            BdkDescriptorError::Pk(e) => DescriptorError::Pk(e.to_string()),
            BdkDescriptorError::Miniscript(e) => DescriptorError::Miniscript(e.to_string()),
            BdkDescriptorError::Hex(e) => DescriptorError::Hex(e.to_string()),
        }
    }
}
#[derive(Debug)]
pub enum HexError {
    InvalidChar(u8),
    OddLengthString(usize),
    InvalidLength(usize, usize),
}

impl From<bdk::bitcoin::hashes::hex::Error> for HexError {
    fn from(value: bdk::bitcoin::hashes::hex::Error) -> Self {
        match value {
            bdk::bitcoin::hashes::hex::Error::InvalidChar(e) => HexError::InvalidChar(e),
            bdk::bitcoin::hashes::hex::Error::OddLengthString(e) => HexError::OddLengthString(e),
            bdk::bitcoin::hashes::hex::Error::InvalidLength(e, f) => HexError::InvalidLength(e, f),
        }
    }
}

#[derive(Debug)]
pub enum ConsensusError {
    Io(String),
    OversizedVectorAllocation { requested: usize, max: usize },
    InvalidChecksum { expected: [u8; 4], actual: [u8; 4] },
    NonMinimalVarInt,
    ParseFailed(String),
    UnsupportedSegwitFlag(u8),
}
impl From<bdk::bitcoin::consensus::encode::Error> for BdkError {
    fn from(value: bdk::bitcoin::consensus::encode::Error) -> Self {
        BdkError::Consensus(value.into())
    }
}
impl From<bdk::bitcoin::consensus::encode::Error> for ConsensusError {
    fn from(value: bdk::bitcoin::consensus::encode::Error) -> Self {
        match value {
            bdk::bitcoin::consensus::encode::Error::Io(e) => ConsensusError::Io(e.to_string()),
            bdk::bitcoin::consensus::encode::Error::OversizedVectorAllocation {
                requested,
                max,
            } => ConsensusError::OversizedVectorAllocation { requested, max },
            bdk::bitcoin::consensus::encode::Error::InvalidChecksum { expected, actual } => {
                ConsensusError::InvalidChecksum { expected, actual }
            }
            bdk::bitcoin::consensus::encode::Error::NonMinimalVarInt => {
                ConsensusError::NonMinimalVarInt
            }
            bdk::bitcoin::consensus::encode::Error::ParseFailed(e) => {
                ConsensusError::ParseFailed(e.to_string())
            }
            bdk::bitcoin::consensus::encode::Error::UnsupportedSegwitFlag(e) => {
                ConsensusError::UnsupportedSegwitFlag(e)
            }
            _ => unreachable!(),
        }
    }
}
#[derive(Debug)]
pub enum AddressError {
    Base58(String),
    Bech32(String),
    EmptyBech32Payload,
    InvalidBech32Variant {
        expected: Variant,
        found: Variant,
    },
    InvalidWitnessVersion(u8),
    UnparsableWitnessVersion(String),
    MalformedWitnessVersion,
    InvalidWitnessProgramLength(usize),
    InvalidSegwitV0ProgramLength(usize),
    UncompressedPubkey,
    ExcessiveScriptSize,
    UnrecognizedScript,
    UnknownAddressType(String),
    NetworkValidation {
        network_required: Network,
        network_found: Network,
        address: String,
    },
}
impl From<bdk::bitcoin::address::Error> for BdkError {
    fn from(value: bdk::bitcoin::address::Error) -> Self {
        BdkError::Address(value.into())
    }
}

impl From<bdk::bitcoin::address::Error> for AddressError {
    fn from(value: bdk::bitcoin::address::Error) -> Self {
        match value {
            bdk::bitcoin::address::Error::Base58(e) => AddressError::Base58(e.to_string()),
            bdk::bitcoin::address::Error::Bech32(e) => AddressError::Bech32(e.to_string()),
            bdk::bitcoin::address::Error::EmptyBech32Payload => AddressError::EmptyBech32Payload,
            bdk::bitcoin::address::Error::InvalidBech32Variant { expected, found } => {
                AddressError::InvalidBech32Variant {
                    expected: expected.into(),
                    found: found.into(),
                }
            }
            bdk::bitcoin::address::Error::InvalidWitnessVersion(e) => {
                AddressError::InvalidWitnessVersion(e)
            }
            bdk::bitcoin::address::Error::UnparsableWitnessVersion(e) => {
                AddressError::UnparsableWitnessVersion(e.to_string())
            }
            bdk::bitcoin::address::Error::MalformedWitnessVersion => {
                AddressError::MalformedWitnessVersion
            }
            bdk::bitcoin::address::Error::InvalidWitnessProgramLength(e) => {
                AddressError::InvalidWitnessProgramLength(e)
            }
            bdk::bitcoin::address::Error::InvalidSegwitV0ProgramLength(e) => {
                AddressError::InvalidSegwitV0ProgramLength(e)
            }
            bdk::bitcoin::address::Error::UncompressedPubkey => AddressError::UncompressedPubkey,
            bdk::bitcoin::address::Error::ExcessiveScriptSize => AddressError::ExcessiveScriptSize,
            bdk::bitcoin::address::Error::UnrecognizedScript => AddressError::UnrecognizedScript,
            bdk::bitcoin::address::Error::UnknownAddressType(e) => {
                AddressError::UnknownAddressType(e)
            }
            bdk::bitcoin::address::Error::NetworkValidation {
                required,
                found,
                address,
            } => AddressError::NetworkValidation {
                network_required: required.into(),
                network_found: found.into(),
                address: address.assume_checked().to_string(),
            },
            _ => unreachable!(),
        }
    }
}

impl From<bdk::miniscript::Error> for BdkError {
    fn from(value: bdk::miniscript::Error) -> Self {
        BdkError::Miniscript(value.to_string())
    }
}

impl From<bdk::bitcoin::psbt::Error> for BdkError {
    fn from(value: bdk::bitcoin::psbt::Error) -> Self {
        BdkError::Psbt(value.to_string())
    }
}
impl From<bdk::bitcoin::psbt::PsbtParseError> for BdkError {
    fn from(value: bdk::bitcoin::psbt::PsbtParseError) -> Self {
        BdkError::PsbtParse(value.to_string())
    }
}
impl From<bdk::keys::bip39::Error> for BdkError {
    fn from(value: bdk::keys::bip39::Error) -> Self {
        BdkError::Bip39(value.to_string())
    }
}
