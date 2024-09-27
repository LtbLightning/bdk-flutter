use bdk_bitcoind_rpc::bitcoincore_rpc::bitcoin::address::ParseError;
use bdk_electrum::electrum_client::Error as BdkElectrumError;
use bdk_esplora::esplora_client::{Error as BdkEsploraError, Error};
use bdk_wallet::bitcoin::address::FromScriptError as BdkFromScriptError;
use bdk_wallet::bitcoin::address::ParseError as BdkParseError;
use bdk_wallet::bitcoin::bip32::Error as BdkBip32Error;
use bdk_wallet::bitcoin::consensus::encode::Error as BdkEncodeError;
use bdk_wallet::bitcoin::hex::DisplayHex;
use bdk_wallet::bitcoin::psbt::Error as BdkPsbtError;
use bdk_wallet::bitcoin::psbt::ExtractTxError as BdkExtractTxError;
use bdk_wallet::bitcoin::psbt::PsbtParseError as BdkPsbtParseError;
use bdk_wallet::chain::local_chain::CannotConnectError as BdkCannotConnectError;
use bdk_wallet::chain::rusqlite::Error as BdkSqliteError;
use bdk_wallet::chain::tx_graph::CalculateFeeError as BdkCalculateFeeError;
use bdk_wallet::descriptor::DescriptorError as BdkDescriptorError;
use bdk_wallet::error::BuildFeeBumpError;
use bdk_wallet::error::CreateTxError as BdkCreateTxError;
use bdk_wallet::keys::bip39::Error as BdkBip39Error;
use bdk_wallet::keys::KeyError;
use bdk_wallet::miniscript::descriptor::DescriptorKeyParseError as BdkDescriptorKeyParseError;
use bdk_wallet::signer::SignerError as BdkSignerError;
use bdk_wallet::tx_builder::AddUtxoError;
use bdk_wallet::LoadWithPersistError as BdkLoadWithPersistError;
use bdk_wallet::{chain, CreateWithPersistError as BdkCreateWithPersistError};

use super::bitcoin::OutPoint;
use std::convert::TryInto;

// ------------------------------------------------------------------------
// error definitions
// ------------------------------------------------------------------------

#[derive(Debug, thiserror::Error)]
pub enum AddressParseError {
    #[error("base58 address encoding error")]
    Base58,

    #[error("bech32 address encoding error")]
    Bech32,

    #[error("witness version conversion/parsing error: {error_message}")]
    WitnessVersion { error_message: String },

    #[error("witness program error: {error_message}")]
    WitnessProgram { error_message: String },

    #[error("tried to parse an unknown hrp")]
    UnknownHrp,

    #[error("legacy address base58 string")]
    LegacyAddressTooLong,

    #[error("legacy address base58 data")]
    InvalidBase58PayloadLength,

    #[error("segwit address bech32 string")]
    InvalidLegacyPrefix,

    #[error("validation error")]
    NetworkValidation,

    // This error is required because the bdk::bitcoin::address::ParseError is non-exhaustive
    #[error("other address parse error")]
    OtherAddressParseErr,
}

#[derive(Debug, thiserror::Error)]
pub enum Bip32Error {
    #[error("cannot derive from a hardened key")]
    CannotDeriveFromHardenedKey,

    #[error("secp256k1 error: {error_message}")]
    Secp256k1 { error_message: String },

    #[error("invalid child number: {child_number}")]
    InvalidChildNumber { child_number: u32 },

    #[error("invalid format for child number")]
    InvalidChildNumberFormat,

    #[error("invalid derivation path format")]
    InvalidDerivationPathFormat,

    #[error("unknown version: {version}")]
    UnknownVersion { version: String },

    #[error("wrong extended key length: {length}")]
    WrongExtendedKeyLength { length: u32 },

    #[error("base58 error: {error_message}")]
    Base58 { error_message: String },

    #[error("hexadecimal conversion error: {error_message}")]
    Hex { error_message: String },

    #[error("invalid public key hex length: {length}")]
    InvalidPublicKeyHexLength { length: u32 },

