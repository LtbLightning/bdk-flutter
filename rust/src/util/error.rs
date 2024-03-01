use crate::api::types::{Network, Variant};

pub enum BdkError {
    HexError(BitcoinHexError),
    ConsensusError(BitcoinConsensusError),
    AddressError(BitcoinAddressError),
}

pub enum BitcoinHexError {
    InvalidChar(u8),
    OddLengthString(usize),
    InvalidLength(usize, usize),
}
pub enum BitcoinConsensusError {
    Io(String),
    OversizedVectorAllocation { requested: usize, max: usize },
    InvalidChecksum { expected: [u8; 4], actual: [u8; 4] },
    NonMinimalVarInt,
    ParseFailed(String),
    UnsupportedSegwitFlag(u8),
}
impl From<bdk::bitcoin::consensus::encode::Error> for BdkError {
    fn from(value: bdk::bitcoin::consensus::encode::Error) -> Self {
        BdkError::ConsensusError(value.into())
    }
}
impl From<bdk::bitcoin::consensus::encode::Error> for BitcoinConsensusError {
    fn from(value: bdk::bitcoin::consensus::encode::Error) -> Self {
        match value {
            bdk::bitcoin::consensus::encode::Error::Io(e) => {
                BitcoinConsensusError::Io(e.to_string())
            }
            bdk::bitcoin::consensus::encode::Error::OversizedVectorAllocation {
                requested,
                max,
            } => BitcoinConsensusError::OversizedVectorAllocation { requested, max },
            bdk::bitcoin::consensus::encode::Error::InvalidChecksum { expected, actual } => {
                BitcoinConsensusError::InvalidChecksum { expected, actual }
            }
            bdk::bitcoin::consensus::encode::Error::NonMinimalVarInt => {
                BitcoinConsensusError::NonMinimalVarInt
            }
            bdk::bitcoin::consensus::encode::Error::ParseFailed(e) => {
                BitcoinConsensusError::ParseFailed(e.to_string())
            }
            bdk::bitcoin::consensus::encode::Error::UnsupportedSegwitFlag(e) => {
                BitcoinConsensusError::UnsupportedSegwitFlag(e)
            }
            _ => unreachable!(),
        }
    }
}
pub enum BitcoinAddressError {
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
        BdkError::AddressError(value.into())
    }
}

impl From<bdk::bitcoin::address::Error> for BitcoinAddressError {
    fn from(value: bdk::bitcoin::address::Error) -> Self {
        match value {
            bdk::bitcoin::address::Error::Base58(e) => BitcoinAddressError::Base58(e.to_string()),
            bdk::bitcoin::address::Error::Bech32(e) => BitcoinAddressError::Bech32(e.to_string()),
            bdk::bitcoin::address::Error::EmptyBech32Payload => {
                BitcoinAddressError::EmptyBech32Payload
            }
            bdk::bitcoin::address::Error::InvalidBech32Variant { expected, found } => {
                BitcoinAddressError::InvalidBech32Variant {
                    expected: expected.into(),
                    found: found.into(),
                }
            }
            bdk::bitcoin::address::Error::InvalidWitnessVersion(e) => {
                BitcoinAddressError::InvalidWitnessVersion(e)
            }
            bdk::bitcoin::address::Error::UnparsableWitnessVersion(e) => {
                BitcoinAddressError::UnparsableWitnessVersion(e.to_string())
            }
            bdk::bitcoin::address::Error::MalformedWitnessVersion => {
                BitcoinAddressError::MalformedWitnessVersion
            }
            bdk::bitcoin::address::Error::InvalidWitnessProgramLength(e) => {
                BitcoinAddressError::InvalidWitnessProgramLength(e)
            }
            bdk::bitcoin::address::Error::InvalidSegwitV0ProgramLength(e) => {
                BitcoinAddressError::InvalidSegwitV0ProgramLength(e)
            }
            bdk::bitcoin::address::Error::UncompressedPubkey => {
                BitcoinAddressError::UncompressedPubkey
            }
            bdk::bitcoin::address::Error::ExcessiveScriptSize => {
                BitcoinAddressError::ExcessiveScriptSize
            }
            bdk::bitcoin::address::Error::UnrecognizedScript => {
                BitcoinAddressError::UnrecognizedScript
            }
            bdk::bitcoin::address::Error::UnknownAddressType(e) => {
                BitcoinAddressError::UnknownAddressType(e)
            }
            bdk::bitcoin::address::Error::NetworkValidation {
                required,
                found,
                address,
            } => BitcoinAddressError::NetworkValidation {
                network_required: required.into(),
                network_found: found.into(),
                address: address.assume_checked().to_string(),
            },
            _ => unreachable!(),
        }
    }
}
