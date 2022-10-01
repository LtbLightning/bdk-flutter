use crate::ffi::{
    generate_mnemonic_from_entropy, generate_mnemonic_from_word_count, get_extended_key_info,
    AddressAmount, AddressIndex, Balance, DerivationPath, DescriptorSecretKey, LocalUtxo,
    PartiallySignedBitcoinTransaction, Transaction, TransactionDetails, TxBuilder, Wallet,
};
use crate::types::{
    BdkInfo, BlockchainConfig, DatabaseConfig, DerivedKeyInfo, Entropy, ExtendedKeyInfo,
    KeyChainKind, Network, ResponseWallet, WordCount,
};
use crate::utils::{
    config_bdk_network, config_blockchain, config_entropy, config_keychain_kind, config_network,
    config_word_count
};
use bdk::blockchain::{AnyBlockchain, Blockchain as BdkBlockChain, GetBlockHash, GetHeight};
use bdk::wallet::export::FullyNodedExport;
use bdk::{ Error, KeychainKind};
use lazy_static::lazy_static;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, RwLock};

lazy_static! {
    static ref BDKINFO: RwLock<Option<BdkInfo>> = RwLock::new(None);
}
fn set_bdk_info(
    blockchain: Arc<AnyBlockchain>,
    wallet: Arc<Wallet>
) {
    let bdk_info = BdkInfo {
        wallet: Some(wallet),
        blockchain: Some(blockchain),
    };
    let mut b_info = BDKINFO.write().unwrap();
    *b_info = Some(bdk_info);
}
pub fn generate_seed_from_entropy(entropy: Entropy) -> String {
    let entropy_u8 = config_entropy(entropy);
    let mnemonic = generate_mnemonic_from_entropy(entropy_u8);
    mnemonic.to_string()
}

pub fn generate_seed_from_word_count(word_count: WordCount) -> String {
    let word_count = config_word_count(word_count);
    let mnemonic = generate_mnemonic_from_word_count(word_count);
    mnemonic.to_string()
}
pub fn create_key(
    node_network: Network,
    mnemonic: String,
    password: Option<String>,
) -> ExtendedKeyInfo {
    let node_network = config_network(node_network);
    let response = get_extended_key_info(node_network, mnemonic, password);
    return response;
}
pub fn create_descriptor_secret_keys(
    node_network: Network,
    mnemonic: String,
    path: String,
    password: Option<String>,
) -> DerivedKeyInfo {
    let descriptor_secret = get_descriptor_secret_key(mnemonic.clone(), node_network, password);
    let derived_secret = derive_dsk(&descriptor_secret, path.as_str()).unwrap();
    let response = DerivedKeyInfo {
        xprv: derived_secret.as_string(),
        xpub: derived_secret.as_public().as_string(),
    };
    return response;
}

fn get_descriptor_secret_key(
    mnemonic: String,
    network: Network,
    password: Option<String>,
) -> DescriptorSecretKey {
    let node_network = config_network(network);
    DescriptorSecretKey::new(node_network, mnemonic, password).unwrap()
}

fn derive_dsk(key: &DescriptorSecretKey, path: &str) -> Result<Arc<DescriptorSecretKey>, Error> {
    let path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
    key.derive(path)
}
pub fn wallet_init(
    descriptor: String,
    change_descriptor: Option<String>,
    network: Network,
    blockchain_config: BlockchainConfig,
    database_config: DatabaseConfig,
) {
    let node_network = config_network(network.clone());
    let blockchain_obj = config_blockchain(blockchain_config);
    let wallet_obj = Wallet::new(
        descriptor.clone(),
        change_descriptor,
        node_network,
        database_config,
    )
    .unwrap();
    let blockchain = Arc::new(blockchain_obj);
    let wallet = Arc::new(wallet_obj);
    wallet.sync(&blockchain.clone());
    set_bdk_info(blockchain.clone(), wallet.clone())
}

