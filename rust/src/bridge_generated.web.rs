use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_blockchain_init(port_: MessagePort, config: JsValue) {
    wire_blockchain_init_impl(port_, config)
}

#[wasm_bindgen]
pub fn wire_get_blockchain_height(port_: MessagePort, blockchain: JsValue) {
    wire_get_blockchain_height_impl(port_, blockchain)
}

#[wasm_bindgen]
pub fn wire_get_blockchain_hash(port_: MessagePort, blockchain_height: u32, blockchain: JsValue) {
    wire_get_blockchain_hash_impl(port_, blockchain_height, blockchain)
}

#[wasm_bindgen]
pub fn wire_broadcast(port_: MessagePort, psbt_str: String, blockchain: JsValue) {
    wire_broadcast_impl(port_, psbt_str, blockchain)
}

#[wasm_bindgen]
pub fn wire_psbt_to_txid(port_: MessagePort, psbt_str: String) {
    wire_psbt_to_txid_impl(port_, psbt_str)
}

#[wasm_bindgen]
pub fn wire_extract_tx(port_: MessagePort, psbt_str: String) {
    wire_extract_tx_impl(port_, psbt_str)
}

#[wasm_bindgen]
pub fn wire_get_fee_rate(port_: MessagePort, psbt_str: String) {
    wire_get_fee_rate_impl(port_, psbt_str)
}

#[wasm_bindgen]
pub fn wire_combine_psbt(port_: MessagePort, psbt_str: String, other: String) {
    wire_combine_psbt_impl(port_, psbt_str, other)
}

#[wasm_bindgen]
pub fn wire_tx_builder_finish(
    port_: MessagePort,
    wallet: JsValue,
    recipients: JsValue,
    utxos: JsValue,
    unspendable: JsValue,
    manually_selected_only: bool,
    only_spend_change: bool,
    do_not_spend_change: bool,
    fee_rate: *mut f32,
    fee_absolute: *mut u64,
    drain_wallet: bool,
    drain_to: Option<String>,
    enable_rbf: bool,
    n_sequence: *mut u32,
    data: Box<[u8]>,
) {
    wire_tx_builder_finish_impl(
        port_,
        wallet,
        recipients,
        utxos,
        unspendable,
        manually_selected_only,
        only_spend_change,
        do_not_spend_change,
        fee_rate,
        fee_absolute,
        drain_wallet,
        drain_to,
        enable_rbf,
        n_sequence,
        data,
    )
}

#[wasm_bindgen]
pub fn wire_bump_fee_tx_builder_finish(
    port_: MessagePort,
    txid: String,
    fee_rate: f32,
    allow_shrinking: Option<String>,
    wallet: JsValue,
    enable_rbf: bool,
    n_sequence: *mut u32,
) {
    wire_bump_fee_tx_builder_finish_impl(
        port_,
        txid,
        fee_rate,
        allow_shrinking,
        wallet,
        enable_rbf,
        n_sequence,
    )
}

#[wasm_bindgen]
pub fn wire_descriptor_secret_extend(port_: MessagePort, xprv: String, path: String) {
    wire_descriptor_secret_extend_impl(port_, xprv, path)
}

#[wasm_bindgen]
pub fn wire_descriptor_secret_derive(port_: MessagePort, xprv: String, path: String) {
    wire_descriptor_secret_derive_impl(port_, xprv, path)
}

#[wasm_bindgen]
pub fn wire_descriptor_secret_as_secret_bytes(
    port_: MessagePort,
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) {
    wire_descriptor_secret_as_secret_bytes_impl(port_, descriptor_secret, xprv)
}

#[wasm_bindgen]
pub fn wire_descriptor_secret_as_public(
    port_: MessagePort,
    descriptor_secret: Option<String>,
    xprv: Option<String>,
) {
    wire_descriptor_secret_as_public_impl(port_, descriptor_secret, xprv)
}

#[wasm_bindgen]
pub fn wire_create_descriptor_secret(
    port_: MessagePort,
    network: i32,
    mnemonic: String,
    password: Option<String>,
) {
    wire_create_descriptor_secret_impl(port_, network, mnemonic, password)
}

