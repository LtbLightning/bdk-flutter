use bdk::bitcoin::hashes::hex::ToHex;
use bdk::bitcoin::secp256k1::Secp256k1;
use bdk::bitcoin::util::psbt::PartiallySignedTransaction;
use bdk::bitcoin::{Address, Network, Script};
use bdk::blockchain::any::AnyBlockchain;
use bdk::database::MemoryDatabase;
use bdk::keys::bip39::{Language, Mnemonic, WordCount};
use bdk::keys::{DerivableKey, ExtendedKey, GeneratableKey, GeneratedKey};
use bdk::miniscript::BareCtx;
use bdk::wallet::AddressIndex as BdkAddressIndex;
use bdk::wallet::AddressInfo as BdkAddressInfo;
use bdk::{BlockTime, Error, FeeRate, SignOptions, SyncOptions, Wallet as BdkWallet};
use std::convert::From;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex, MutexGuard};

use serde::{Deserialize, Serialize};

type BdkError = Error;
#[derive(Serialize, Deserialize)]
pub struct ResponseWallet {
    pub balance: String,
    pub address: String,
    pub mnemonic: String,
}
#[repr(C)]
pub struct ExtendedKeyInfo {
    pub mnemonic: String,
    pub xprv: String,
    pub fingerprint: String,
}

