use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex};

pub use crate::ffi::BlockchainInstance;
pub use crate::ffi::WalletInstance;
use bdk::bitcoin::hashes::hex::ToHex;
use bdk::bitcoin::{Address as BdkAddress, OutPoint as BdkOutPoint, Txid};
use bdk::keys::DescriptorSecretKey as BdkDescriptorSecretKey;
use bdk::wallet::tx_builder::ChangeSpendPolicy;
use bdk::{Error, FeeRate};
use flutter_rust_bridge::{RustOpaque};

use crate::ffi::{
    to_script_pubkey, Address, DerivationPath, DescriptorPublicKey, DescriptorSecretKey, Mnemonic,
    PartiallySignedTransaction, Script,
};
use crate::types::{
    AddressIndex, AddressInfo, Balance, BlockchainConfig, DatabaseConfig, LocalUtxo, Network,
    OutPoint, ScriptAmount, TransactionDetails, TxBuilderResult, WordCount,
};
use crate::utils::{config_bdk_network, config_network, config_word_count};

//========Blockchain==========

pub fn blockchain_init(config: BlockchainConfig) -> RustOpaque<BlockchainInstance> {
    let blockchain = BlockchainInstance::new(config);
    return match blockchain.is_err() {
        false => RustOpaque::new(blockchain.unwrap()),
        true => panic!("Error creating blockchain"),
    };
}

pub fn get_blockchain_height(blockchain: RustOpaque<BlockchainInstance>) -> u32 {
    blockchain.get_height().unwrap()
}

pub fn get_blockchain_hash(
    blockchain_height: u32,
    blockchain: RustOpaque<BlockchainInstance>,
) -> String {
    blockchain.get_block_hash(blockchain_height).unwrap()
}

pub fn broadcast(psbt_str: String, blockchain: RustOpaque<BlockchainInstance>) -> String {
    let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
    blockchain.broadcast(&psbt).unwrap()
}

//========Psbt==========

pub fn psbt_to_txid(psbt_str: String) -> String {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    psbt.unwrap().txid().to_string()
}

pub fn extract_tx(psbt_str: String) -> Vec<u8> {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    psbt.unwrap().extract_tx()
}
pub fn get_fee_rate(psbt_str: String) -> f32 {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    psbt.unwrap().fee_rate().unwrap().as_sat_per_vb()
}
pub fn combine_psbt(psbt_str: String, other: String) -> String {
    let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
    let other = PartiallySignedTransaction::new(other).unwrap();
    psbt.combine(Arc::new(other)).unwrap().serialize()
}

//========TxBuilder==========
pub fn tx_builder_finish(
    wallet: RustOpaque<WalletInstance>,
    recipients: Vec<ScriptAmount>,
    utxos: Vec<OutPoint>,
    unspendable: Vec<OutPoint>,
    manually_selected_only: bool,
    only_spend_change: bool,
    do_not_spend_change: bool,
    fee_rate: Option<f32>,
    fee_absolute: Option<u64>,
    drain_wallet: bool,
    drain_to: Option<String>,
    enable_rbf: bool,
    n_sequence: Option<u32>,
    data: Vec<u8>,
) -> TxBuilderResult {
    let binding = wallet.get_wallet();
    let mut tx_builder = binding.build_tx();

    for e in recipients {
        let script = Script::from_hex(e.script).unwrap();
        tx_builder.add_recipient(script.script, e.amount);
    }
    if do_not_spend_change {
        tx_builder.change_policy(ChangeSpendPolicy::ChangeForbidden);
    }
    if only_spend_change {
        tx_builder.change_policy(ChangeSpendPolicy::OnlyChange);
    }
    tx_builder.change_policy(ChangeSpendPolicy::ChangeAllowed);
    if !utxos.is_empty() {
        let bdk_utxos: Vec<BdkOutPoint> = utxos.iter().map(BdkOutPoint::from).collect();
        let utxos: &[BdkOutPoint] = &bdk_utxos;
        tx_builder.add_utxos(utxos).unwrap();
    }
    if !unspendable.is_empty() {
        let bdk_unspendable: Vec<BdkOutPoint> = unspendable.iter().map(BdkOutPoint::from).collect();
        tx_builder.unspendable(bdk_unspendable);
    }
    if manually_selected_only {
        tx_builder.manually_selected_only();
    }
    if let Some(sat_per_vb) = fee_rate {
        tx_builder.fee_rate(FeeRate::from_sat_per_vb(sat_per_vb));
    }
    if let Some(fee_amount) = fee_absolute {
        tx_builder.fee_absolute(fee_amount);
    }
    if drain_wallet {
        tx_builder.drain_wallet();
    }
    if let Some(address) = drain_to {
        tx_builder.drain_to(to_script_pubkey(address.as_str()).unwrap());
    }
    if enable_rbf {
        tx_builder.enable_rbf();
    }
    if let Some(n_sequence) = n_sequence {
        tx_builder.enable_rbf_with_sequence(bdk::bitcoin::Sequence(n_sequence));
    }
    if !data.is_empty() {
        tx_builder.add_data(data.as_slice());
    }

    let (psbt, tx_details) = tx_builder.finish().unwrap();
    TxBuilderResult {
        psbt: Arc::new(PartiallySignedTransaction {
            internal: Mutex::new(psbt),
        })
        .serialize(),
        transaction_details: TransactionDetails::from(&tx_details),
    }
}