#[wasm_bindgen]
pub fn wire_create_derivation_path(port_: MessagePort, path: String) {
    wire_create_derivation_path_impl(port_, path)
}

#[wasm_bindgen]
pub fn wire_create_descriptor_public(
    port_: MessagePort,
    xpub: Option<String>,
    path: String,
    derive: bool,
) {
    wire_create_descriptor_public_impl(port_, xpub, path, derive)
}

#[wasm_bindgen]
pub fn wire_init_script(port_: MessagePort, raw_output_script: Box<[u8]>) {
    wire_init_script_impl(port_, raw_output_script)
}

#[wasm_bindgen]
pub fn wire_init_address(port_: MessagePort, address: String) {
    wire_init_address_impl(port_, address)
}

#[wasm_bindgen]
pub fn wire_address_to_script_pubkey_hex(port_: MessagePort, address: String) {
    wire_address_to_script_pubkey_hex_impl(port_, address)
}

#[wasm_bindgen]
pub fn wire_wallet_init(
    port_: MessagePort,
    descriptor: String,
    change_descriptor: Option<String>,
    network: i32,
    database_config: JsValue,
) {
    wire_wallet_init_impl(
        port_,
        descriptor,
        change_descriptor,
        network,
        database_config,
    )
}

#[wasm_bindgen]
pub fn wire_get_address(port_: MessagePort, wallet: JsValue, address_index: i32) {
    wire_get_address_impl(port_, wallet, address_index)
}

#[wasm_bindgen]
pub fn wire_sync_wallet(port_: MessagePort, wallet: JsValue, blockchain: JsValue) {
    wire_sync_wallet_impl(port_, wallet, blockchain)
}

#[wasm_bindgen]
pub fn wire_get_balance(port_: MessagePort, wallet: JsValue) {
    wire_get_balance_impl(port_, wallet)
}

#[wasm_bindgen]
pub fn wire_list_unspent_outputs(port_: MessagePort, wallet: JsValue) {
    wire_list_unspent_outputs_impl(port_, wallet)
}

#[wasm_bindgen]
pub fn wire_get_transactions(port_: MessagePort, wallet: JsValue) {
    wire_get_transactions_impl(port_, wallet)
}

#[wasm_bindgen]
pub fn wire_sign(port_: MessagePort, wallet: JsValue, psbt_str: String, is_multi_sig: bool) {
    wire_sign_impl(port_, wallet, psbt_str, is_multi_sig)
}

#[wasm_bindgen]
pub fn wire_get_network(port_: MessagePort, wallet: JsValue) {
    wire_get_network_impl(port_, wallet)
}

#[wasm_bindgen]
pub fn wire_list_unspent(port_: MessagePort, wallet: JsValue) {
    wire_list_unspent_impl(port_, wallet)
}

#[wasm_bindgen]
pub fn wire_generate_seed_from_word_count(port_: MessagePort, word_count: i32) {
    wire_generate_seed_from_word_count_impl(port_, word_count)
}

#[wasm_bindgen]
pub fn wire_generate_seed_from_string(port_: MessagePort, mnemonic: String) {
    wire_generate_seed_from_string_impl(port_, mnemonic)
}

#[wasm_bindgen]
pub fn wire_generate_seed_from_entropy(port_: MessagePort, entropy: Box<[u8]>) {
    wire_generate_seed_from_entropy_impl(port_, entropy)
}

// Section: allocate functions

#[wasm_bindgen]
pub fn new_box_autoadd_f32_0(value: f32) -> *mut f32 {
    support::new_leak_box_ptr(value)
}

#[wasm_bindgen]
pub fn new_box_autoadd_u32_0(value: u32) -> *mut u32 {
    support::new_leak_box_ptr(value)
}

#[wasm_bindgen]
pub fn new_box_autoadd_u64_0(value: u64) -> *mut u64 {
    support::new_leak_box_ptr(value)
}

#[wasm_bindgen]
pub fn new_box_autoadd_u8_0(value: u8) -> *mut u8 {
    support::new_leak_box_ptr(value)
}

