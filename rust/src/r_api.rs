use std::collections::hash_map::DefaultHasher;
use std::collections::HashMap;
use std::hash::{Hash, Hasher};
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex, RwLock};

use bdk::{Error, FeeRate};
use bdk::bitcoin::{Address as BdkAddress, OutPoint as BdkOutPoint, Txid};
use bdk::bitcoin::hashes::hex::ToHex;
use bdk::blockchain::{AnyBlockchain, Blockchain as BdkBlockChain, GetBlockHash, GetHeight};
use bdk::keys::DescriptorSecretKey as BdkDescriptorSecretKey;
use bdk::wallet::tx_builder::ChangeSpendPolicy;
use lazy_static::lazy_static;

use crate::ffi::{Address, DerivationPath, DescriptorPublicKey, DescriptorSecretKey, generate_mnemonic_from_word_count, PartiallySignedBitcoinTransaction, Script, to_script_pubkey, Wallet};
use crate::types::{AddressIndex, AddressInfo, Balance, BlockchainConfig, DatabaseConfig, LocalUtxo, Network, OutPoint, ScriptAmount, TransactionDetails, TxBuilderResult, WordCount};
use crate::utils::{config_bdk_network, config_blockchain, config_network, config_word_count};

lazy_static! {
      static ref BLOCKCHAIN: RwLock<HashMap<String, Arc<AnyBlockchain>>> = RwLock::new(HashMap::new());
     static ref WALLET: RwLock<HashMap<String, Arc<Wallet>>> = RwLock::new(HashMap::new());
}
fn to_hash(str: String) -> u64 {
    let mut hasher = DefaultHasher::new();
    str.clone().hash(&mut hasher);
    let x = hasher.finish();
    x
}

//========Blockchain==========
fn get_blockchain_(blockchain_id: String, blockchain_map: HashMap<String, Arc<AnyBlockchain>>) -> Result<Arc<AnyBlockchain>, Error> {
    let blockchain = blockchain_map.get(blockchain_id.as_str()).unwrap();
    Ok(blockchain.clone())
}

pub fn blockchain_init(config: BlockchainConfig) -> String {
    let blockchain_obj = Arc::new(config_blockchain(config));
    let mut any_blockchain = BLOCKCHAIN.write().unwrap();
    let hash = to_hash(blockchain_obj.clone().get_height().unwrap().to_string()).to_hex();
    let mut blockchain_map = any_blockchain.clone();
    blockchain_map.insert(hash.clone(), blockchain_obj.clone());
    *any_blockchain = blockchain_map;
    hash
}

pub fn get_blockchain_height(blockchain_id: String) -> u32 {
    let any_blockchain = BLOCKCHAIN.read().unwrap().clone();
    let blockchain = get_blockchain_(blockchain_id, any_blockchain).unwrap();
    blockchain.get_height().unwrap()
}

pub fn get_blockchain_hash(blockchain_height: u64, id: String) -> String {
    let any_blockchain = BLOCKCHAIN.read().unwrap().clone();
    let blockchain = get_blockchain_(id, any_blockchain).unwrap();
    let x = blockchain
        .get_block_hash(blockchain_height)
        .unwrap()
        .as_hash()
        .to_string();
    x
}

pub fn broadcast(psbt_str: String, blockchain_id: String) -> String {
    let any_blockchain = BLOCKCHAIN.read().unwrap().clone();
    let blockchain = get_blockchain_(blockchain_id, any_blockchain).unwrap();
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    let tx = psbt.internal.lock().unwrap().clone().extract_tx();
    blockchain.broadcast(&tx.clone()).unwrap();
    tx.txid().to_string()
}

//========Psbt==========

pub fn psbt_to_txid(psbt_str: String) -> String {
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str);
    psbt.unwrap().txid().to_string()
}

pub fn extract_tx(psbt_str: String) -> Vec<u8> {
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str);
    psbt.unwrap().extract_tx()
}

pub fn combine_psbt(psbt_str: String, other: String) -> String {
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    let other = PartiallySignedBitcoinTransaction::new(other).unwrap();
    psbt.combine(Arc::new(other)).unwrap().serialize()
}