    #[error("unknown error: {error_message}")]
    UnknownError { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum Bip39Error {
    #[error("the word count {word_count} is not supported")]
    BadWordCount { word_count: u64 },

    #[error("unknown word at index {index}")]
    UnknownWord { index: u64 },

    #[error("entropy bit count {bit_count} is invalid")]
    BadEntropyBitCount { bit_count: u64 },

    #[error("checksum is invalid")]
    InvalidChecksum,

    #[error("ambiguous languages detected: {languages}")]
    AmbiguousLanguages { languages: String },
}

#[derive(Debug, thiserror::Error)]
pub enum CalculateFeeError {
    #[error("missing transaction output: {out_points:?}")]
    MissingTxOut { out_points: Vec<OutPoint> },

    #[error("negative fee value: {amount}")]
    NegativeFee { amount: String },
}

#[derive(Debug, thiserror::Error)]
pub enum CannotConnectError {
    #[error("cannot include height: {height}")]
    Include { height: u32 },
}

#[derive(Debug, thiserror::Error)]
pub enum CreateTxError {
    #[error("descriptor error: {error_message}")]
    Descriptor { error_message: String },

    #[error("policy error: {error_message}")]
    Policy { error_message: String },

    #[error("spending policy required for {kind}")]
    SpendingPolicyRequired { kind: String },

    #[error("unsupported version 0")]
    Version0,

    #[error("unsupported version 1 with csv")]
    Version1Csv,

    #[error("lock time conflict: requested {requested}, but required {required}")]
    LockTime { requested: String, required: String },

    #[error("transaction requires rbf sequence number")]
    RbfSequence,

    #[error("rbf sequence: {rbf}, csv sequence: {csv}")]
    RbfSequenceCsv { rbf: String, csv: String },

    #[error("fee too low: required {required}")]
    FeeTooLow { required: String },

    #[error("fee rate too low: {required}")]
    FeeRateTooLow { required: String },

    #[error("no utxos selected for the transaction")]
    NoUtxosSelected,

    #[error("output value below dust limit at index {index}")]
    OutputBelowDustLimit { index: u64 },

    #[error("change policy descriptor error")]
    ChangePolicyDescriptor,

    #[error("coin selection failed: {error_message}")]
    CoinSelection { error_message: String },

    #[error("insufficient funds: needed {needed} sat, available {available} sat")]
    InsufficientFunds { needed: u64, available: u64 },

    #[error("transaction has no recipients")]
    NoRecipients,

    #[error("psbt creation error: {error_message}")]
    Psbt { error_message: String },

    #[error("missing key origin for: {key}")]
    MissingKeyOrigin { key: String },

    #[error("reference to an unknown utxo: {outpoint}")]
    UnknownUtxo { outpoint: String },

    #[error("missing non-witness utxo for outpoint: {outpoint}")]
    MissingNonWitnessUtxo { outpoint: String },

    #[error("miniscript psbt error: {error_message}")]
    MiniscriptPsbt { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum CreateWithPersistError {
    #[error("sqlite persistence error: {error_message}")]
    Persist { error_message: String },

    #[error("the wallet has already been created")]
    DataAlreadyExists,

    #[error("the loaded changeset cannot construct wallet: {error_message}")]
    Descriptor { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum DescriptorError {
    #[error("invalid hd key path")]
    InvalidHdKeyPath,

    #[error("the extended key does not contain private data.")]
    MissingPrivateData,

    #[error("the provided descriptor doesn't match its checksum")]
    InvalidDescriptorChecksum,

    #[error("the descriptor contains hardened derivation steps on public extended keys")]
    HardenedDerivationXpub,

    #[error("the descriptor contains multipath keys, which are not supported yet")]
    MultiPath,

    #[error("key error: {error_message}")]
    Key { error_message: String },
    #[error("generic error: {error_message}")]
    Generic { error_message: String },

    #[error("policy error: {error_message}")]
    Policy { error_message: String },

    #[error("invalid descriptor character: {char}")]
    InvalidDescriptorCharacter { char: String },

    #[error("bip32 error: {error_message}")]
    Bip32 { error_message: String },

    #[error("base58 error: {error_message}")]
    Base58 { error_message: String },

    #[error("key-related error: {error_message}")]
    Pk { error_message: String },

    #[error("miniscript error: {error_message}")]
    Miniscript { error_message: String },

    #[error("hex decoding error: {error_message}")]
    Hex { error_message: String },

    #[error("external and internal descriptors are the same")]
    ExternalAndInternalAreTheSame,
}

#[derive(Debug, thiserror::Error)]
pub enum DescriptorKeyError {
    #[error("error parsing descriptor key: {error_message}")]
    Parse { error_message: String },

    #[error("error invalid key type")]
    InvalidKeyType,

    #[error("error bip 32 related: {error_message}")]
    Bip32 { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum ElectrumError {
    #[error("{error_message}")]
    IOError { error_message: String },

    #[error("{error_message}")]
    Json { error_message: String },

    #[error("{error_message}")]
    Hex { error_message: String },

    #[error("electrum server error: {error_message}")]
    Protocol { error_message: String },

    #[error("{error_message}")]
    Bitcoin { error_message: String },

    #[error("already subscribed to the notifications of an address")]
    AlreadySubscribed,

    #[error("not subscribed to the notifications of an address")]
    NotSubscribed,

    #[error("error during the deserialization of a response from the server: {error_message}")]
    InvalidResponse { error_message: String },

    #[error("{error_message}")]
    Message { error_message: String },

    #[error("invalid domain name {domain} not matching SSL certificate")]
    InvalidDNSNameError { domain: String },

    #[error("missing domain while it was explicitly asked to validate it")]
    MissingDomain,

    #[error("made one or multiple attempts, all errored")]
    AllAttemptsErrored,

    #[error("{error_message}")]
    SharedIOError { error_message: String },

    #[error(
        "couldn't take a lock on the reader mutex. This means that there's already another reader thread is running"
    )]
    CouldntLockReader,

    #[error("broken IPC communication channel: the other thread probably has exited")]
    Mpsc,

    #[error("{error_message}")]
    CouldNotCreateConnection { error_message: String },

    #[error("the request has already been consumed")]
    RequestAlreadyConsumed,
}

#[derive(Debug, thiserror::Error)]
pub enum EsploraError {
    #[error("minreq error: {error_message}")]
    Minreq { error_message: String },

    #[error("http error with status code {status} and message {error_message}")]
    HttpResponse { status: u16, error_message: String },

    #[error("parsing error: {error_message}")]
    Parsing { error_message: String },

    #[error("invalid status code, unable to convert to u16: {error_message}")]
    StatusCode { error_message: String },

    #[error("bitcoin encoding error: {error_message}")]
    BitcoinEncoding { error_message: String },

    #[error("invalid hex data returned: {error_message}")]
    HexToArray { error_message: String },

    #[error("invalid hex data returned: {error_message}")]
    HexToBytes { error_message: String },

    #[error("transaction not found")]
    TransactionNotFound,

    #[error("header height {height} not found")]
    HeaderHeightNotFound { height: u32 },

    #[error("header hash not found")]
    HeaderHashNotFound,

    #[error("invalid http header name: {name}")]
    InvalidHttpHeaderName { name: String },

    #[error("invalid http header value: {value}")]
    InvalidHttpHeaderValue { value: String },

    #[error("the request has already been consumed")]
    RequestAlreadyConsumed,
}

#[derive(Debug, thiserror::Error)]
pub enum ExtractTxError {
    #[error("an absurdly high fee rate of {fee_rate} sat/vbyte")]
    AbsurdFeeRate { fee_rate: u64 },

    #[error("one of the inputs lacked value information (witness_utxo or non_witness_utxo)")]
    MissingInputValue,

    #[error("transaction would be invalid due to output value being greater than input value")]
    SendingTooMuch,

    #[error(
        "this error is required because the bdk::bitcoin::psbt::ExtractTxError is non-exhaustive"
    )]
    OtherExtractTxErr,
}

#[derive(Debug, thiserror::Error)]
pub enum FromScriptError {
    #[error("script is not a p2pkh, p2sh or witness program")]
    UnrecognizedScript,

    #[error("witness program error: {error_message}")]
    WitnessProgram { error_message: String },

    #[error("witness version construction error: {error_message}")]
    WitnessVersion { error_message: String },

    // This error is required because the bdk::bitcoin::address::FromScriptError is non-exhaustive
    #[error("other from script error")]
    OtherFromScriptErr,
}

#[derive(Debug, thiserror::Error)]
pub enum RequestBuilderError {
    #[error("the request has already been consumed")]
    RequestAlreadyConsumed,
}

#[derive(Debug, thiserror::Error)]
pub enum LoadWithPersistError {
    #[error("sqlite persistence error: {error_message}")]
    Persist { error_message: String },

    #[error("the loaded changeset cannot construct wallet: {error_message}")]
    InvalidChangeSet { error_message: String },

    #[error("could not load")]
    CouldNotLoad,
}

#[derive(Debug, thiserror::Error)]
pub enum PersistenceError {
    #[error("writing to persistence error: {error_message}")]
    Write { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum PsbtError {
    #[error("invalid magic")]
    InvalidMagic,

    #[error("UTXO information is not present in PSBT")]
    MissingUtxo,

    #[error("invalid separator")]
    InvalidSeparator,

    #[error("output index is out of bounds of non witness script output array")]
    PsbtUtxoOutOfBounds,

    #[error("invalid key: {key}")]
    InvalidKey { key: String },

    #[error("non-proprietary key type found when proprietary key was expected")]
    InvalidProprietaryKey,

    #[error("duplicate key: {key}")]
    DuplicateKey { key: String },

    #[error("the unsigned transaction has script sigs")]
    UnsignedTxHasScriptSigs,

    #[error("the unsigned transaction has script witnesses")]
    UnsignedTxHasScriptWitnesses,

    #[error("partially signed transactions must have an unsigned transaction")]
    MustHaveUnsignedTx,

    #[error("no more key-value pairs for this psbt map")]
    NoMorePairs,

    // Note: this error would be nice to unpack and provide the two transactions
    #[error("different unsigned transaction")]
    UnexpectedUnsignedTx,

    #[error("non-standard sighash type: {sighash}")]
    NonStandardSighashType { sighash: u32 },

    #[error("invalid hash when parsing slice: {hash}")]
    InvalidHash { hash: String },

    // Note: to provide the data returned in Rust, we need to dereference the fields
    #[error("preimage does not match")]
    InvalidPreimageHashPair,

    #[error("combine conflict: {xpub}")]
    CombineInconsistentKeySources { xpub: String },

    #[error("bitcoin consensus encoding error: {encoding_error}")]
    ConsensusEncoding { encoding_error: String },

    #[error("PSBT has a negative fee which is not allowed")]
    NegativeFee,

    #[error("integer overflow in fee calculation")]
    FeeOverflow,

    #[error("invalid public key {error_message}")]
    InvalidPublicKey { error_message: String },

    #[error("invalid secp256k1 public key: {secp256k1_error}")]
    InvalidSecp256k1PublicKey { secp256k1_error: String },

    #[error("invalid xonly public key")]
    InvalidXOnlyPublicKey,

    #[error("invalid ECDSA signature: {error_message}")]
    InvalidEcdsaSignature { error_message: String },

    #[error("invalid taproot signature: {error_message}")]
    InvalidTaprootSignature { error_message: String },

    #[error("invalid control block")]
    InvalidControlBlock,

    #[error("invalid leaf version")]
    InvalidLeafVersion,

    #[error("taproot error")]
    Taproot,

    #[error("taproot tree error: {error_message}")]
    TapTree { error_message: String },

    #[error("xpub key error")]
    XPubKey,

    #[error("version error: {error_message}")]
    Version { error_message: String },

    #[error("data not consumed entirely when explicitly deserializing")]
    PartialDataConsumption,

    #[error("I/O error: {error_message}")]
    Io { error_message: String },

    #[error("other PSBT error")]
    OtherPsbtErr,
}

#[derive(Debug, thiserror::Error)]
pub enum PsbtParseError {
    #[error("error in internal psbt data structure: {error_message}")]
    PsbtEncoding { error_message: String },

    #[error("error in psbt base64 encoding: {error_message}")]
    Base64Encoding { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum SignerError {
    #[error("missing key for signing")]
    MissingKey,

    #[error("invalid key provided")]
    InvalidKey,

    #[error("user canceled operation")]
    UserCanceled,

    #[error("input index out of range")]
    InputIndexOutOfRange,

    #[error("missing non-witness utxo information")]
    MissingNonWitnessUtxo,

    #[error("invalid non-witness utxo information provided")]
    InvalidNonWitnessUtxo,

    #[error("missing witness utxo")]
    MissingWitnessUtxo,

    #[error("missing witness script")]
    MissingWitnessScript,

    #[error("missing hd keypath")]
    MissingHdKeypath,

    #[error("non-standard sighash type used")]
    NonStandardSighash,

    #[error("invalid sighash type provided")]
    InvalidSighash,

    #[error("error while computing the hash to sign a P2WPKH input: {error_message}")]
    SighashP2wpkh { error_message: String },

    #[error("error while computing the hash to sign a taproot input: {error_message}")]
    SighashTaproot { error_message: String },

    #[error(
        "Error while computing the hash, out of bounds access on the transaction inputs: {error_message}"
    )]
    TxInputsIndexError { error_message: String },

    #[error("miniscript psbt error: {error_message}")]
    MiniscriptPsbt { error_message: String },

    #[error("external error: {error_message}")]
    External { error_message: String },

    #[error("Psbt error: {error_message}")]
    Psbt { error_message: String },
}

#[derive(Debug, thiserror::Error)]
pub enum SqliteError {
    #[error("sqlite error: {rusqlite_error}")]
    Sqlite { rusqlite_error: String },
}

#[derive(Debug, thiserror::Error)]
pub enum TransactionError {
    #[error("io error")]
    Io,

    #[error("allocation of oversized vector")]
    OversizedVectorAllocation,

    #[error("invalid checksum: expected={expected} actual={actual}")]
    InvalidChecksum { expected: String, actual: String },

    #[error("non-minimal var int")]
    NonMinimalVarInt,

    #[error("parse failed")]
    ParseFailed,

    #[error("unsupported segwit version: {flag}")]
    UnsupportedSegwitFlag { flag: u8 },

    // This is required because the bdk::bitcoin::consensus::encode::Error is non-exhaustive
    #[error("other transaction error")]
    OtherTransactionErr,
}

#[derive(Debug, thiserror::Error)]
pub enum TxidParseError {
    #[error("invalid txid: {txid}")]
    InvalidTxid { txid: String },
}

// ------------------------------------------------------------------------
// error conversions
// ------------------------------------------------------------------------

impl From<BdkElectrumError> for ElectrumError {
    fn from(error: BdkElectrumError) -> Self {
        match error {
            BdkElectrumError::IOError(e) => ElectrumError::IOError {
                error_message: e.to_string(),
            },
            BdkElectrumError::JSON(e) => ElectrumError::Json {
                error_message: e.to_string(),
            },
            BdkElectrumError::Hex(e) => ElectrumError::Hex {
                error_message: e.to_string(),
            },
            BdkElectrumError::Protocol(e) => ElectrumError::Protocol {
                error_message: e.to_string(),
            },
            BdkElectrumError::Bitcoin(e) => ElectrumError::Bitcoin {
                error_message: e.to_string(),
            },
            BdkElectrumError::AlreadySubscribed(_) => ElectrumError::AlreadySubscribed,
            BdkElectrumError::NotSubscribed(_) => ElectrumError::NotSubscribed,
            BdkElectrumError::InvalidResponse(e) => ElectrumError::InvalidResponse {
                error_message: e.to_string(),
            },
            BdkElectrumError::Message(e) => ElectrumError::Message {
                error_message: e.to_string(),
            },
            BdkElectrumError::InvalidDNSNameError(domain) => {
                ElectrumError::InvalidDNSNameError { domain }
            }
            BdkElectrumError::MissingDomain => ElectrumError::MissingDomain,
            BdkElectrumError::AllAttemptsErrored(_) => ElectrumError::AllAttemptsErrored,
            BdkElectrumError::SharedIOError(e) => ElectrumError::SharedIOError {
                error_message: e.to_string(),
            },
            BdkElectrumError::CouldntLockReader => ElectrumError::CouldntLockReader,
            BdkElectrumError::Mpsc => ElectrumError::Mpsc,
            BdkElectrumError::CouldNotCreateConnection(error_message) => {
                ElectrumError::CouldNotCreateConnection {
                    error_message: error_message.to_string(),
                }
            }
        }
    }
}

impl From<BdkParseError> for AddressParseError {
    fn from(error: BdkParseError) -> Self {
        match error {
            BdkParseError::Base58(_) => AddressParseError::Base58,
            BdkParseError::Bech32(_) => AddressParseError::Bech32,
            BdkParseError::WitnessVersion(e) => AddressParseError::WitnessVersion {
                error_message: e.to_string(),
            },
            BdkParseError::WitnessProgram(e) => AddressParseError::WitnessProgram {
                error_message: e.to_string(),
            },
            ParseError::UnknownHrp(_) => AddressParseError::UnknownHrp,
            ParseError::LegacyAddressTooLong(_) => AddressParseError::LegacyAddressTooLong,
            ParseError::InvalidBase58PayloadLength(_) => {
                AddressParseError::InvalidBase58PayloadLength
            }
            ParseError::InvalidLegacyPrefix(_) => AddressParseError::InvalidLegacyPrefix,
            ParseError::NetworkValidation(_) => AddressParseError::NetworkValidation,
            _ => AddressParseError::OtherAddressParseErr,
        }
    }
}

impl From<BdkBip32Error> for Bip32Error {
    fn from(error: BdkBip32Error) -> Self {
        match error {
            BdkBip32Error::CannotDeriveFromHardenedKey => Bip32Error::CannotDeriveFromHardenedKey,
            BdkBip32Error::Secp256k1(e) => Bip32Error::Secp256k1 {
                error_message: e.to_string(),
            },
            BdkBip32Error::InvalidChildNumber(num) => {
                Bip32Error::InvalidChildNumber { child_number: num }
            }
            BdkBip32Error::InvalidChildNumberFormat => Bip32Error::InvalidChildNumberFormat,
            BdkBip32Error::InvalidDerivationPathFormat => Bip32Error::InvalidDerivationPathFormat,
            BdkBip32Error::UnknownVersion(bytes) => Bip32Error::UnknownVersion {
                version: bytes.to_lower_hex_string(),
            },
            BdkBip32Error::WrongExtendedKeyLength(len) => {
                Bip32Error::WrongExtendedKeyLength { length: len as u32 }
            }
            BdkBip32Error::Base58(e) => Bip32Error::Base58 {
                error_message: e.to_string(),
            },
            BdkBip32Error::Hex(e) => Bip32Error::Hex {
                error_message: e.to_string(),
            },
            BdkBip32Error::InvalidPublicKeyHexLength(len) => {
                Bip32Error::InvalidPublicKeyHexLength { length: len as u32 }
            }
            _ => Bip32Error::UnknownError {
                error_message: format!("Unhandled error: {:?}", error),
            },
        }
    }
}

impl From<BdkBip39Error> for Bip39Error {
    fn from(error: BdkBip39Error) -> Self {
        match error {
            BdkBip39Error::BadWordCount(word_count) => Bip39Error::BadWordCount {
                word_count: word_count.try_into().expect("word count exceeds u64"),
            },
            BdkBip39Error::UnknownWord(index) => Bip39Error::UnknownWord {
                index: index.try_into().expect("index exceeds u64"),
            },
            BdkBip39Error::BadEntropyBitCount(bit_count) => Bip39Error::BadEntropyBitCount {
                bit_count: bit_count.try_into().expect("bit count exceeds u64"),
            },
            BdkBip39Error::InvalidChecksum => Bip39Error::InvalidChecksum,
            BdkBip39Error::AmbiguousLanguages(info) => Bip39Error::AmbiguousLanguages {
                languages: format!("{:?}", info),
            },
        }
    }
}

impl From<BdkCalculateFeeError> for CalculateFeeError {
    fn from(error: BdkCalculateFeeError) -> Self {
        match error {
            BdkCalculateFeeError::MissingTxOut(out_points) => CalculateFeeError::MissingTxOut {
                out_points: out_points.iter().map(|e| e.to_owned().into()).collect(),
            },
            BdkCalculateFeeError::NegativeFee(signed_amount) => CalculateFeeError::NegativeFee {
                amount: signed_amount.to_string(),
            },
        }
    }
}

impl From<BdkCannotConnectError> for CannotConnectError {
    fn from(error: BdkCannotConnectError) -> Self {
        CannotConnectError::Include {
            height: error.try_include_height,
        }
    }
}

impl From<BdkCreateTxError> for CreateTxError {
    fn from(error: BdkCreateTxError) -> Self {
        match error {
            BdkCreateTxError::Descriptor(e) => CreateTxError::Descriptor {
                error_message: e.to_string(),
            },
            BdkCreateTxError::Policy(e) => CreateTxError::Policy {
                error_message: e.to_string(),
            },
            BdkCreateTxError::SpendingPolicyRequired(kind) => {
                CreateTxError::SpendingPolicyRequired {
                    kind: format!("{:?}", kind),
                }
            }
            BdkCreateTxError::Version0 => CreateTxError::Version0,
            BdkCreateTxError::Version1Csv => CreateTxError::Version1Csv,
            BdkCreateTxError::LockTime {
                requested,
                required,
            } => CreateTxError::LockTime {
                requested: requested.to_string(),
                required: required.to_string(),
            },
            BdkCreateTxError::RbfSequence => CreateTxError::RbfSequence,
            BdkCreateTxError::RbfSequenceCsv { rbf, csv } => CreateTxError::RbfSequenceCsv {
                rbf: rbf.to_string(),
                csv: csv.to_string(),
            },
            BdkCreateTxError::FeeTooLow { required } => CreateTxError::FeeTooLow {
                required: required.to_string(),
            },
            BdkCreateTxError::FeeRateTooLow { required } => CreateTxError::FeeRateTooLow {
                required: required.to_string(),
            },
            BdkCreateTxError::NoUtxosSelected => CreateTxError::NoUtxosSelected,
            BdkCreateTxError::OutputBelowDustLimit(index) => CreateTxError::OutputBelowDustLimit {
                index: index as u64,
            },
            BdkCreateTxError::CoinSelection(e) => CreateTxError::CoinSelection {
                error_message: e.to_string(),
            },
            BdkCreateTxError::NoRecipients => CreateTxError::NoRecipients,
            BdkCreateTxError::Psbt(e) => CreateTxError::Psbt {
                error_message: e.to_string(),
            },
            BdkCreateTxError::MissingKeyOrigin(key) => CreateTxError::MissingKeyOrigin { key },
            BdkCreateTxError::UnknownUtxo => CreateTxError::UnknownUtxo {
                outpoint: "Unknown".to_string(),
            },
            BdkCreateTxError::MissingNonWitnessUtxo(outpoint) => {
                CreateTxError::MissingNonWitnessUtxo {
                    outpoint: outpoint.to_string(),
                }
            }
            BdkCreateTxError::MiniscriptPsbt(e) => CreateTxError::MiniscriptPsbt {
                error_message: e.to_string(),
            },
        }
    }
}

impl From<BdkCreateWithPersistError<chain::rusqlite::Error>> for CreateWithPersistError {
    fn from(error: BdkCreateWithPersistError<chain::rusqlite::Error>) -> Self {
        match error {
            BdkCreateWithPersistError::Persist(e) => CreateWithPersistError::Persist {
                error_message: e.to_string(),
            },
            BdkCreateWithPersistError::Descriptor(e) => CreateWithPersistError::Descriptor {
                error_message: e.to_string(),
            },
            // Objects cannot currently be used in enumerations
            BdkCreateWithPersistError::DataAlreadyExists(_e) => {
                CreateWithPersistError::DataAlreadyExists
            }
        }
    }
}

impl From<AddUtxoError> for CreateTxError {
    fn from(error: AddUtxoError) -> Self {
        match error {
            AddUtxoError::UnknownUtxo(outpoint) => CreateTxError::UnknownUtxo {
                outpoint: outpoint.to_string(),
            },
        }
    }
}

impl From<BuildFeeBumpError> for CreateTxError {
    fn from(error: BuildFeeBumpError) -> Self {
        match error {
            BuildFeeBumpError::UnknownUtxo(outpoint) => CreateTxError::UnknownUtxo {
                outpoint: outpoint.to_string(),
            },
            BuildFeeBumpError::TransactionNotFound(txid) => CreateTxError::UnknownUtxo {
                outpoint: txid.to_string(),
            },
            BuildFeeBumpError::TransactionConfirmed(txid) => CreateTxError::UnknownUtxo {
                outpoint: txid.to_string(),
            },
            BuildFeeBumpError::IrreplaceableTransaction(txid) => CreateTxError::UnknownUtxo {
                outpoint: txid.to_string(),
            },
            BuildFeeBumpError::FeeRateUnavailable => CreateTxError::FeeRateTooLow {
                required: "unavailable".to_string(),
            },
        }
    }
}

impl From<BdkDescriptorError> for DescriptorError {
    fn from(error: BdkDescriptorError) -> Self {
        match error {
            BdkDescriptorError::InvalidHdKeyPath => DescriptorError::InvalidHdKeyPath,
            BdkDescriptorError::InvalidDescriptorChecksum => {
                DescriptorError::InvalidDescriptorChecksum
            }
            BdkDescriptorError::HardenedDerivationXpub => DescriptorError::HardenedDerivationXpub,
            BdkDescriptorError::MultiPath => DescriptorError::MultiPath,
            BdkDescriptorError::Key(e) => DescriptorError::Key {
                error_message: e.to_string(),
            },
            BdkDescriptorError::Policy(e) => DescriptorError::Policy {
                error_message: e.to_string(),
            },
            BdkDescriptorError::InvalidDescriptorCharacter(char) => {
                DescriptorError::InvalidDescriptorCharacter {
                    char: char.to_string(),
                }
            }
            BdkDescriptorError::Bip32(e) => DescriptorError::Bip32 {
                error_message: e.to_string(),
            },
            BdkDescriptorError::Base58(e) => DescriptorError::Base58 {
                error_message: e.to_string(),
            },
            BdkDescriptorError::Pk(e) => DescriptorError::Pk {
                error_message: e.to_string(),
            },
            BdkDescriptorError::Miniscript(e) => DescriptorError::Miniscript {
                error_message: e.to_string(),
            },
            BdkDescriptorError::Hex(e) => DescriptorError::Hex {
                error_message: e.to_string(),
            },
            BdkDescriptorError::ExternalAndInternalAreTheSame => {
                DescriptorError::ExternalAndInternalAreTheSame
            }
        }
    }
}

impl From<BdkDescriptorKeyParseError> for DescriptorKeyError {
    fn from(err: BdkDescriptorKeyParseError) -> DescriptorKeyError {
        DescriptorKeyError::Parse {
            error_message: format!("DescriptorKeyError error: {:?}", err),
        }
    }
}

impl From<BdkBip32Error> for DescriptorKeyError {
    fn from(error: BdkBip32Error) -> DescriptorKeyError {
        DescriptorKeyError::Bip32 {
            error_message: format!("BIP32 derivation error: {:?}", error),
        }
    }
}
impl From<KeyError> for DescriptorError {
    fn from(value: KeyError) -> Self {
        DescriptorError::Key {
            error_message: value.to_string(),
        }
    }
}

impl From<BdkEsploraError> for EsploraError {
    fn from(error: BdkEsploraError) -> Self {
        match error {
            BdkEsploraError::Minreq(e) => EsploraError::Minreq {
                error_message: e.to_string(),
            },
            BdkEsploraError::HttpResponse { status, message } => EsploraError::HttpResponse {
                status,
                error_message: message,
            },
            BdkEsploraError::Parsing(e) => EsploraError::Parsing {
                error_message: e.to_string(),
            },
            Error::StatusCode(e) => EsploraError::StatusCode {
                error_message: e.to_string(),
            },
            BdkEsploraError::BitcoinEncoding(e) => EsploraError::BitcoinEncoding {
                error_message: e.to_string(),
            },
            BdkEsploraError::HexToArray(e) => EsploraError::HexToArray {
                error_message: e.to_string(),
            },
            BdkEsploraError::HexToBytes(e) => EsploraError::HexToBytes {
                error_message: e.to_string(),
            },
            BdkEsploraError::TransactionNotFound(_) => EsploraError::TransactionNotFound,
            BdkEsploraError::HeaderHeightNotFound(height) => {
                EsploraError::HeaderHeightNotFound { height }
            }
            BdkEsploraError::HeaderHashNotFound(_) => EsploraError::HeaderHashNotFound,
            Error::InvalidHttpHeaderName(name) => EsploraError::InvalidHttpHeaderName { name },
            BdkEsploraError::InvalidHttpHeaderValue(value) => {
                EsploraError::InvalidHttpHeaderValue { value }
            }
        }
    }
}

impl From<Box<BdkEsploraError>> for EsploraError {
    fn from(error: Box<BdkEsploraError>) -> Self {
        match *error {
            BdkEsploraError::Minreq(e) => EsploraError::Minreq {
                error_message: e.to_string(),
            },
            BdkEsploraError::HttpResponse { status, message } => EsploraError::HttpResponse {
                status,
                error_message: message,
            },
            BdkEsploraError::Parsing(e) => EsploraError::Parsing {
                error_message: e.to_string(),
            },
            Error::StatusCode(e) => EsploraError::StatusCode {
                error_message: e.to_string(),
            },
            BdkEsploraError::BitcoinEncoding(e) => EsploraError::BitcoinEncoding {
                error_message: e.to_string(),
            },
            BdkEsploraError::HexToArray(e) => EsploraError::HexToArray {
                error_message: e.to_string(),
            },
            BdkEsploraError::HexToBytes(e) => EsploraError::HexToBytes {
                error_message: e.to_string(),
            },
            BdkEsploraError::TransactionNotFound(_) => EsploraError::TransactionNotFound,
            BdkEsploraError::HeaderHeightNotFound(height) => {
                EsploraError::HeaderHeightNotFound { height }
            }
            BdkEsploraError::HeaderHashNotFound(_) => EsploraError::HeaderHashNotFound,
            Error::InvalidHttpHeaderName(name) => EsploraError::InvalidHttpHeaderName { name },
            BdkEsploraError::InvalidHttpHeaderValue(value) => {
                EsploraError::InvalidHttpHeaderValue { value }
            }
        }
    }
}

impl From<BdkExtractTxError> for ExtractTxError {
    fn from(error: BdkExtractTxError) -> Self {
        match error {
            BdkExtractTxError::AbsurdFeeRate { fee_rate, .. } => {
                let sat_per_vbyte = fee_rate.to_sat_per_vb_ceil();
                ExtractTxError::AbsurdFeeRate {
                    fee_rate: sat_per_vbyte,
                }
            }
            BdkExtractTxError::MissingInputValue { .. } => ExtractTxError::MissingInputValue,
            BdkExtractTxError::SendingTooMuch { .. } => ExtractTxError::SendingTooMuch,
            _ => ExtractTxError::OtherExtractTxErr,
        }
    }
}

impl From<BdkFromScriptError> for FromScriptError {
    fn from(error: BdkFromScriptError) -> Self {
        match error {
            BdkFromScriptError::UnrecognizedScript => FromScriptError::UnrecognizedScript,
            BdkFromScriptError::WitnessProgram(e) => FromScriptError::WitnessProgram {
                error_message: e.to_string(),
            },
            BdkFromScriptError::WitnessVersion(e) => FromScriptError::WitnessVersion {
                error_message: e.to_string(),
            },
            _ => FromScriptError::OtherFromScriptErr,
        }
    }
}

impl From<BdkLoadWithPersistError<chain::rusqlite::Error>> for LoadWithPersistError {
    fn from(error: BdkLoadWithPersistError<chain::rusqlite::Error>) -> Self {
        match error {
            BdkLoadWithPersistError::Persist(e) => LoadWithPersistError::Persist {
                error_message: e.to_string(),
            },
            BdkLoadWithPersistError::InvalidChangeSet(e) => {
                LoadWithPersistError::InvalidChangeSet {
                    error_message: e.to_string(),
                }
            }
        }
    }
}

impl From<std::io::Error> for PersistenceError {
    fn from(error: std::io::Error) -> Self {
        PersistenceError::Write {
            error_message: error.to_string(),
        }
    }
}

impl From<BdkPsbtError> for PsbtError {
    fn from(error: BdkPsbtError) -> Self {
        match error {
            BdkPsbtError::InvalidMagic => PsbtError::InvalidMagic,
            BdkPsbtError::MissingUtxo => PsbtError::MissingUtxo,
            BdkPsbtError::InvalidSeparator => PsbtError::InvalidSeparator,
            BdkPsbtError::PsbtUtxoOutOfbounds => PsbtError::PsbtUtxoOutOfBounds,
            BdkPsbtError::InvalidKey(key) => PsbtError::InvalidKey {
                key: key.to_string(),
            },
            BdkPsbtError::InvalidProprietaryKey => PsbtError::InvalidProprietaryKey,
            BdkPsbtError::DuplicateKey(key) => PsbtError::DuplicateKey {
                key: key.to_string(),
            },
            BdkPsbtError::UnsignedTxHasScriptSigs => PsbtError::UnsignedTxHasScriptSigs,
            BdkPsbtError::UnsignedTxHasScriptWitnesses => PsbtError::UnsignedTxHasScriptWitnesses,
            BdkPsbtError::MustHaveUnsignedTx => PsbtError::MustHaveUnsignedTx,
            BdkPsbtError::NoMorePairs => PsbtError::NoMorePairs,
            BdkPsbtError::UnexpectedUnsignedTx { .. } => PsbtError::UnexpectedUnsignedTx,
            BdkPsbtError::NonStandardSighashType(sighash) => {
                PsbtError::NonStandardSighashType { sighash }
            }
            BdkPsbtError::InvalidHash(hash) => PsbtError::InvalidHash {
                hash: hash.to_string(),
            },
            BdkPsbtError::InvalidPreimageHashPair { .. } => PsbtError::InvalidPreimageHashPair,
            BdkPsbtError::CombineInconsistentKeySources(xpub) => {
                PsbtError::CombineInconsistentKeySources {
                    xpub: xpub.to_string(),
                }
            }
            BdkPsbtError::ConsensusEncoding(encoding_error) => PsbtError::ConsensusEncoding {
                encoding_error: encoding_error.to_string(),
            },
            BdkPsbtError::NegativeFee => PsbtError::NegativeFee,
            BdkPsbtError::FeeOverflow => PsbtError::FeeOverflow,
            BdkPsbtError::InvalidPublicKey(e) => PsbtError::InvalidPublicKey {
                error_message: e.to_string(),
            },
            BdkPsbtError::InvalidSecp256k1PublicKey(e) => PsbtError::InvalidSecp256k1PublicKey {
                secp256k1_error: e.to_string(),
            },
            BdkPsbtError::InvalidXOnlyPublicKey => PsbtError::InvalidXOnlyPublicKey,
            BdkPsbtError::InvalidEcdsaSignature(e) => PsbtError::InvalidEcdsaSignature {
                error_message: e.to_string(),
            },
            BdkPsbtError::InvalidTaprootSignature(e) => PsbtError::InvalidTaprootSignature {
                error_message: e.to_string(),
            },
            BdkPsbtError::InvalidControlBlock => PsbtError::InvalidControlBlock,
            BdkPsbtError::InvalidLeafVersion => PsbtError::InvalidLeafVersion,
            BdkPsbtError::Taproot(_) => PsbtError::Taproot,
            BdkPsbtError::TapTree(e) => PsbtError::TapTree {
                error_message: e.to_string(),
            },
            BdkPsbtError::XPubKey(_) => PsbtError::XPubKey,
            BdkPsbtError::Version(e) => PsbtError::Version {
                error_message: e.to_string(),
            },
            BdkPsbtError::PartialDataConsumption => PsbtError::PartialDataConsumption,
            BdkPsbtError::Io(e) => PsbtError::Io {
                error_message: e.to_string(),
            },
            _ => PsbtError::OtherPsbtErr,
        }
    }
}

impl From<BdkPsbtParseError> for PsbtParseError {
    fn from(error: BdkPsbtParseError) -> Self {
        match error {
            BdkPsbtParseError::PsbtEncoding(e) => PsbtParseError::PsbtEncoding {
                error_message: e.to_string(),
            },
            BdkPsbtParseError::Base64Encoding(e) => PsbtParseError::Base64Encoding {
                error_message: e.to_string(),
            },
            _ => {
                unreachable!("this is required because of the non-exhaustive enum in rust-bitcoin")
            }
        }
    }
}

impl From<BdkSignerError> for SignerError {
    fn from(error: BdkSignerError) -> Self {
        match error {
            BdkSignerError::MissingKey => SignerError::MissingKey,
            BdkSignerError::InvalidKey => SignerError::InvalidKey,
            BdkSignerError::UserCanceled => SignerError::UserCanceled,
            BdkSignerError::InputIndexOutOfRange => SignerError::InputIndexOutOfRange,
            BdkSignerError::MissingNonWitnessUtxo => SignerError::MissingNonWitnessUtxo,
            BdkSignerError::InvalidNonWitnessUtxo => SignerError::InvalidNonWitnessUtxo,
            BdkSignerError::MissingWitnessUtxo => SignerError::MissingWitnessUtxo,
            BdkSignerError::MissingWitnessScript => SignerError::MissingWitnessScript,
            BdkSignerError::MissingHdKeypath => SignerError::MissingHdKeypath,
            BdkSignerError::NonStandardSighash => SignerError::NonStandardSighash,
            BdkSignerError::InvalidSighash => SignerError::InvalidSighash,
            BdkSignerError::SighashTaproot(e) => SignerError::SighashTaproot {
                error_message: e.to_string(),
            },
            BdkSignerError::MiniscriptPsbt(e) => SignerError::MiniscriptPsbt {
                error_message: e.to_string(),
            },
            BdkSignerError::External(e) => SignerError::External { error_message: e },
            BdkSignerError::Psbt(e) => SignerError::Psbt {
                error_message: e.to_string(),
            },
        }
    }
}

impl From<BdkEncodeError> for TransactionError {
    fn from(error: BdkEncodeError) -> Self {
        match error {
            BdkEncodeError::Io(_) => TransactionError::Io,
            BdkEncodeError::OversizedVectorAllocation { .. } => {
                TransactionError::OversizedVectorAllocation
            }
            BdkEncodeError::InvalidChecksum { expected, actual } => {
                TransactionError::InvalidChecksum {
                    expected: DisplayHex::to_lower_hex_string(&expected),
                    actual: DisplayHex::to_lower_hex_string(&actual),
                }
            }
            BdkEncodeError::NonMinimalVarInt => TransactionError::NonMinimalVarInt,
            BdkEncodeError::ParseFailed(_) => TransactionError::ParseFailed,
            BdkEncodeError::UnsupportedSegwitFlag(flag) => {
                TransactionError::UnsupportedSegwitFlag { flag }
            }
            _ => TransactionError::OtherTransactionErr,
        }
    }
}

impl From<BdkSqliteError> for SqliteError {
    fn from(error: BdkSqliteError) -> Self {
        SqliteError::Sqlite {
            rusqlite_error: error.to_string(),
        }
    }
}

// /// Error returned when parsing integer from an supposedly prefixed hex string for
// /// a type that can be created infallibly from an integer.
// #[derive(Debug, Clone, Eq, PartialEq)]
// pub enum PrefixedHexError {
//     /// Hex string is missing prefix.
//     MissingPrefix(String),
//     /// Error parsing integer from hex string.
//     ParseInt(String),
// }
// impl From<bdk_core::bitcoin::error::PrefixedHexError> for PrefixedHexError {
//     fn from(value: bdk_core::bitcoin::error::PrefixedHexError) -> Self {
//         match value {
//             chain::bitcoin::error::PrefixedHexError::MissingPrefix(e) =>
//                 PrefixedHexError::MissingPrefix(e.to_string()),
//             chain::bitcoin::error::PrefixedHexError::ParseInt(e) =>
//                 PrefixedHexError::ParseInt(e.to_string()),
//         }
//     }
// }

impl From<bdk_wallet::miniscript::Error> for DescriptorError {
    fn from(value: bdk_wallet::miniscript::Error) -> Self {
        DescriptorError::Miniscript {
            error_message: value.to_string(),
        }
    }
}