// Section: related functions

#[wasm_bindgen]
pub fn drop_opaque_BlockchainInstance(ptr: *const c_void) {
    unsafe {
        Arc::<BlockchainInstance>::decrement_strong_count(ptr as _);
    }
}

#[wasm_bindgen]
pub fn share_opaque_BlockchainInstance(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<BlockchainInstance>::increment_strong_count(ptr as _);
        ptr
    }
}

#[wasm_bindgen]
pub fn drop_opaque_WalletInstance(ptr: *const c_void) {
    unsafe {
        Arc::<WalletInstance>::decrement_strong_count(ptr as _);
    }
}

#[wasm_bindgen]
pub fn share_opaque_WalletInstance(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<WalletInstance>::increment_strong_count(ptr as _);
        ptr
    }
}

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}

impl Wire2Api<Auth> for JsValue {
    fn wire2api(self) -> Auth {
        let self_ = self.unchecked_into::<JsArray>();
        match self_.get(0).unchecked_into_f64() as _ {
            0 => Auth::None,
            1 => Auth::UserPass {
                username: self_.get(1).wire2api(),
                password: self_.get(2).wire2api(),
            },
            2 => Auth::Cookie {
                file: self_.get(1).wire2api(),
            },
            _ => unreachable!(),
        }
    }
}
impl Wire2Api<BlockchainConfig> for JsValue {
    fn wire2api(self) -> BlockchainConfig {
        let self_ = self.unchecked_into::<JsArray>();
        match self_.get(0).unchecked_into_f64() as _ {
            0 => BlockchainConfig::Electrum {
                config: self_.get(1).wire2api(),
            },
            1 => BlockchainConfig::Esplora {
                config: self_.get(1).wire2api(),
            },
            2 => BlockchainConfig::Rpc {
                config: self_.get(1).wire2api(),
            },
            _ => unreachable!(),
        }
    }
}

impl Wire2Api<DatabaseConfig> for JsValue {
    fn wire2api(self) -> DatabaseConfig {
        let self_ = self.unchecked_into::<JsArray>();
        match self_.get(0).unchecked_into_f64() as _ {
            0 => DatabaseConfig::Memory,
            1 => DatabaseConfig::Sqlite {
                config: self_.get(1).wire2api(),
            },
            2 => DatabaseConfig::Sled {
                config: self_.get(1).wire2api(),
            },
            _ => unreachable!(),
        }
    }
}
impl Wire2Api<ElectrumConfig> for JsValue {
    fn wire2api(self) -> ElectrumConfig {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            5,
            "Expected 5 elements, got {}",
            self_.length()
        );
        ElectrumConfig {
            url: self_.get(0).wire2api(),
            socks5: self_.get(1).wire2api(),
            retry: self_.get(2).wire2api(),
            timeout: self_.get(3).wire2api(),
            stop_gap: self_.get(4).wire2api(),
        }
    }
}
impl Wire2Api<EsploraConfig> for JsValue {
    fn wire2api(self) -> EsploraConfig {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            5,
            "Expected 5 elements, got {}",
            self_.length()
        );
        EsploraConfig {
            base_url: self_.get(0).wire2api(),
            proxy: self_.get(1).wire2api(),
            concurrency: self_.get(2).wire2api(),
            stop_gap: self_.get(3).wire2api(),
            timeout: self_.get(4).wire2api(),
        }
    }
}

impl Wire2Api<Vec<OutPoint>> for JsValue {
    fn wire2api(self) -> Vec<OutPoint> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}
impl Wire2Api<Vec<ScriptAmount>> for JsValue {
    fn wire2api(self) -> Vec<ScriptAmount> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}

impl Wire2Api<Option<String>> for Option<String> {
    fn wire2api(self) -> Option<String> {
        self.map(Wire2Api::wire2api)
    }
}