//========TxBuilder==========
pub fn tx_builder_finish(
    wallet_id: String,
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
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let wallet = wallet.get_wallet();
    let mut tx_builder = wallet.build_tx();
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
        tx_builder.enable_rbf_with_sequence(n_sequence);
    }
    if !data.is_empty() {
        tx_builder.add_data(data.as_slice());
    }

    let (psbt, tx_details) = tx_builder.finish().unwrap();
    TxBuilderResult {
        psbt: Arc::new(PartiallySignedBitcoinTransaction {
            internal: Mutex::new(psbt),
        }).serialize(),
        transaction_details: TransactionDetails::from(&tx_details),
    }
}

//========BumpFeeTxBuilder==========

pub fn bump_fee_tx_builder_finish(
    txid: String,
    fee_rate: f32,
    allow_shrinking: Option<String>,
    wallet_id: String,
    enable_rbf: bool,
    n_sequence: Option<u32>,
) -> String {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let txid = Txid::from_str(txid.as_str()).unwrap();
    let bdk_wallet = wallet.get_wallet();

    let mut tx_builder = match bdk_wallet.build_fee_bump(txid) {
        Ok(e) => { e }
        Err(e) => { panic!("Bum:{:?}", e) }
    };
    tx_builder.fee_rate(FeeRate::from_sat_per_vb(fee_rate));
    if let Some(allow_shrinking) = &allow_shrinking {
        let address = BdkAddress::from_str(allow_shrinking).map_err(|e| Error::Generic(e.to_string())).unwrap();
        let script = address.script_pubkey();
        tx_builder.allow_shrinking(script).unwrap();
    }
    if let Some(n_sequence) = n_sequence {
        tx_builder.enable_rbf_with_sequence(n_sequence);
    }
    if enable_rbf {
        tx_builder.enable_rbf();
    }
    let psbt = tx_builder
        .finish()
        .map(|(psbt, _)| PartiallySignedBitcoinTransaction {
            internal: Mutex::new(psbt),
        }.serialize());
    psbt.unwrap()
}

//================Descriptor Secret=========

pub fn descriptor_secret_extend(
    xprv: String,
    path: String,
) -> String {
    let res = descriptor_secret_config(xprv, Some(path), false);
    res.as_string()
}

pub fn descriptor_secret_derive(
    xprv: String,
    path: String,
) -> String {
    let res = descriptor_secret_config(xprv, Some(path), true);
    res.as_string()
}

pub fn descriptor_secret_as_secret_bytes(
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) -> Vec<u8> {
    let key = match descriptor_secret.is_some() {
        true => { descriptor_secret.unwrap() }
        false => { xprv.unwrap() }
    };
    let secret = match BdkDescriptorSecretKey::from_str(key.as_str()) {
        Ok(e) => e,
        Err(e) => { panic!("DescriptorSecret Parse Error:{:?}", e) }
    };
    let descriptor_secret = DescriptorSecretKey { descriptor_secret_key_mutex: Mutex::new(secret) };
    match descriptor_secret.secret_bytes() {
        Ok(e) => { e }
        Err(e) => { panic!("DescriptorSecret Public Error:{:?}", e) }
    }
}

pub fn descriptor_secret_as_public(
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) -> String {
    let key = match descriptor_secret.is_some() {
        true => { descriptor_secret.unwrap() }
        false => { xprv.unwrap() }
    };
    let secret = match BdkDescriptorSecretKey::from_str(key.as_str()) {
        Ok(e) => e,
        Err(e) => { panic!("DescriptorSecret Parse Error:{:?}", e) }
    };
    let descriptor_secret = DescriptorSecretKey { descriptor_secret_key_mutex: Mutex::new(secret) };
    match descriptor_secret.as_public() {
        Ok(e) => { e.as_string() }
        Err(e) => { panic!("DescriptorSecret Public Error:{:?}", e) }
    }
}

fn descriptor_secret_config(
    xprv: String,
    path: Option<String>,
    is_derive: bool,
) -> Arc<DescriptorSecretKey>
{
    let secret = match BdkDescriptorSecretKey::from_str(xprv.as_str()) {
        Ok(e) => e,
        Err(e) => { panic!("DescriptorSecret Parse Error:{:?}", e) }
    };
    let descriptor_secret = DescriptorSecretKey { descriptor_secret_key_mutex: Mutex::new(secret) };

    if path.is_none() {
        return Arc::new(descriptor_secret);
    }
    let derivation_path = Arc::new(DerivationPath::new(path.unwrap().to_string()).unwrap());
    return if is_derive {
        match descriptor_secret.derive(derivation_path) {
            Ok(e) => { e }
            Err(e) => { panic!("DescriptorSecret Derive Error:{:?}", e) }
        }
    } else {
        match descriptor_secret.extend(derivation_path) {
            Ok(e) => { e }
            Err(e) => { panic!("DescriptorSecret Extend Error:{:?}", e) }
        }
    };
}

