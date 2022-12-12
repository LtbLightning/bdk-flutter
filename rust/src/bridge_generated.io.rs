use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_blockchain_init(port_: i64, config: *mut wire_BlockchainConfig) {
    wire_blockchain_init_impl(port_, config)
}

#[no_mangle]
pub extern "C" fn wire_get_blockchain_height(port_: i64, blockchain: wire_BlockchainInstance) {
    wire_get_blockchain_height_impl(port_, blockchain)
}

#[no_mangle]
pub extern "C" fn wire_get_blockchain_hash(
    port_: i64,
    blockchain_height: u32,
    blockchain: wire_BlockchainInstance,
) {
    wire_get_blockchain_hash_impl(port_, blockchain_height, blockchain)
}

#[no_mangle]
pub extern "C" fn wire_broadcast(
    port_: i64,
    psbt_str: *mut wire_uint_8_list,
    blockchain: wire_BlockchainInstance,
) {
    wire_broadcast_impl(port_, psbt_str, blockchain)
}

#[no_mangle]
pub extern "C" fn wire_psbt_to_txid(port_: i64, psbt_str: *mut wire_uint_8_list) {
    wire_psbt_to_txid_impl(port_, psbt_str)
}

#[no_mangle]
pub extern "C" fn wire_extract_tx(port_: i64, psbt_str: *mut wire_uint_8_list) {
    wire_extract_tx_impl(port_, psbt_str)
}

#[no_mangle]
pub extern "C" fn wire_get_fee_rate(port_: i64, psbt_str: *mut wire_uint_8_list) {
    wire_get_fee_rate_impl(port_, psbt_str)
}

#[no_mangle]
pub extern "C" fn wire_combine_psbt(
    port_: i64,
    psbt_str: *mut wire_uint_8_list,
    other: *mut wire_uint_8_list,
) {
    wire_combine_psbt_impl(port_, psbt_str, other)
}