//========BumpFeeTxBuilder==========

pub fn bump_fee_tx_builder_finish(
    txid: String,
    fee_rate: f32,
    allow_shrinking: Option<String>,
    wallet: RustOpaque<WalletInstance>,
    enable_rbf: bool,
    n_sequence: Option<u32>,
) -> String {
    let txid = Txid::from_str(txid.as_str()).unwrap();
    let bdk_wallet = wallet.get_wallet();
    let mut tx_builder = match bdk_wallet.build_fee_bump(txid) {
        Ok(e) => e,
        Err(e) => {
            panic!("Bum:{:?}", e)
        }
    };
    tx_builder.fee_rate(FeeRate::from_sat_per_vb(fee_rate));
    if let Some(allow_shrinking) = &allow_shrinking {
        let address = BdkAddress::from_str(allow_shrinking)
            .map_err(|e| Error::Generic(e.to_string()))
            .unwrap();
        let script = address.script_pubkey();
        tx_builder.allow_shrinking(script).unwrap();
    }
    if let Some(n_sequence) = n_sequence {
        tx_builder.enable_rbf_with_sequence(bdk::bitcoin::Sequence(n_sequence));
    }
    if enable_rbf {
        tx_builder.enable_rbf();
    }
    let psbt = tx_builder.finish().map(|(psbt, _)| {
        PartiallySignedTransaction {
            internal: Mutex::new(psbt),
        }
        .serialize()
    });
    psbt.unwrap()
}

//================Descriptor Secret=========

pub fn descriptor_secret_extend(xprv: String, path: String) -> String {
    let res = descriptor_secret_config(xprv, Some(path), false);
    res.as_string()
}

pub fn descriptor_secret_derive(xprv: String, path: String) -> String {
    let res = descriptor_secret_config(xprv, Some(path), true);
    res.as_string()
}

pub fn descriptor_secret_as_secret_bytes(
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) -> Vec<u8> {
    let key = match descriptor_secret.is_some() {
        true => descriptor_secret.unwrap(),
        false => xprv.unwrap(),
    };
    let secret = match BdkDescriptorSecretKey::from_str(key.as_str()) {
        Ok(e) => e,
        Err(e) => {
            panic!("DescriptorSecret Parse Error:{:?}", e)
        }
    };
    let descriptor_secret = DescriptorSecretKey {
        descriptor_secret_key_mutex: Mutex::new(secret),
    };
    match descriptor_secret.secret_bytes() {
        Ok(e) => e,
        Err(e) => {
            panic!("DescriptorSecret Public Error:{:?}", e)
        }
    }
}

pub fn descriptor_secret_as_public(
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) -> String {
    let key = match descriptor_secret.is_some() {
        true => descriptor_secret.unwrap(),
        false => xprv.unwrap(),
    };
    let secret = match BdkDescriptorSecretKey::from_str(key.as_str()) {
        Ok(e) => e,
        Err(e) => {
            panic!("DescriptorSecret Parse Error:{:?}", e)
        }
    };
    let descriptor_secret = DescriptorSecretKey {
        descriptor_secret_key_mutex: Mutex::new(secret),
    };
    match descriptor_secret.as_public() {
        Ok(e) => e.as_string(),
        Err(e) => {
            panic!("DescriptorSecret Public Error:{:?}", e)
        }
    }
}

fn descriptor_secret_config(
    xprv: String,
    path: Option<String>,
    is_derive: bool,
) -> Arc<DescriptorSecretKey> {
    let secret = match BdkDescriptorSecretKey::from_str(xprv.as_str()) {
        Ok(e) => e,
        Err(e) => {
            panic!("DescriptorSecret Parse Error:{:?}", e)
        }
    };
    let descriptor_secret = DescriptorSecretKey {
        descriptor_secret_key_mutex: Mutex::new(secret),
    };

    if path.is_none() {
        return Arc::new(descriptor_secret);
    }
    let derivation_path = Arc::new(DerivationPath::new(path.unwrap().to_string()).unwrap());
    return if is_derive {
        match descriptor_secret.derive(derivation_path) {
            Ok(e) => e,
            Err(e) => {
                panic!("DescriptorSecret Derive Error:{:?}", e)
            }
        }
    } else {
        match descriptor_secret.extend(derivation_path) {
            Ok(e) => e,
            Err(e) => {
                panic!("DescriptorSecret Extend Error:{:?}", e)
            }
        }
    };
}