pub fn export_wallet(wallet_name: String) -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let export = FullyNodedExport::export_wallet(wallet.get_wallet().deref(), &*wallet_name, true)
        .map_err(ToString::to_string)
        .map_err(bdk::Error::Generic)
        .unwrap();
    export.to_string()
}
pub fn import_wallet(
    json_wallet: String,
    network: Network,
    blockchain_config: BlockchainConfig,
    database_config: DatabaseConfig,
) {
    let import = FullyNodedExport::from_str(&*json_wallet).unwrap();
    wallet_init(
        import.descriptor(),
        import.change_descriptor(),
        network,
        blockchain_config,
        database_config,
    );
}
//Return the “public” version of the wallet’s descriptor, meaning a new descriptor that has the same structure but with every secret key removed
pub fn get_public_descriptor() -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let res = wallet
        .wallet_mutex
        .lock()
        .unwrap()
        .public_descriptor(KeychainKind::External)
        .unwrap()
        .unwrap()
        .to_string();
    res
}
//Returns the descriptor used to create addresses for a particular keychain.
pub fn get_descriptor_for_keychain(keychain_kind_str: KeyChainKind) -> String {
    let keychain_kind = config_keychain_kind(keychain_kind_str);
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    wallet.get_descriptor_for_keychain(keychain_kind).unwrap()
}
//Return the checksum of the public descriptor associated to keychain
// Internally calls
pub fn get_descriptor_checksum(keychain_kind_str: KeyChainKind) -> String {
    let keychain_kind = config_keychain_kind(keychain_kind_str);
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    wallet.get_descriptor_checksum(keychain_kind).unwrap()
}

pub fn get_wallet() -> ResponseWallet {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let blockchain = bdk_info.blockchain.unwrap();
    wallet.sync(blockchain.deref());
    ResponseWallet {
        balance: get_balance(),
        address: get_new_address(),
    }
}
pub fn get_wallet_network() -> Network {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let network = config_bdk_network(wallet.get_network());
    network
}
pub fn get_blockchain_height() -> u32 {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let blockchain = bdk_info.blockchain.unwrap();
    blockchain.get_height().unwrap()
}
pub fn get_blockchain_hash(blockchain_height: u64) -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let blockchain = bdk_info.blockchain.unwrap();
    let x = blockchain
        .get_block_hash(blockchain_height)
        .unwrap()
        .as_hash()
        .to_string();
    x
}
pub fn sync_wallet() {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let blockchain = bdk_info.blockchain.unwrap();
    wallet.sync(blockchain.deref());
}

pub fn get_balance() -> Balance {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let balance = wallet.get_balance().unwrap();
    balance
}
//Return the list of unspent outputs of this wallet
pub fn list_unspent_outputs() -> Vec<LocalUtxo> {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let unspent = wallet.list_unspent();
    unspent.unwrap()
}
//Return a derived address using the external descriptor,
pub fn get_new_address() -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let address = wallet.get_address(AddressIndex::New).unwrap().address;
    address
}
//Return a derived address using the internal (change) descriptor.
// If the wallet doesn’t have an internal descriptor it will use the external descriptor.
pub fn get_new_internal_address() -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let address = wallet
        .get_internal_address(AddressIndex::New)
        .unwrap()
        .address;
    address
}

pub fn get_last_unused_address() -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    wallet.get_address(AddressIndex::LastUnused).unwrap().address
}
pub fn get_transaction(txid: String) -> Option<TransactionDetails> {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let response = wallet.get_transaction(txid);
    match response.as_ref().unwrap().is_some() {
        true => response.unwrap(),
        false => None,
    }
}
pub fn get_transactions() -> Vec<Transaction> {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    sync_wallet();
    let transactions = wallet.get_transactions().unwrap();
    transactions
}

pub fn create_transaction(recipient: String, amount: u64, fee_rate: f32) -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    sync_wallet();
    let tx_builder = TxBuilder::new();
    let psbt = tx_builder
        .add_recipient(recipient, amount)
        .fee_rate(fee_rate)
        .finish(&wallet);
    psbt.unwrap().serialize()
}

pub fn create_multi_sig_transaction(recipients: Vec<AddressAmount>, fee_rate: f32) -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let tx_builder = TxBuilder::new();
    let psbt = tx_builder
        .set_recipients(recipients)
        .fee_rate(fee_rate)
        .finish(&wallet);
    psbt.unwrap().serialize()
}




// pub fn parse_mnemonic(mnemonic:String) -> Option<String> {
//     match  Mnemonic::parse_normalized(mnemonic.clone().as_str()){
//         Ok(_) => Some(mnemonic),
//         Err(e) => None
//         ///TODO: IMPLEMENT ERROR HANDLING
//         //     {
//         //    //  let error = handle_keys_error(e);
//         //    // return Err(error);
//         // }
//     }
// }

pub fn sign_and_broadcast(psbt_str: String) -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    let blockchain = bdk_info.blockchain.unwrap();
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    wallet.sign(&psbt).unwrap();
    let tx = psbt.internal.lock().unwrap().clone().extract_tx();
    blockchain.broadcast(&tx).unwrap();
    sync_wallet();
    tx.txid().to_string()
}

pub fn sign(psbt_str: String) -> Option<String> {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let wallet = bdk_info.wallet.unwrap();
    sync_wallet();
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    return match wallet.sign(&psbt).unwrap() {
        true => {
            Some(psbt.serialize())
        }
        false => None,
    };
}