#[no_mangle]
pub extern "C" fn wire_tx_builder_finish(
    port_: i64,
    wallet: wire_WalletInstance,
    recipients: *mut wire_list_script_amount,
    utxos: *mut wire_list_out_point,
    unspendable: *mut wire_list_out_point,
    manually_selected_only: bool,
    only_spend_change: bool,
    do_not_spend_change: bool,
    fee_rate: *mut f32,
    fee_absolute: *mut u64,
    drain_wallet: bool,
    drain_to: *mut wire_uint_8_list,
    enable_rbf: bool,
    n_sequence: *mut u32,
    data: *mut wire_uint_8_list,
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

#[no_mangle]
pub extern "C" fn wire_bump_fee_tx_builder_finish(
    port_: i64,
    txid: *mut wire_uint_8_list,
    fee_rate: f32,
    allow_shrinking: *mut wire_uint_8_list,
    wallet: wire_WalletInstance,
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

#[no_mangle]
pub extern "C" fn wire_descriptor_secret_extend(
    port_: i64,
    xprv: *mut wire_uint_8_list,
    path: *mut wire_uint_8_list,
) {
    wire_descriptor_secret_extend_impl(port_, xprv, path)
}

#[no_mangle]
pub extern "C" fn wire_descriptor_secret_derive(
    port_: i64,
    xprv: *mut wire_uint_8_list,
    path: *mut wire_uint_8_list,
) {
    wire_descriptor_secret_derive_impl(port_, xprv, path)
}

#[no_mangle]
pub extern "C" fn wire_descriptor_secret_as_secret_bytes(
    port_: i64,
    descriptor_secret: *mut wire_uint_8_list,
    xprv: *mut wire_uint_8_list,
) {
    wire_descriptor_secret_as_secret_bytes_impl(port_, descriptor_secret, xprv)
}

#[no_mangle]
pub extern "C" fn wire_descriptor_secret_as_public(
    port_: i64,
    descriptor_secret: *mut wire_uint_8_list,
    xprv: *mut wire_uint_8_list,
) {
    wire_descriptor_secret_as_public_impl(port_, descriptor_secret, xprv)
}

#[no_mangle]
pub extern "C" fn wire_create_descriptor_secret(
    port_: i64,
    network: i32,
    mnemonic: *mut wire_uint_8_list,
    password: *mut wire_uint_8_list,
) {
    wire_create_descriptor_secret_impl(port_, network, mnemonic, password)
}

#[no_mangle]
pub extern "C" fn wire_create_derivation_path(port_: i64, path: *mut wire_uint_8_list) {
    wire_create_derivation_path_impl(port_, path)
}

#[no_mangle]
pub extern "C" fn wire_create_descriptor_public(
    port_: i64,
    xpub: *mut wire_uint_8_list,
    path: *mut wire_uint_8_list,
    derive: bool,
) {
    wire_create_descriptor_public_impl(port_, xpub, path, derive)
}

#[no_mangle]
pub extern "C" fn wire_init_script(port_: i64, raw_output_script: *mut wire_uint_8_list) {
    wire_init_script_impl(port_, raw_output_script)
}

#[no_mangle]
pub extern "C" fn wire_init_address(port_: i64, address: *mut wire_uint_8_list) {
    wire_init_address_impl(port_, address)
}

#[no_mangle]
pub extern "C" fn wire_address_to_script_pubkey_hex(port_: i64, address: *mut wire_uint_8_list) {
    wire_address_to_script_pubkey_hex_impl(port_, address)
}

#[no_mangle]
pub extern "C" fn wire_wallet_init(
    port_: i64,
    descriptor: *mut wire_uint_8_list,
    change_descriptor: *mut wire_uint_8_list,
    network: i32,
    database_config: *mut wire_DatabaseConfig,
) {
    wire_wallet_init_impl(
        port_,
        descriptor,
        change_descriptor,
        network,
        database_config,
    )
}

#[no_mangle]
pub extern "C" fn wire_get_address(port_: i64, wallet: wire_WalletInstance, address_index: i32) {
    wire_get_address_impl(port_, wallet, address_index)
}

#[no_mangle]
pub extern "C" fn wire_sync_wallet(
    port_: i64,
    wallet: wire_WalletInstance,
    blockchain: wire_BlockchainInstance,
) {
    wire_sync_wallet_impl(port_, wallet, blockchain)
}

#[no_mangle]
pub extern "C" fn wire_get_balance(port_: i64, wallet: wire_WalletInstance) {
    wire_get_balance_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_list_unspent_outputs(port_: i64, wallet: wire_WalletInstance) {
    wire_list_unspent_outputs_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_get_transactions(port_: i64, wallet: wire_WalletInstance) {
    wire_get_transactions_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_sign(
    port_: i64,
    wallet: wire_WalletInstance,
    psbt_str: *mut wire_uint_8_list,
    is_multi_sig: bool,
) {
    wire_sign_impl(port_, wallet, psbt_str, is_multi_sig)
}

#[no_mangle]
pub extern "C" fn wire_get_network(port_: i64, wallet: wire_WalletInstance) {
    wire_get_network_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_list_unspent(port_: i64, wallet: wire_WalletInstance) {
    wire_list_unspent_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_generate_seed_from_word_count(port_: i64, word_count: i32) {
    wire_generate_seed_from_word_count_impl(port_, word_count)
}

#[no_mangle]
pub extern "C" fn wire_generate_seed_from_string(port_: i64, mnemonic: *mut wire_uint_8_list) {
    wire_generate_seed_from_string_impl(port_, mnemonic)
}

#[no_mangle]
pub extern "C" fn wire_generate_seed_from_entropy(port_: i64, entropy: *mut wire_uint_8_list) {
    wire_generate_seed_from_entropy_impl(port_, entropy)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_BlockchainInstance() -> wire_BlockchainInstance {
    wire_BlockchainInstance::new_with_null_ptr()
}

#[no_mangle]
pub extern "C" fn new_WalletInstance() -> wire_WalletInstance {
    wire_WalletInstance::new_with_null_ptr()
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_blockchain_config_0() -> *mut wire_BlockchainConfig {
    support::new_leak_box_ptr(wire_BlockchainConfig::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_database_config_0() -> *mut wire_DatabaseConfig {
    support::new_leak_box_ptr(wire_DatabaseConfig::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_electrum_config_0() -> *mut wire_ElectrumConfig {
    support::new_leak_box_ptr(wire_ElectrumConfig::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_esplora_config_0() -> *mut wire_EsploraConfig {
    support::new_leak_box_ptr(wire_EsploraConfig::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_f32_0(value: f32) -> *mut f32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_sled_db_configuration_0() -> *mut wire_SledDbConfiguration {
    support::new_leak_box_ptr(wire_SledDbConfiguration::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_sqlite_db_configuration_0() -> *mut wire_SqliteDbConfiguration {
    support::new_leak_box_ptr(wire_SqliteDbConfiguration::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u32_0(value: u32) -> *mut u32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u64_0(value: u64) -> *mut u64 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u8_0(value: u8) -> *mut u8 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_list_out_point_0(len: i32) -> *mut wire_list_out_point {
    let wrap = wire_list_out_point {
        ptr: support::new_leak_vec_ptr(<wire_OutPoint>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_list_script_amount_0(len: i32) -> *mut wire_list_script_amount {
    let wrap = wire_list_script_amount {
        ptr: support::new_leak_vec_ptr(<wire_ScriptAmount>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

#[no_mangle]
pub extern "C" fn drop_opaque_BlockchainInstance(ptr: *const c_void) {
    unsafe {
        Arc::<BlockchainInstance>::decrement_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn share_opaque_BlockchainInstance(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<BlockchainInstance>::increment_strong_count(ptr as _);
        ptr
    }
}

#[no_mangle]
pub extern "C" fn drop_opaque_WalletInstance(ptr: *const c_void) {
    unsafe {
        Arc::<WalletInstance>::decrement_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn share_opaque_WalletInstance(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<WalletInstance>::increment_strong_count(ptr as _);
        ptr
    }
}

// Section: impl Wire2Api

impl Wire2Api<RustOpaque<BlockchainInstance>> for wire_BlockchainInstance {
    fn wire2api(self) -> RustOpaque<BlockchainInstance> {
        unsafe { support::opaque_from_dart(self.ptr as _) }
    }
}
impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<RustOpaque<WalletInstance>> for wire_WalletInstance {
    fn wire2api(self) -> RustOpaque<WalletInstance> {
        unsafe { support::opaque_from_dart(self.ptr as _) }
    }
}

impl Wire2Api<BlockchainConfig> for wire_BlockchainConfig {
    fn wire2api(self) -> BlockchainConfig {
        match self.tag {
            0 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Electrum);
                BlockchainConfig::Electrum {
                    config: ans.config.wire2api(),
                }
            },
            1 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Esplora);
                BlockchainConfig::Esplora {
                    config: ans.config.wire2api(),
                }
            },
            _ => unreachable!(),
        }
    }
}

impl Wire2Api<BlockchainConfig> for *mut wire_BlockchainConfig {
    fn wire2api(self) -> BlockchainConfig {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<BlockchainConfig>::wire2api(*wrap).into()
    }
}
impl Wire2Api<DatabaseConfig> for *mut wire_DatabaseConfig {
    fn wire2api(self) -> DatabaseConfig {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<DatabaseConfig>::wire2api(*wrap).into()
    }
}
impl Wire2Api<ElectrumConfig> for *mut wire_ElectrumConfig {
    fn wire2api(self) -> ElectrumConfig {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<ElectrumConfig>::wire2api(*wrap).into()
    }
}
impl Wire2Api<EsploraConfig> for *mut wire_EsploraConfig {
    fn wire2api(self) -> EsploraConfig {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<EsploraConfig>::wire2api(*wrap).into()
    }
}

impl Wire2Api<SledDbConfiguration> for *mut wire_SledDbConfiguration {
    fn wire2api(self) -> SledDbConfiguration {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<SledDbConfiguration>::wire2api(*wrap).into()
    }
}
impl Wire2Api<SqliteDbConfiguration> for *mut wire_SqliteDbConfiguration {
    fn wire2api(self) -> SqliteDbConfiguration {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<SqliteDbConfiguration>::wire2api(*wrap).into()
    }
}

impl Wire2Api<DatabaseConfig> for wire_DatabaseConfig {
    fn wire2api(self) -> DatabaseConfig {
        match self.tag {
            0 => DatabaseConfig::Memory,
            1 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Sqlite);
                DatabaseConfig::Sqlite {
                    config: ans.config.wire2api(),
                }
            },
            2 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Sled);
                DatabaseConfig::Sled {
                    config: ans.config.wire2api(),
                }
            },
            _ => unreachable!(),
        }
    }
}
impl Wire2Api<ElectrumConfig> for wire_ElectrumConfig {
    fn wire2api(self) -> ElectrumConfig {
        ElectrumConfig {
            url: self.url.wire2api(),
            socks5: self.socks5.wire2api(),
            retry: self.retry.wire2api(),
            timeout: self.timeout.wire2api(),
            stop_gap: self.stop_gap.wire2api(),
        }
    }
}
impl Wire2Api<EsploraConfig> for wire_EsploraConfig {
    fn wire2api(self) -> EsploraConfig {
        EsploraConfig {
            base_url: self.base_url.wire2api(),
            proxy: self.proxy.wire2api(),
            concurrency: self.concurrency.wire2api(),
            stop_gap: self.stop_gap.wire2api(),
            timeout: self.timeout.wire2api(),
        }
    }
}

impl Wire2Api<Vec<OutPoint>> for *mut wire_list_out_point {
    fn wire2api(self) -> Vec<OutPoint> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<Vec<ScriptAmount>> for *mut wire_list_script_amount {
    fn wire2api(self) -> Vec<ScriptAmount> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<OutPoint> for wire_OutPoint {
    fn wire2api(self) -> OutPoint {
        OutPoint {
            txid: self.txid.wire2api(),
            vout: self.vout.wire2api(),
        }
    }
}
impl Wire2Api<ScriptAmount> for wire_ScriptAmount {
    fn wire2api(self) -> ScriptAmount {
        ScriptAmount {
            script: self.script.wire2api(),
            amount: self.amount.wire2api(),
        }
    }
}
impl Wire2Api<SledDbConfiguration> for wire_SledDbConfiguration {
    fn wire2api(self) -> SledDbConfiguration {
        SledDbConfiguration {
            path: self.path.wire2api(),
            tree_name: self.tree_name.wire2api(),
        }
    }
}
impl Wire2Api<SqliteDbConfiguration> for wire_SqliteDbConfiguration {
    fn wire2api(self) -> SqliteDbConfiguration {
        SqliteDbConfiguration {
            path: self.path.wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}

// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_BlockchainInstance {
    ptr: *const core::ffi::c_void,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_WalletInstance {
    ptr: *const core::ffi::c_void,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_ElectrumConfig {
    url: *mut wire_uint_8_list,
    socks5: *mut wire_uint_8_list,
    retry: u8,
    timeout: *mut u8,
    stop_gap: u64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_EsploraConfig {
    base_url: *mut wire_uint_8_list,
    proxy: *mut wire_uint_8_list,
    concurrency: *mut u8,
    stop_gap: u64,
    timeout: *mut u64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_out_point {
    ptr: *mut wire_OutPoint,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_script_amount {
    ptr: *mut wire_ScriptAmount,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_OutPoint {
    txid: *mut wire_uint_8_list,
    vout: u32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_ScriptAmount {
    script: *mut wire_uint_8_list,
    amount: u64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_SledDbConfiguration {
    path: *mut wire_uint_8_list,
    tree_name: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_SqliteDbConfiguration {
    path: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_BlockchainConfig {
    tag: i32,
    kind: *mut BlockchainConfigKind,
}

#[repr(C)]
pub union BlockchainConfigKind {
    Electrum: *mut wire_BlockchainConfig_Electrum,
    Esplora: *mut wire_BlockchainConfig_Esplora,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_BlockchainConfig_Electrum {
    config: *mut wire_ElectrumConfig,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_BlockchainConfig_Esplora {
    config: *mut wire_EsploraConfig,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_DatabaseConfig {
    tag: i32,
    kind: *mut DatabaseConfigKind,
}

#[repr(C)]
pub union DatabaseConfigKind {
    Memory: *mut wire_DatabaseConfig_Memory,
    Sqlite: *mut wire_DatabaseConfig_Sqlite,
    Sled: *mut wire_DatabaseConfig_Sled,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_DatabaseConfig_Memory {}

#[repr(C)]
#[derive(Clone)]
pub struct wire_DatabaseConfig_Sqlite {
    config: *mut wire_SqliteDbConfiguration,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_DatabaseConfig_Sled {
    config: *mut wire_SledDbConfiguration,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_BlockchainInstance {
    fn new_with_null_ptr() -> Self {
        Self {
            ptr: core::ptr::null(),
        }
    }
}

impl NewWithNullPtr for wire_WalletInstance {
    fn new_with_null_ptr() -> Self {
        Self {
            ptr: core::ptr::null(),
        }
    }
}

impl NewWithNullPtr for wire_BlockchainConfig {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_BlockchainConfig_Electrum() -> *mut BlockchainConfigKind {
    support::new_leak_box_ptr(BlockchainConfigKind {
        Electrum: support::new_leak_box_ptr(wire_BlockchainConfig_Electrum {
            config: core::ptr::null_mut(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_BlockchainConfig_Esplora() -> *mut BlockchainConfigKind {
    support::new_leak_box_ptr(BlockchainConfigKind {
        Esplora: support::new_leak_box_ptr(wire_BlockchainConfig_Esplora {
            config: core::ptr::null_mut(),
        }),
    })
}

impl NewWithNullPtr for wire_DatabaseConfig {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_DatabaseConfig_Sqlite() -> *mut DatabaseConfigKind {
    support::new_leak_box_ptr(DatabaseConfigKind {
        Sqlite: support::new_leak_box_ptr(wire_DatabaseConfig_Sqlite {
            config: core::ptr::null_mut(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_DatabaseConfig_Sled() -> *mut DatabaseConfigKind {
    support::new_leak_box_ptr(DatabaseConfigKind {
        Sled: support::new_leak_box_ptr(wire_DatabaseConfig_Sled {
            config: core::ptr::null_mut(),
        }),
    })
}

impl NewWithNullPtr for wire_ElectrumConfig {
    fn new_with_null_ptr() -> Self {
        Self {
            url: core::ptr::null_mut(),
            socks5: core::ptr::null_mut(),
            retry: Default::default(),
            timeout: core::ptr::null_mut(),
            stop_gap: Default::default(),
        }
    }
}

impl NewWithNullPtr for wire_EsploraConfig {
    fn new_with_null_ptr() -> Self {
        Self {
            base_url: core::ptr::null_mut(),
            proxy: core::ptr::null_mut(),
            concurrency: core::ptr::null_mut(),
            stop_gap: Default::default(),
            timeout: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_OutPoint {
    fn new_with_null_ptr() -> Self {
        Self {
            txid: core::ptr::null_mut(),
            vout: Default::default(),
        }
    }
}

impl NewWithNullPtr for wire_ScriptAmount {
    fn new_with_null_ptr() -> Self {
        Self {
            script: core::ptr::null_mut(),
            amount: Default::default(),
        }
    }
}

impl NewWithNullPtr for wire_SledDbConfiguration {
    fn new_with_null_ptr() -> Self {
        Self {
            path: core::ptr::null_mut(),
            tree_name: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_SqliteDbConfiguration {
    fn new_with_null_ptr() -> Self {
        Self {
            path: core::ptr::null_mut(),
        }
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