pub fn create_descriptor_secret(
    network: Network,
    mnemonic: String,
    password: Option<String>,
) -> String {
    let node_network = config_network(network);
    let mnemonic = Mnemonic::from_str(mnemonic).unwrap();
    return match DescriptorSecretKey::new(node_network, mnemonic, password) {
        Ok(e) => e.as_string(),
        Err(e) => {
            panic!("DescriptorSecret Init Error:{:?}", e)
        }
    };
}

//==============Derivation Path ==========
pub fn create_derivation_path(path: String) -> String {
    return match DerivationPath::new(path) {
        Ok(e) => e.as_string(),
        Err(e) => {
            panic!("DerivationPath Parse Error:{:?}", e)
        }
    };
}

//================Descriptor Public=========

pub fn create_descriptor_public(xpub: Option<String>, path: String, derive: bool) -> String {
    let derivation_path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
    let descriptor_public = DescriptorPublicKey::from_string(xpub.unwrap()).unwrap();
    return if derive {
        match descriptor_public.clone().derive(derivation_path) {
            Ok(e) => e.as_string(),
            Err(e) => {
                panic!("DescriptorPublic Derivation error:{:?}", e)
            }
        }
    } else {
        match descriptor_public.clone().extend(derivation_path) {
            Ok(e) => e.as_string(),
            Err(e) => {
                panic!("DescriptorPublic Extend error:{:?}", e)
            }
        }
    };
}

//============ Script Class===========
pub fn init_script(raw_output_script: Vec<u8>) -> String {
    return match Script::new(raw_output_script) {
        Ok(e) => e.script.to_hex(),
        Err(e) => {
            panic!("DerivationPath Parse Error:{:?}", e)
        }
    };
}

//================Address============
pub fn init_address(address: String) -> String {
    return match Address::new(address) {
        Ok(e) => e.address.to_string(),
        Err(e) => {
            panic!("AddressError, {:?}", e)
        }
    };
}

pub fn address_to_script_pubkey_hex(address: String) -> String {
    let script = Address::new(address).unwrap();
    script.script_pubkey().script.to_hex()
}

//========Wallet==========

pub fn wallet_init(
    descriptor: String,
    change_descriptor: Option<String>,
    network: Network,
    database_config: DatabaseConfig,
) -> RustOpaque<WalletInstance> {
    let node_network = config_network(network.clone());
    let wallet_obj = WalletInstance::new(
        descriptor.clone(),
        change_descriptor,
        node_network,
        database_config,
    )
    .unwrap();
    RustOpaque::new(wallet_obj)
}

//Return a derived address using the external descriptor,

pub fn get_address(wallet: RustOpaque<WalletInstance>, address_index: AddressIndex) -> AddressInfo {
    let address = wallet.get_address(address_index).unwrap();
    address
}

pub fn sync_wallet(wallet: RustOpaque<WalletInstance>, blockchain: RustOpaque<BlockchainInstance>) {
    wallet.sync(blockchain.deref());
}

pub fn get_balance(wallet: RustOpaque<WalletInstance>) -> Balance {
    let balance = wallet.get_balance().unwrap();
    balance
}

//Return the list of unspent outputs of this wallet
pub fn list_unspent_outputs(wallet: RustOpaque<WalletInstance>) -> Vec<LocalUtxo> {
    let unspent = wallet.list_unspent();
    unspent.unwrap()
}

pub fn get_transactions(wallet: RustOpaque<WalletInstance>) -> Vec<TransactionDetails> {
    wallet.list_transactions().unwrap()
}

pub fn sign(
    wallet: RustOpaque<WalletInstance>,
    psbt_str: String,
    is_multi_sig: bool,
) -> Option<String> {
    let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
    return match wallet.sign(&psbt).unwrap() {
        true => Some(psbt.serialize()),
        false => {
            if is_multi_sig {
                Some(psbt.serialize())
            } else {
                None
            }
        }
    };
}

pub fn get_network(wallet: RustOpaque<WalletInstance>) -> Network {
    let network = config_bdk_network(wallet.get_wallet().network());
    network
}

pub fn list_unspent(wallet: RustOpaque<WalletInstance>) -> Vec<LocalUtxo> {
    wallet.list_unspent().unwrap()
}

//================== Mnemonic ==========

pub fn generate_seed_from_word_count(word_count: WordCount) -> String {
    let word_count = config_word_count(word_count);
    let mnemonic = Mnemonic::new(word_count);
    mnemonic.as_string()
}

pub fn generate_seed_from_string(mnemonic: String) -> String {
    let mnemonic = Mnemonic::from_str(mnemonic);
    match mnemonic {
        Ok(e) => e.as_string(),
        Err(e) => {
            panic!("MnemonicError, {:?}", e)
        }
    }
}

pub fn generate_seed_from_entropy(entropy: Vec<u8>) -> String {
    let mnemonic = Mnemonic::from_entropy(entropy);
    match mnemonic {
        Ok(e) => e.as_string(),
        Err(e) => {
            panic!("MnemonicError, {:?}", e)
        }
    }
}