pub fn broadcast(psbt_str:String) -> String {
    let bdk_info = BDKINFO.read().unwrap().clone().unwrap();
    let blockchain = bdk_info.blockchain.unwrap();
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    let tx = psbt.internal.lock().unwrap().clone().extract_tx();
    blockchain.broadcast(&tx.clone()).unwrap();
    sync_wallet();
    tx.txid().to_string()
}


#[cfg(test)]
mod tests {
    use crate::ffi::PartiallySignedBitcoinTransaction;
    use crate::r_api::{broadcast, create_transaction, derive_dsk, generate_seed_from_entropy, generate_seed_from_word_count, get_balance, get_descriptor_secret_key, get_new_address, get_transactions, sign, sign_and_broadcast, sync_wallet, wallet_init};
    use crate::types::{
        BlockchainConfig, DatabaseConfig, ElectrumConfig, Entropy, Network, WordCount,
    };
    use bdk::bitcoin::Address;
    use bdk::bitcoin::Network as BdkNetwork;
    #[test]
    fn psbt_similarity_test() {
        _init_wallet();
        let psbt = create_transaction("mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string(), 1000, 1.0);
        let res = sign(psbt.clone());
        assert_eq!( psbt, res.unwrap(),);

    }

    #[test]
    fn psbt_broadcast_test() {
        _init_wallet();
        let x = "cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AugDAAAAAAAAGXapFDRKD0jKFQ7CuQOBdmC5tosTpnAmiKzFMBMAAAAAABYAFGzXjDnwBfUEzohX65YVfG0J11lZ4NYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGsCRzBEAiAzTPKDsXOn2pLz5fpOywncnqWqunueV1wCIYiuxXm4QwIgE6ksJNTO2uXRvGMkV7QxEITringKovVeDXMzOyi6edUBIQKFd2xcMY7kteNZ/KHetGRNnN88NtaYEFkdIoN6w1KuCAAAIgICl+rHwFFM2iFfYd2ps2Plp8WpcZovU+pWWe+ggZVoweUU2R5q3VQAAIAAAACAAQAAgD4AAAAA".to_string();
        let y = "cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AsUwEwAAAAAAFgAUbNeMOfAF9QTOiFfrlhV8bQnXWVnoAwAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJois4NYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGsCRzBEAiAo6eGvjAWQdyefCuSphc8FJewM9BZzgOhXJW9Uf+hQfAIgVvNJ6D7YC+MSqS01aMiTZ+0T2NJlXZLJFCBl585wescBIQKFd2xcMY7kteNZ/KHetGRNnN88NtaYEFkdIoN6w1KuCAAiAgKX6sfAUUzaIV9h3amzY+Wnxalxmi9T6lZZ76CBlWjB5RTZHmrdVAAAgAAAAIABAACAPgAAAAAA".to_string();
        let z = "cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AsUwEwAAAAAAFgAUbNeMOfAF9QTOiFfrlhV8bQnXWVnoAwAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJois4dYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGwCSDBFAiEA1y5jZfakuWe/EyWokRzO08RnjNht9UlRo//qVG/yC44CIBR1diESIVzHI9WKtA0REZXlUXVEwunrYXiuZhQpXra+ASEChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggAIgICl+rHwFFM2iFfYd2ps2Plp8WpcZovU+pWWe+ggZVoweUU2R5q3VQAAIAAAACAAQAAgD4AAAAAAA==".to_string();
        let a = "cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AugDAAAAAAAAGXapFDRKD0jKFQ7CuQOBdmC5tosTpnAmiKzFMBMAAAAAABYAFGzXjDnwBfUEzohX65YVfG0J11lZ4dYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGwCSDBFAiEAi7bmbZyqWea0c3Uw8YGVqzGGLI+Q1J92HX5fBJK7O1kCIG3PmHmPtqugEaP4/FPOUcUbU+nV8cqTG7pLh8lZGWThASEChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggAACICApfqx8BRTNohX2HdqbNj5afFqXGaL1PqVlnvoIGVaMHlFNkeat1UAACAAAAAgAEAAIA+AAAAAA==".to_string();
        let b = "cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AugDAAAAAAAAGXapFDRKD0jKFQ7CuQOBdmC5tosTpnAmiKzFMBMAAAAAABYAFGzXjDnwBfUEzohX65YVfG0J11lZ4dYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGwCSDBFAiEAi7bmbZyqWea0c3Uw8YGVqzGGLI+Q1J92HX5fBJK7O1kCIG3PmHmPtqugEaP4/FPOUcUbU+nV8cqTG7pLh8lZGWThASEChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggAACICApfqx8BRTNohX2HdqbNj5afFqXGaL1PqVlnvoIGVaMHlFNkeat1UAACAAAAAgAEAAIA+AAAAAA==".to_string();
        sync_wallet();
        let txid = broadcast(x);
        assert_eq!(txid, "txid");
    }

    #[test]
    fn create_broadcast_transaction_test() {
        _init_wallet();
        let psbt = create_transaction("mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string(), 1000, 1.0);
       let sbt = sign(psbt.clone());
        let txid = broadcast(sbt.unwrap());
        assert_eq!(txid, "false");
    }

    #[test]
    fn get_balance_test() {
        _init_wallet();
        assert_eq!(get_balance().total, 1262245);
    }
    #[test]
    fn get_transactions_test() {
        _init_wallet();
        assert_eq!(get_transactions().is_empty(), false);
    }

    #[test]
    fn get_new_address_test() {
        _init_wallet();
        let res = get_new_address();
        assert_eq!(res, "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt");
    }

    #[test]
    fn create_transaction_test() {
        _init_wallet();
        let psbt = create_transaction("mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string(), 1200, 1.0);
        let x = PartiallySignedBitcoinTransaction::new(psbt).unwrap();
        let script = x
            .internal
            .lock()
            .unwrap()
            .unsigned_tx
            .output
            .get(0)
            .cloned()
            .unwrap()
            .script_pubkey;
        let output_address = Address::from_script(&script, BdkNetwork::Testnet)
            .unwrap()
            .to_string();
        assert_eq!(
            output_address,
            "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string()
        );
    }


    fn _init_wallet() {
        wallet_init(
            "wpkh([d91e6add/84'/0'/0']tprv8gnnA5Zcbjai6d1mWvQatrK8c9eHfUAKSgJLoHfiryJb6gNBnQeAT7UuKKFmaBJUrc7pzyszqujrwxijJbDPBPi5edtPsm3jZ3pnNUzHbpm/*)".to_string(),
            Some("wpkh([d91e6add/84'/0'/1']tprv8gnnA5Zcbjai9Wfiec82h4oP8R92SNuNFFD5g8Kqu8hMd3kb8h93wGynk4vgCH3tfoGkDvCroMtqaiMGnqHudQoEYd89297VuybvNWfgPuL/*)".to_string()),
            Network::TESTNET,
            BlockchainConfig::ELECTRUM{ config: ElectrumConfig {
                url: "ssl://electrum.blockstream.info:60002".to_string(),
                socks5: None,
                retry: 10,
                timeout: None,
                stop_gap: 10
            } },
            DatabaseConfig::MEMORY
        );
    }
    #[test]
    fn generate_mnemonic_word_count_test() {
        let mnemonic = generate_seed_from_word_count(WordCount::WORDS12);
        assert_eq!(mnemonic.split(" ").count(), 12)
    }

    #[test]
    fn generate_mnemonic_with_entropy_test() {
        let mnemonic = generate_seed_from_entropy(Entropy::ENTROPY256);
        assert_eq!(mnemonic.split(" ").count(), 24)
    }
    #[test]
    fn test_derive_hardened_path_using_public() {
        let master_dsk = get_descriptor_secret_key("chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect".to_string(),
                                                   Network::TESTNET,None);
        let derived_sk = &derive_dsk(&master_dsk, "m/44/0/0/0/0").unwrap();
        assert_eq!(derived_sk.as_public().as_string(),"[d1d04177/44/0/0/0/0]tpubDH97TH9B3jVk4DodNDKD1HvaXcVU87j4SgGnGWTQq1pRZXCBeZufq3f9xPYQF14sAnL1Pb7WvQ5fZzbSCubTL5LhGFw3tu3DtPomnkKdA9F/*");
    }

    #[test]
    fn test_derive_hardened_path_using_private() {
        let master_dsk = get_descriptor_secret_key("chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect".to_string(),
                                                   Network::TESTNET,None);
        let derived_sk = &derive_dsk(&master_dsk, "m").unwrap();
        assert_eq!(derived_sk.as_string(),"[d1d04177]tprv8kT5Js6vuMp5AkmqUZecbtGTxayXxnY9sNfzyzR7Qk22j2wR2B65eZ3HnFDFEqULi6kNMhtZLexeD4qoh4kpEoF1LkmPMViwHJRYXPL6EP3/*");
    }

    #[test]
    fn test_generate_descriptor_secret_key() {
        let master_dsk = get_descriptor_secret_key("chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect".to_string(),
                                                   Network::TESTNET,None);
        assert_eq!(master_dsk.as_string(), "tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/*");
        assert_eq!(master_dsk.as_public().as_string(), "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/*");
    }
}