pub fn create_descriptor_secret(network: Network,
                                mnemonic: String,
                                password: Option<String>) -> String {
    let node_network = config_network(network);
    return match DescriptorSecretKey::new(node_network, mnemonic, password) {
        Ok(e) => { e.as_string() }
        Err(e) => { panic!("DescriptorSecret Init Error:{:?}", e) }
    };
}

//==============Derivation Path ==========
pub fn create_derivation_path(path: String) -> String {
    return match DerivationPath::new(path) {
        Ok(e) => { e.as_string() }
        Err(e) => { panic!("DerivationPath Parse Error:{:?}", e) }
    };
}

//================Descriptor Public=========


pub fn create_descriptor_public(
    xpub: Option<String>,
    path: String,
    derive: bool,
) -> String {
    let derivation_path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
    let descriptor_public = DescriptorPublicKey::from_string(xpub.unwrap()).unwrap();
    return if derive {
        match descriptor_public.clone().derive(derivation_path) {
            Ok(e) => { e.as_string() }
            Err(e) => { panic!("DescriptorPublic Derivation error:{:?}", e) }
        }
    } else {
        match descriptor_public.clone().extend(derivation_path) {
            Ok(e) => { e.as_string() }
            Err(e) => { panic!("DescriptorPublic Extend error:{:?}", e) }
        }
    };
}

//============ Script Class===========
pub fn init_script(raw_output_script: Vec<u8>) -> String {
    return match Script::new(raw_output_script) {
        Ok(e) => { e.script.to_hex() }
        Err(e) => { panic!("DerivationPath Parse Error:{:?}", e) }
    };
}

//================Address============
pub fn init_address(address: String) -> String {
    return match Address::new(address) {
        Ok(e) => { e.address.to_string() }
        Err(e) => { panic!("AddressError, {:?}", e) }
    };
}

pub fn address_to_script_pubkey_hex(address: String) -> String {
    let script = Address::new(address).unwrap();
    script.script_pubkey().script.to_hex()
}

//========Wallet==========
fn set_wallet(
    wallet: Arc<Wallet>,
) -> String {
    let mut wallets = WALLET.write().unwrap();
    let pub_descriptor = wallet.get_public_descriptor().unwrap().unwrap().to_string();
    let wallet_id = to_hash(pub_descriptor).to_hex();
    println!("{}", wallet_id);
    let mut wallet_map = wallets.clone();
    wallet_map.insert(wallet_id.clone(), wallet);
    *wallets = wallet_map;
    wallet_id.clone()
}


pub fn wallet_init(
    descriptor: String,
    change_descriptor: Option<String>,
    network: Network,
    database_config: DatabaseConfig,
) ->
    String {
    let node_network = config_network(network.clone());
    let wallet_obj = Wallet::new(
        descriptor.clone(),
        change_descriptor,
        node_network,
        database_config,
    )
        .unwrap();
    let wallet = Arc::new(wallet_obj);
    let id = set_wallet(wallet.clone());
    id
}

fn get_wallet_(wallet_id: String, wallet_map: HashMap<String, Arc<Wallet>>) -> Result<Arc<Wallet>, Error> {
    let wallet = wallet_map.get(wallet_id.as_str()).unwrap();
    Ok(wallet.clone())
}

//Return a derived address using the external descriptor,
pub fn get_address(wallet_id: String, address_index: AddressIndex) -> AddressInfo {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let address = wallet.get_address(address_index).unwrap();
    address
}

pub fn sync_wallet(wallet_id: String, blockchain_id: String) {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let blockchains = BLOCKCHAIN.read().unwrap().clone();
    let blockchain = get_blockchain_(blockchain_id, blockchains).unwrap();
    wallet.sync(blockchain.deref());
}

pub fn get_balance(wallet_id: String) -> Balance {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let balance = wallet.get_balance().unwrap();
    balance
}

//Return the list of unspent outputs of this wallet
pub fn list_unspent_outputs(wallet_id: String) -> Vec<LocalUtxo> {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let unspent = wallet.list_unspent();
    unspent.unwrap()
}


