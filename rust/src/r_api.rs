pub use crate::blockchain::{BlockchainConfig, BlockchainInstance};
pub use crate::descriptor::BdkDescriptor;
use crate::key::{DerivationPath, DescriptorPublicKey, DescriptorSecretKey, Mnemonic};
use crate::psbt::PartiallySignedTransaction;
pub use crate::psbt::Transaction;
use crate::types::{Address, AddressIndex, AddressInfo, Balance, BdkTxBuilderResult, KeychainKind, Network, OutPoint, Script, ScriptAmount, TransactionDetails,  WordCount};
pub use crate::wallet::{DatabaseConfig, WalletInstance};
use bdk::bitcoin::hashes::hex::ToHex;
use bdk::bitcoin::{Address as BdkAddress, OutPoint as BdkOutPoint, Txid};
use bdk::keys::DescriptorSecretKey as BdkDescriptorSecretKey;
use bdk::wallet::tx_builder::ChangeSpendPolicy;
use bdk::Error;
use flutter_rust_bridge::RustOpaque;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex};
//========Blockchain==========

pub fn blockchain_init(
    config: BlockchainConfig,
) -> anyhow::Result<RustOpaque<BlockchainInstance>, anyhow::Error> {
    let blockchain = BlockchainInstance::new(config);
    return match blockchain {
        Ok(e) => Ok(RustOpaque::new(e)),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

pub fn get_blockchain_height(
    blockchain: RustOpaque<BlockchainInstance>,
) -> anyhow::Result<u32, anyhow::Error> {
    return match blockchain.get_height() {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

pub fn get_blockchain_hash(
    blockchain_height: u32,
    blockchain: RustOpaque<BlockchainInstance>,
) -> anyhow::Result<String, anyhow::Error> {
    return match blockchain.get_block_hash(blockchain_height) {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
pub fn estimate_fee(
    target: u64,
    blockchain: RustOpaque<BlockchainInstance>,
) -> anyhow::Result<f32, anyhow::Error> {
    return match blockchain.estimate_fee(target) {
        Ok(e) => Ok(e.as_sat_per_vb()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

pub fn broadcast(
    tx: Vec<u8>,
    blockchain: RustOpaque<BlockchainInstance>,
) -> anyhow::Result<String, anyhow::Error> {
    let transaction = Transaction::new(tx).unwrap();
    return match blockchain.broadcast(transaction) {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
//=========Transaction===========
pub fn new_transaction(tx: Vec<u8>) -> anyhow::Result<Vec<u8>, anyhow::Error> {
    let res = Transaction::new(tx);
    match res {
        Ok(e) => Ok(e.serialize()),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

//========Psbt==========

pub fn psbt_to_txid(psbt_str: String) -> anyhow::Result<String, anyhow::Error> {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    return match psbt {
        Ok(e) => Ok(e.txid()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

pub fn extract_tx(psbt_str: String) -> anyhow::Result<Vec<u8>, anyhow::Error> {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    return match psbt {
        Ok(e) => Ok(e.extract_tx().serialize()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
pub fn get_psbt_fee_rate(psbt_str: String) -> Option<f32> {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    match psbt.unwrap().fee_rate() {
        None => None,
        Some(e) => Some(e.as_sat_per_vb()),
    }
}
pub fn get_fee_amount(psbt_str: String) -> Option<u64> {
    let psbt = PartiallySignedTransaction::new(psbt_str);
    psbt.unwrap().fee_amount()
}
pub fn combine_psbt(psbt_str: String, other: String) -> anyhow::Result<String, anyhow::Error> {
    let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
    let other = PartiallySignedTransaction::new(other).unwrap();
    return match psbt.combine(Arc::new(other)) {
        Ok(e) => Ok(e.serialize()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
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
) -> anyhow::Result<BdkTxBuilderResult, anyhow::Error> {
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
        tx_builder.fee_rate(bdk::FeeRate::from_sat_per_vb(sat_per_vb));
    }
    if let Some(fee_amount) = fee_absolute {
        tx_builder.fee_absolute(fee_amount);
    }
    if drain_wallet {
        tx_builder.drain_wallet();
    }
    if let Some(script_) = drain_to {
        let script = Script::from_hex(script_).unwrap();
        tx_builder.drain_to(script.script);
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

    return match tx_builder.finish() {
        Ok(e) => Ok(
            BdkTxBuilderResult(Arc::new(PartiallySignedTransaction {
                internal: Mutex::new(e.0),
            })
            .serialize(),
             TransactionDetails::from(&e.1),)
        ),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

//========BumpFeeTxBuilder==========

pub fn bump_fee_tx_builder_finish(
    txid: String,
    fee_rate: f32,
    allow_shrinking: Option<String>,
    wallet: RustOpaque<WalletInstance>,
    enable_rbf: bool,
    n_sequence: Option<u32>,
) -> anyhow::Result<BdkTxBuilderResult, anyhow::Error> {
    let txid = Txid::from_str(txid.as_str()).unwrap();
    let bdk_wallet = wallet.get_wallet();
    let mut tx_builder = match bdk_wallet.build_fee_bump(txid) {
        Ok(e) => e,
        Err(e) => anyhow::bail!("{:?}", e),
    };
    tx_builder.fee_rate(bdk::FeeRate::from_sat_per_vb(fee_rate));
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
    return match tx_builder.finish() {
        Ok(e) => Ok(
            BdkTxBuilderResult(Arc::new(PartiallySignedTransaction {
                internal: Mutex::new(e.0),
            })
                                   .serialize(),
                               TransactionDetails::from(&e.1),)
        ),
        Err(e) => anyhow::bail!("{:?}", e),
    };

}

//================Descriptor Secret=========

pub fn new_descriptor(
    descriptor: String,
    network: Network,
) -> anyhow::Result<RustOpaque<BdkDescriptor>, anyhow::Error> {
    return match BdkDescriptor::new(descriptor, network.into()) {
        Ok(e) => Ok(RustOpaque::new(e)),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
pub fn new_bip44_descriptor(
    key_chain_kind: KeychainKind,
    secret_key: String,
    network: Network,
) -> RustOpaque<BdkDescriptor> {
    let key = match DescriptorSecretKey::from_string(secret_key) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
    let descriptor = BdkDescriptor::new_bip44(key, key_chain_kind.into(), network.into());
    RustOpaque::new(descriptor)
}
pub fn new_bip44_public(
    key_chain_kind: KeychainKind,
    public_key: String,
    network: Network,
    fingerprint: String,
) -> RustOpaque<BdkDescriptor> {
    let key = match DescriptorPublicKey::from_string(public_key) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
    let descriptor =
        BdkDescriptor::new_bip44_public(key, fingerprint, key_chain_kind.into(), network.into());
    RustOpaque::new(descriptor)
}

pub fn new_bip49_descriptor(
    key_chain_kind: KeychainKind,
    secret_key: String,
    network: Network,
) -> RustOpaque<BdkDescriptor> {
    let key = match DescriptorSecretKey::from_string(secret_key) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
    let descriptor = BdkDescriptor::new_bip49(key, key_chain_kind.into(), network.into());
    RustOpaque::new(descriptor)
}
pub fn new_bip49_public(
    key_chain_kind: KeychainKind,
    public_key: String,
    network: Network,
    fingerprint: String,
) -> RustOpaque<BdkDescriptor> {
    let key = match DescriptorPublicKey::from_string(public_key) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
    let descriptor =
        BdkDescriptor::new_bip49_public(key, fingerprint, key_chain_kind.into(), network.into());
    RustOpaque::new(descriptor)
}

pub fn new_bip84_descriptor(
    key_chain_kind: KeychainKind,
    secret_key: String,
    network: Network,
) -> RustOpaque<BdkDescriptor> {
    let key = match DescriptorSecretKey::from_string(secret_key) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
    let descriptor = BdkDescriptor::new_bip84(key, key_chain_kind.into(), network.into());
    RustOpaque::new(descriptor)
}
pub fn new_bip84_public(
    key_chain_kind: KeychainKind,
    public_key: String,
    network: Network,
    fingerprint: String,
) -> RustOpaque<BdkDescriptor> {
    let key = match DescriptorPublicKey::from_string(public_key) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
    let descriptor =
        BdkDescriptor::new_bip84_public(key, fingerprint, key_chain_kind.into(), network.into());
    RustOpaque::new(descriptor)
}

pub fn as_string_private(descriptor: RustOpaque<BdkDescriptor>) -> String {
    descriptor.as_string_private()
}
pub fn as_string(descriptor: RustOpaque<BdkDescriptor>) -> String {
    descriptor.as_string()
}

//======================

pub fn create_descriptor_secret(
    network: Network,
    mnemonic: String,
    password: Option<String>,
) -> anyhow::Result<String, anyhow::Error> {
    let mnemonic = Mnemonic::from_str(mnemonic).unwrap();
    return match DescriptorSecretKey::new(network.into(), mnemonic, password) {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
pub fn descriptor_secret_from_string(xprv: String) -> anyhow::Result<String, anyhow::Error> {
    return match DescriptorSecretKey::from_string(xprv) {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
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
) -> anyhow::Result<Vec<u8>, anyhow::Error> {
    let key = match descriptor_secret.is_some() {
        true => descriptor_secret.unwrap(),
        false => xprv.unwrap(),
    };
    let secret = match BdkDescriptorSecretKey::from_str(key.as_str()) {
        Ok(e) => e,
        Err(e) => anyhow::bail!("{:?}", e),
    };
    let descriptor_secret = DescriptorSecretKey {
        descriptor_secret_key_mutex: Mutex::new(secret),
    };
    return match descriptor_secret.secret_bytes() {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

pub fn descriptor_secret_as_public(
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) -> anyhow::Result<String, anyhow::Error> {
    let key = match descriptor_secret.is_some() {
        true => descriptor_secret.unwrap(),
        false => xprv.unwrap(),
    };
    let secret = match BdkDescriptorSecretKey::from_str(key.as_str()) {
        Ok(e) => e,
        Err(e) => anyhow::bail!("{:?}", e),
    };
    let descriptor_secret = DescriptorSecretKey {
        descriptor_secret_key_mutex: Mutex::new(secret),
    };
    match descriptor_secret.as_public() {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

fn descriptor_secret_config(
    xprv: String,
    path: Option<String>,
    is_derive: bool,
) -> Arc<DescriptorSecretKey> {
    let secret = match BdkDescriptorSecretKey::from_str(xprv.as_str()) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
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
            Err(e) => panic!("{:?}", e),
        }
    } else {
        match descriptor_secret.extend(derivation_path) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        }
    };
}

//==============Derivation Path ==========
pub fn create_derivation_path(path: String) -> anyhow::Result<String, anyhow::Error> {
    return match DerivationPath::new(path) {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

//================Descriptor Public=========
pub fn descriptor_public_from_string(public_key: String) -> anyhow::Result<String, anyhow::Error> {
    return match DescriptorPublicKey::from_string(public_key) {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}
pub fn create_descriptor_public(
    xpub: Option<String>,
    path: String,
    derive: bool,
) -> anyhow::Result<String, anyhow::Error> {
    let derivation_path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
    let descriptor_public = DescriptorPublicKey::from_string(xpub.unwrap()).unwrap();
    return if derive {
        match descriptor_public.clone().derive(derivation_path) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    } else {
        match descriptor_public.clone().extend(derivation_path) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    };
}

//============ Script Class===========
pub fn init_script(raw_output_script: Vec<u8>) -> anyhow::Result<String, anyhow::Error> {
    return match Script::new(raw_output_script) {
        Ok(e) => Ok(e.script.to_hex()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

//================Address============
pub fn init_address(address: String) -> anyhow::Result<String, anyhow::Error> {
    return match Address::new(address) {
        Ok(e) => Ok(e.address.to_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    };
}

pub fn address_to_script_pubkey_hex(address: String) -> String {
    let script = Address::new(address).unwrap();
    script.script_pubkey().script.to_hex()
}

//========Wallet==========

pub fn wallet_init(
    descriptor: RustOpaque<BdkDescriptor>,
    change_descriptor: Option<RustOpaque<BdkDescriptor>>,
    network: Network,
    database_config: DatabaseConfig,
) -> anyhow::Result<RustOpaque<WalletInstance>, anyhow::Error> {
    match WalletInstance::new(
        Arc::new(descriptor),
        change_descriptor.map(|x| Arc::new(x)),
        network.into(),
        database_config,
    ) {
        Ok(e) => Ok(e.into()),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

//Return a derived address using the external descriptor,

pub fn get_address(
    wallet: RustOpaque<WalletInstance>,
    address_index: AddressIndex,
) -> anyhow::Result<AddressInfo, anyhow::Error> {
    match wallet.get_address(address_index) {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

//Return a derived address using the internal descriptor,
pub fn get_internal_address(
    wallet: RustOpaque<WalletInstance>,
    address_index: AddressIndex,
) -> anyhow::Result<AddressInfo, anyhow::Error> {
    match wallet.get_internal_address(address_index) {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

pub fn get_internalized_address(
    wallet: RustOpaque<WalletInstance>,
    address_index: AddressIndex,
) -> anyhow::Result<AddressInfo, anyhow::Error> {
    match wallet.get_internal_address(address_index) {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

pub fn sync_wallet(wallet: RustOpaque<WalletInstance>, blockchain: RustOpaque<BlockchainInstance>) {
    wallet.sync(blockchain.deref());
}

pub fn get_balance(wallet: RustOpaque<WalletInstance>) -> anyhow::Result<Balance, anyhow::Error> {
    match wallet.get_balance() {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

//Return the list of unspent outputs of this wallet
pub fn list_unspent_outputs(
    wallet: RustOpaque<WalletInstance>,
) -> anyhow::Result<Vec<crate::wallet::LocalUtxo>, anyhow::Error> {
    match wallet.list_unspent() {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

pub fn get_transactions(
    wallet: RustOpaque<WalletInstance>,
) -> anyhow::Result<Vec<TransactionDetails>, anyhow::Error> {
    match wallet.list_transactions() {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

pub fn sign(
    wallet: RustOpaque<WalletInstance>,
    psbt_str: String,
    is_multi_sig: bool,
) -> Option<String> {
    let psbt = match PartiallySignedTransaction::new(psbt_str) {
        Ok(e) => e,
        Err(e) => panic!("{:?}", e),
    };
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
    wallet.get_wallet().network().into()
}

pub fn list_unspent(
    wallet: RustOpaque<WalletInstance>,
) -> anyhow::Result<Vec<crate::wallet::LocalUtxo>, anyhow::Error> {
    match wallet.list_unspent() {
        Ok(e) => Ok(e),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

//================== Mnemonic ==========

pub fn generate_seed_from_word_count(word_count: WordCount) -> String {
    let mnemonic = Mnemonic::new(word_count.into());
    mnemonic.as_string()
}

pub fn generate_seed_from_string(mnemonic: String) -> anyhow::Result<String, anyhow::Error> {
    let mnemonic = Mnemonic::from_str(mnemonic);
    match mnemonic {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}

pub fn generate_seed_from_entropy(entropy: Vec<u8>) -> anyhow::Result<String, anyhow::Error> {
    let mnemonic = Mnemonic::from_entropy(entropy);
    match mnemonic {
        Ok(e) => Ok(e.as_string()),
        Err(e) => anyhow::bail!("{:?}", e),
    }
}