#[repr(C)]
pub enum AddressIndex {
    New,
    LastUnused,
}
impl From<AddressIndex> for BdkAddressIndex {
    fn from(x: AddressIndex) -> BdkAddressIndex {
        match x {
            AddressIndex::New => BdkAddressIndex::New,
            AddressIndex::LastUnused => BdkAddressIndex::LastUnused,
        }
    }
}
#[repr(C)]
pub struct AddressInfo {
    pub index: u32,
    pub address: String,
}
impl From<BdkAddressInfo> for AddressInfo {
    fn from(x: bdk::wallet::AddressInfo) -> AddressInfo {
        AddressInfo {
            index: x.index,
            address: x.address.to_string(),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[repr(C)]
pub struct TransactionDetails {
    pub fee: Option<u64>,
    pub received: u64,
    pub sent: u64,
    pub txid: String,
}
impl From<&bdk::TransactionDetails> for TransactionDetails {
    fn from(x: &bdk::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            fee: x.clone().fee,
            txid: x.txid.to_string(),
            received: x.clone().received,
            sent: x.clone().sent,
        }
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[repr(C)]
pub enum Transaction {
    Unconfirmed {
        details: TransactionDetails,
    },
    Confirmed {
        details: TransactionDetails,
        confirmation: BlockConfirmationTime,
    },
}
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct BlockConfirmationTime {
    pub height: u32,
    pub timestamp: u64,
}
fn set_block_time(time: BlockTime) -> BlockConfirmationTime {
    BlockConfirmationTime {
        height: time.height,
        timestamp: time.timestamp,
    }
}
impl From<&bdk::TransactionDetails> for Transaction {
    fn from(x: &bdk::TransactionDetails) -> Transaction {
        match x.confirmation_time.clone() {
            Some(block_time) => Transaction::Confirmed {
                details: TransactionDetails::from(x),
                confirmation: set_block_time(block_time),
            },
            None => Transaction::Unconfirmed {
                details: TransactionDetails::from(x),
            },
        }
    }
}

pub struct Wallet {
    pub(crate) wallet_mutex: Mutex<BdkWallet<MemoryDatabase>>,
}
impl Wallet {
    pub(crate) fn default() -> Wallet {
        let res = Mutex::new(BdkWallet::new(
            "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)",
            None,
            Network::Testnet,
            MemoryDatabase::default(),
        ).unwrap());
        Wallet { wallet_mutex: res }
    }
    pub(crate) fn new(
        descriptor: String,
        change_descriptor: Option<String>,
        network: Network,
    ) -> Result<Self, BdkError> {
        let res = Mutex::new(
            BdkWallet::new(
                &descriptor,
                change_descriptor.as_ref(),
                network,
                MemoryDatabase::default(),
            )
                .unwrap(),
        );
        Ok(Wallet { wallet_mutex: res })
    }
    pub(crate) fn get_wallet(&self) -> MutexGuard<BdkWallet<MemoryDatabase>> {
        self.wallet_mutex.lock().expect("wallet")
    }
    pub(crate) fn get_network(&self) -> Network {
        self.get_wallet().network()
    }
    pub(crate) fn sync(&self, blockchain: &AnyBlockchain) {
        // let bl =   Blockchain{ blockchain_mutex: blockchain.blockchain_mutex };
        self.get_wallet()
            .sync(blockchain, SyncOptions::default())
            .unwrap();
    }
    pub(crate) fn get_balance(&self) -> Result<u64, BdkError> {
        self.get_wallet().get_balance()
    }
    pub(crate) fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
    }
    pub(crate) fn get_transactions(&self) -> Result<Vec<Transaction>, Error> {
        let transactions = self.get_wallet().list_transactions(true).unwrap();
        Ok(transactions.iter().map(Transaction::from).collect())
    }
    pub(crate) fn sign(&self, psbt: &PartiallySignedBitcoinTransaction) -> Result<bool, Error> {
        let mut psbt = psbt.internal.lock().unwrap();
        self.get_wallet().sign(&mut psbt, SignOptions::default())
    }
}

pub struct PartiallySignedBitcoinTransaction {
    pub(crate) internal: Mutex<PartiallySignedTransaction>,
}
impl PartiallySignedBitcoinTransaction {
    pub(crate) fn new(psbt_base64: String) -> Result<Self, Error> {
        let psbt: PartiallySignedTransaction = PartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(PartiallySignedBitcoinTransaction {
            internal: Mutex::new(psbt),
        })
    }

    pub(crate) fn serialize(&self) -> String {
        let psbt = self.internal.lock().unwrap().clone();
        psbt.to_string()
    }

    pub(crate) fn txid(&self) -> String {
        let tx = self.internal.lock().unwrap().clone().extract_tx();
        let txid = tx.txid();
        txid.to_hex()
    }
}
fn to_script_pubkey(address: &str) -> Result<Script, BdkError> {
    Address::from_str(address)
        .map(|x| x.script_pubkey())
        .map_err(|e| BdkError::Generic(e.to_string()))
}

#[derive(Clone, Debug)]
enum RbfValue {
    Default,
    Value(u32),
}

#[derive(Clone, Debug)]
pub struct TxBuilder {
    recipients: Vec<(String, u64)>,
    fee_rate: Option<f32>,
    drain_wallet: bool,
    drain_to: Option<String>,
    rbf: Option<RbfValue>,
    data: Vec<u8>,
}

impl TxBuilder {
    pub(crate) fn new() -> Self {
        TxBuilder {
            recipients: Vec::new(),
            fee_rate: None,
            drain_wallet: false,
            drain_to: None,
            rbf: None,
            data: Vec::new(),
        }
    }

    pub(crate) fn add_recipient(&self, recipient: String, amount: u64) -> Arc<Self> {
        let mut recipients = self.recipients.to_vec();
        recipients.append(&mut vec![(recipient, amount)]);
        Arc::new(TxBuilder {
            recipients,
            ..self.clone()
        })
    }

    pub(crate) fn fee_rate(&self, sat_per_vb: f32) -> Arc<Self> {
        Arc::new(TxBuilder {
            fee_rate: Some(sat_per_vb),
            ..self.clone()
        })
    }

    pub(crate) fn drain_wallet(&self) -> Arc<Self> {
        Arc::new(TxBuilder {
            drain_wallet: true,
            ..self.clone()
        })
    }

    pub(crate) fn drain_to(&self, address: String) -> Arc<Self> {
        Arc::new(TxBuilder {
            drain_to: Some(address),
            ..self.clone()
        })
    }

    pub(crate) fn enable_rbf(&self) -> Arc<Self> {
        Arc::new(TxBuilder {
            rbf: Some(RbfValue::Default),
            ..self.clone()
        })
    }

    pub(crate) fn enable_rbf_with_sequence(&self, nsequence: u32) -> Arc<Self> {
        Arc::new(TxBuilder {
            rbf: Some(RbfValue::Value(nsequence)),
            ..self.clone()
        })
    }

    pub(crate) fn add_data(&self, data: Vec<u8>) -> Arc<Self> {
        Arc::new(TxBuilder {
            data,
            ..self.clone()
        })
    }

    pub(crate) fn finish(
        &self,
        wallet: &Wallet,
    ) -> Result<Arc<PartiallySignedBitcoinTransaction>, Error> {
        let wallet = wallet.get_wallet();
        let mut tx_builder = wallet.build_tx();
        for (address, amount) in &self.recipients {
            tx_builder.add_recipient(to_script_pubkey(address)?, *amount);
        }
        if let Some(sat_per_vb) = self.fee_rate {
            tx_builder.fee_rate(FeeRate::from_sat_per_vb(sat_per_vb));
        }
        if self.drain_wallet {
            tx_builder.drain_wallet();
        }
        if let Some(address) = &self.drain_to {
            tx_builder.drain_to(to_script_pubkey(address)?);
        }
        if let Some(rbf) = &self.rbf {
            match *rbf {
                RbfValue::Default => {
                    tx_builder.enable_rbf();
                }
                RbfValue::Value(nsequence) => {
                    tx_builder.enable_rbf_with_sequence(nsequence);
                }
            }
        }
        tx_builder
            .finish()
            .map(|(psbt, _)| PartiallySignedBitcoinTransaction {
                internal: Mutex::new(psbt),
            })
            .map(Arc::new)
    }
}
pub fn generate_extended_key(
    network: Network,
    word_count: WordCount,
    entropy: u8,
    password: Option<String>,
) -> Result<ExtendedKeyInfo, Error> {
    let entropy_ar = [entropy; 32];
    let mnemonic: GeneratedKey<_, BareCtx> =
        Mnemonic::generate_with_entropy((word_count, Language::English), entropy_ar).unwrap();
    let mnemonic: Mnemonic = mnemonic.into_key();
    let xkey: ExtendedKey = (mnemonic.clone(), password).into_extended_key()?;
    let xprv = xkey.into_xprv(network).unwrap();
    Ok(ExtendedKeyInfo {
        mnemonic: mnemonic.to_string(),
        xprv: xprv.to_string(),
        fingerprint: xprv.fingerprint(&Secp256k1::new()).to_string(),
    })
}

pub fn restore_extended_key(
    network: Network,
    mnemonic: String,
    password: Option<String>,
) -> Result<ExtendedKeyInfo, Error> {
    let mnemonic = Mnemonic::parse_in(Language::English, mnemonic).unwrap();
    let xkey: ExtendedKey = (mnemonic.clone(), password).into_extended_key().unwrap();
    let xprv = xkey.into_xprv(network).unwrap();
    let fingerprint = xprv.fingerprint(&Secp256k1::new());
    Ok(ExtendedKeyInfo {
        mnemonic: mnemonic.to_string(),
        xprv: xprv.to_string(),
        fingerprint: fingerprint.to_string(),
    })
}