pub fn get_transactions(wallet_id: String) -> Vec<TransactionDetails> {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    wallet.list_transactions().unwrap()
}

pub fn sign(wallet_id: String, psbt_str: String, is_multi_sig: bool) -> Option<String> {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    return match wallet.sign(&psbt).unwrap() {
        true => {
            Some(psbt.serialize())
        }
        false => {
            if is_multi_sig { Some(psbt.serialize()) } else { None }
        }
    };
}

pub fn get_network(wallet_id: String) -> Network {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    let network = config_bdk_network(wallet.get_wallet().network());
    network
}

pub fn list_unspent(wallet_id: String) -> Vec<LocalUtxo> {
    let wallets = WALLET.read().unwrap().clone();
    let wallet = get_wallet_(wallet_id, wallets).unwrap();
    wallet.list_unspent().unwrap()
}

//==================

pub fn generate_seed_from_word_count(word_count: WordCount) -> String {
    let word_count = config_word_count(word_count);
    let mnemonic = generate_mnemonic_from_word_count(word_count);
    mnemonic.to_string()
}


#[cfg(test)]
mod tests {
    use bdk::bitcoin::hashes::hex::FromHex;
    use bdk::bitcoin::Script;

    use crate::ffi::to_script_pubkey;
    use crate::r_api::{address_to_script_hex, blockchain_init, descriptor_secret_as_string, DescriptorKeyType, generate_seed_from_word_count, get_balance, get_transactions, sync_wallet, tx_builder_finish, wallet_init};
    use crate::types::{BlockchainConfig, DatabaseConfig, ElectrumConfig, Entropy, Network, ScriptAmount, WordCount};

    #[test]
    fn get_transactions_test() {
        let wallet_id = _init_wallet();
        let blockchain_id = _init_blockchain();
        sync_wallet(wallet_id.clone(), blockchain_id);
        assert_eq!(get_transactions(wallet_id).is_empty(), false);
    }

    #[test]
    fn get_wallet_balance_test() {
        let wallet_id = _init_wallet();
        let blockchain_id = _init_blockchain();
        sync_wallet(wallet_id.clone(), blockchain_id);
        let res = get_balance(wallet_id);
        assert_eq!(res.total, 1238709)
    }

    #[test]
    fn to_script() {
        let res = address_to_script_hex("tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt".to_string());
        let res2 = Script::from_hex(res.as_str()).unwrap().to_string();
        assert_eq!(res, res2)
    }

    #[test]
    fn tx_builder_test() {
        let wallet_id = _init_wallet();
        let blockchain_id = _init_blockchain();
        sync_wallet(wallet_id.clone(), blockchain_id);
        let a = tx_builder_finish(
            wallet_id.clone(),
            vec![ScriptAmount { script: "0014ff9da567e62f30ea8654fa1d5fbd47bef8e3be13".to_string(), amount: 1200 }],
            vec![],
            vec![],
            false,
            false,
            false,
            Some(1.0),
            None,
            false,
            None,
            false,
            None,
            vec![]);
        assert_eq!(a.psbt, "1238709")
    }

    fn _init_blockchain() -> String {
        let y = blockchain_init(BlockchainConfig::Electrum {
            config: ElectrumConfig {
                url: "ssl://electrum.blockstream.info:60002".to_string(),
                socks5: None,
                retry: 10,
                timeout: None,
                stop_gap: 10,
            }
        });
        y
    }

    fn _init_wallet() -> String {
        let x = wallet_init(
            "wpkh([d91e6add/84'/0'/0']tprv8gnnA5Zcbjai6d1mWvQatrK8c9eHfUAKSgJLoHfiryJb6gNBnQeAT7UuKKFmaBJUrc7pzyszqujrwxijJbDPBPi5edtPsm3jZ3pnNUzHbpm/*)".to_string(),
            Some("wpkh([d91e6add/84'/0'/1']tprv8gnnA5Zcbjai9Wfiec82h4oP8R92SNuNFFD5g8Kqu8hMd3kb8h93wGynk4vgCH3tfoGkDvCroMtqaiMGnqHudQoEYd89297VuybvNWfgPuL/*)".to_string()),
            Network::Testnet,
            DatabaseConfig::Memory,
        );
        x
    }

    #[test]
    fn generate_mnemonic_word_count_test() {
        let mnemonic = generate_seed_from_word_count(WordCount::Words12);
        assert_eq!(mnemonic.split(" ").count(), 12)
    }
}