impl Wire2Api<Option<RpcSyncParams>> for JsValue {
    fn wire2api(self) -> Option<RpcSyncParams> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<OutPoint> for JsValue {
    fn wire2api(self) -> OutPoint {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        OutPoint {
            txid: self_.get(0).wire2api(),
            vout: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<RpcConfig> for JsValue {
    fn wire2api(self) -> RpcConfig {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            5,
            "Expected 5 elements, got {}",
            self_.length()
        );
        RpcConfig {
            url: self_.get(0).wire2api(),
            auth: self_.get(1).wire2api(),
            network: self_.get(2).wire2api(),
            wallet_name: self_.get(3).wire2api(),
            sync_params: self_.get(4).wire2api(),
        }
    }
}
impl Wire2Api<RpcSyncParams> for JsValue {
    fn wire2api(self) -> RpcSyncParams {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            4,
            "Expected 4 elements, got {}",
            self_.length()
        );
        RpcSyncParams {
            start_script_count: self_.get(0).wire2api(),
            start_time: self_.get(1).wire2api(),
            force_start_time: self_.get(2).wire2api(),
            poll_rate_sec: self_.get(3).wire2api(),
        }
    }
}
impl Wire2Api<ScriptAmount> for JsValue {
    fn wire2api(self) -> ScriptAmount {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        ScriptAmount {
            script: self_.get(0).wire2api(),
            amount: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<SledDbConfiguration> for JsValue {
    fn wire2api(self) -> SledDbConfiguration {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        SledDbConfiguration {
            path: self_.get(0).wire2api(),
            tree_name: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<SqliteDbConfiguration> for JsValue {
    fn wire2api(self) -> SqliteDbConfiguration {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            1,
            "Expected 1 elements, got {}",
            self_.length()
        );
        SqliteDbConfiguration {
            path: self_.get(0).wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}

// Section: impl Wire2Api for JsValue

impl Wire2Api<RustOpaque<BlockchainInstance>> for JsValue {
    fn wire2api(self) -> RustOpaque<BlockchainInstance> {
        #[cfg(target_pointer_width = "64")]
        {
            compile_error!("64-bit pointers are not supported.");
        }

        unsafe { support::opaque_from_dart((self.as_f64().unwrap() as usize) as _) }
    }
}
impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<RustOpaque<WalletInstance>> for JsValue {
    fn wire2api(self) -> RustOpaque<WalletInstance> {
        #[cfg(target_pointer_width = "64")]
        {
            compile_error!("64-bit pointers are not supported.");
        }

        unsafe { support::opaque_from_dart((self.as_f64().unwrap() as usize) as _) }
    }
}
impl Wire2Api<AddressIndex> for JsValue {
    fn wire2api(self) -> AddressIndex {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
impl Wire2Api<bool> for JsValue {
    fn wire2api(self) -> bool {
        self.is_truthy()
    }
}
impl Wire2Api<f32> for JsValue {
    fn wire2api(self) -> f32 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<i32> for JsValue {
    fn wire2api(self) -> i32 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Network> for JsValue {
    fn wire2api(self) -> Network {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
impl Wire2Api<Option<String>> for JsValue {
    fn wire2api(self) -> Option<String> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<Option<f32>> for JsValue {
    fn wire2api(self) -> Option<f32> {
        (self != 0).then(|| *Wire2Api::<Box<f32>>::wire2api(self))
    }
}
impl Wire2Api<Option<u32>> for JsValue {
    fn wire2api(self) -> Option<u32> {
        (self != 0).then(|| *Wire2Api::<Box<u32>>::wire2api(self))
    }
}
impl Wire2Api<Option<u64>> for JsValue {
    fn wire2api(self) -> Option<u64> {
        (self != 0).then(|| *Wire2Api::<Box<u64>>::wire2api(self))
    }
}
impl Wire2Api<Option<u8>> for JsValue {
    fn wire2api(self) -> Option<u8> {
        (self != 0).then(|| *Wire2Api::<Box<u8>>::wire2api(self))
    }
}
impl Wire2Api<u32> for JsValue {
    fn wire2api(self) -> u32 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<u64> for JsValue {
    fn wire2api(self) -> u64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
impl Wire2Api<WordCount> for JsValue {
    fn wire2api(self) -> WordCount {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
