#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_ElectrumConfig {
  struct wire_uint_8_list *url;
  struct wire_uint_8_list *socks5;
  uint8_t retry;
  uint8_t *timeout;
  uint64_t stop_gap;
  bool validate_domain;
} wire_ElectrumConfig;

typedef struct wire_BlockchainConfig_Electrum {
  struct wire_ElectrumConfig *config;
} wire_BlockchainConfig_Electrum;

typedef struct wire_EsploraConfig {
  struct wire_uint_8_list *base_url;
  struct wire_uint_8_list *proxy;
  uint8_t *concurrency;
  uint64_t stop_gap;
  uint64_t *timeout;
} wire_EsploraConfig;

typedef struct wire_BlockchainConfig_Esplora {
  struct wire_EsploraConfig *config;
} wire_BlockchainConfig_Esplora;

typedef struct wire_UserPass {
  struct wire_uint_8_list *username;
  struct wire_uint_8_list *password;
} wire_UserPass;

typedef struct wire_RpcSyncParams {
  uint64_t start_script_count;
  uint64_t start_time;
  bool force_start_time;
  uint64_t poll_rate_sec;
} wire_RpcSyncParams;

typedef struct wire_RpcConfig {
  struct wire_uint_8_list *url;
  struct wire_uint_8_list *auth_cookie;
  struct wire_UserPass *auth_user_pass;
  int32_t network;
  struct wire_uint_8_list *wallet_name;
  struct wire_RpcSyncParams *sync_params;
} wire_RpcConfig;

typedef struct wire_BlockchainConfig_Rpc {
  struct wire_RpcConfig *config;
} wire_BlockchainConfig_Rpc;

typedef union BlockchainConfigKind {
  struct wire_BlockchainConfig_Electrum *Electrum;
  struct wire_BlockchainConfig_Esplora *Esplora;
  struct wire_BlockchainConfig_Rpc *Rpc;
} BlockchainConfigKind;

typedef struct wire_BlockchainConfig {
  int32_t tag;
  union BlockchainConfigKind *kind;
} wire_BlockchainConfig;

typedef struct wire_BlockchainInstance {
  const void *ptr;
} wire_BlockchainInstance;

typedef struct wire_WalletInstance {
  const void *ptr;
} wire_WalletInstance;

typedef struct wire_ScriptAmount {
  struct wire_uint_8_list *script;
  uint64_t amount;
} wire_ScriptAmount;

typedef struct wire_list_script_amount {
  struct wire_ScriptAmount *ptr;
  int32_t len;
} wire_list_script_amount;

typedef struct wire_OutPoint {
  struct wire_uint_8_list *txid;
  uint32_t vout;
} wire_OutPoint;

typedef struct wire_list_out_point {
  struct wire_OutPoint *ptr;
  int32_t len;
} wire_list_out_point;

typedef struct wire_BdkDescriptor {
  const void *ptr;
} wire_BdkDescriptor;

typedef struct wire_DatabaseConfig_Memory {

} wire_DatabaseConfig_Memory;

typedef struct wire_SqliteDbConfiguration {
  struct wire_uint_8_list *path;
} wire_SqliteDbConfiguration;

typedef struct wire_DatabaseConfig_Sqlite {
  struct wire_SqliteDbConfiguration *config;
} wire_DatabaseConfig_Sqlite;

typedef struct wire_SledDbConfiguration {
  struct wire_uint_8_list *path;
  struct wire_uint_8_list *tree_name;
} wire_SledDbConfiguration;

typedef struct wire_DatabaseConfig_Sled {
  struct wire_SledDbConfiguration *config;
} wire_DatabaseConfig_Sled;

typedef union DatabaseConfigKind {
  struct wire_DatabaseConfig_Memory *Memory;
  struct wire_DatabaseConfig_Sqlite *Sqlite;
  struct wire_DatabaseConfig_Sled *Sled;
} DatabaseConfigKind;

typedef struct wire_DatabaseConfig {
  int32_t tag;
  union DatabaseConfigKind *kind;
} wire_DatabaseConfig;

typedef struct wire_AddressIndex_New {

} wire_AddressIndex_New;

typedef struct wire_AddressIndex_LastUnused {

} wire_AddressIndex_LastUnused;

typedef struct wire_AddressIndex_Peek {
  uint32_t index;
} wire_AddressIndex_Peek;

typedef struct wire_AddressIndex_Reset {
  uint32_t index;
} wire_AddressIndex_Reset;

typedef union AddressIndexKind {
  struct wire_AddressIndex_New *New;
  struct wire_AddressIndex_LastUnused *LastUnused;
  struct wire_AddressIndex_Peek *Peek;
  struct wire_AddressIndex_Reset *Reset;
} AddressIndexKind;

typedef struct wire_AddressIndex {
  int32_t tag;
  union AddressIndexKind *kind;
} wire_AddressIndex;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_blockchain_init(int64_t port_, struct wire_BlockchainConfig *config);

void wire_get_blockchain_height(int64_t port_, struct wire_BlockchainInstance blockchain);

void wire_get_blockchain_hash(int64_t port_,
                              uint32_t blockchain_height,
                              struct wire_BlockchainInstance blockchain);

void wire_estimate_fee(int64_t port_, uint64_t target, struct wire_BlockchainInstance blockchain);

void wire_broadcast(int64_t port_,
                    struct wire_uint_8_list *tx,
                    struct wire_BlockchainInstance blockchain);

void wire_new_transaction(int64_t port_, struct wire_uint_8_list *tx);

void wire_psbt_to_txid(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_extract_tx(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_get_psbt_fee_rate(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_get_fee_amount(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_combine_psbt(int64_t port_,
                       struct wire_uint_8_list *psbt_str,
                       struct wire_uint_8_list *other);

void wire_tx_builder_finish(int64_t port_,
                            struct wire_WalletInstance wallet,
                            struct wire_list_script_amount *recipients,
                            struct wire_list_out_point *utxos,
                            struct wire_list_out_point *unspendable,
                            bool manually_selected_only,
                            bool only_spend_change,
                            bool do_not_spend_change,
                            float *fee_rate,
                            uint64_t *fee_absolute,
                            bool drain_wallet,
                            struct wire_uint_8_list *drain_to,
                            bool enable_rbf,
                            uint32_t *n_sequence,
                            struct wire_uint_8_list *data);

void wire_bump_fee_tx_builder_finish(int64_t port_,
                                     struct wire_uint_8_list *txid,
                                     float fee_rate,
                                     struct wire_uint_8_list *allow_shrinking,
                                     struct wire_WalletInstance wallet,
                                     bool enable_rbf,
                                     uint32_t *n_sequence);

void wire_new_descriptor(int64_t port_, struct wire_uint_8_list *descriptor, int32_t network);

void wire_new_bip44_descriptor(int64_t port_,
                               int32_t key_chain_kind,
                               struct wire_uint_8_list *secret_key,
                               int32_t network);

void wire_new_bip44_public(int64_t port_,
                           int32_t key_chain_kind,
                           struct wire_uint_8_list *public_key,
                           int32_t network,
                           struct wire_uint_8_list *fingerprint);

void wire_new_bip49_descriptor(int64_t port_,
                               int32_t key_chain_kind,
                               struct wire_uint_8_list *secret_key,
                               int32_t network);

void wire_new_bip49_public(int64_t port_,
                           int32_t key_chain_kind,
                           struct wire_uint_8_list *public_key,
                           int32_t network,
                           struct wire_uint_8_list *fingerprint);

void wire_new_bip84_descriptor(int64_t port_,
                               int32_t key_chain_kind,
                               struct wire_uint_8_list *secret_key,
                               int32_t network);

void wire_new_bip84_public(int64_t port_,
                           int32_t key_chain_kind,
                           struct wire_uint_8_list *public_key,
                           int32_t network,
                           struct wire_uint_8_list *fingerprint);

void wire_as_string_private(int64_t port_, struct wire_BdkDescriptor descriptor);

void wire_as_string(int64_t port_, struct wire_BdkDescriptor descriptor);

void wire_create_descriptor_secret(int64_t port_,
                                   int32_t network,
                                   struct wire_uint_8_list *mnemonic,
                                   struct wire_uint_8_list *password);

void wire_descriptor_secret_from_string(int64_t port_, struct wire_uint_8_list *xprv);

void wire_descriptor_secret_extend(int64_t port_,
                                   struct wire_uint_8_list *xprv,
                                   struct wire_uint_8_list *path);

void wire_descriptor_secret_derive(int64_t port_,
                                   struct wire_uint_8_list *xprv,
                                   struct wire_uint_8_list *path);

void wire_descriptor_secret_as_secret_bytes(int64_t port_,
                                            struct wire_uint_8_list *descriptor_secret,
                                            struct wire_uint_8_list *xprv);

void wire_descriptor_secret_as_public(int64_t port_,
                                      struct wire_uint_8_list *descriptor_secret,
                                      struct wire_uint_8_list *xprv);

void wire_create_derivation_path(int64_t port_, struct wire_uint_8_list *path);

void wire_descriptor_public_from_string(int64_t port_, struct wire_uint_8_list *public_key);

void wire_create_descriptor_public(int64_t port_,
                                   struct wire_uint_8_list *xpub,
                                   struct wire_uint_8_list *path,
                                   bool derive);

void wire_init_script(int64_t port_, struct wire_uint_8_list *raw_output_script);

void wire_init_address(int64_t port_, struct wire_uint_8_list *address);

void wire_address_to_script_pubkey_hex(int64_t port_, struct wire_uint_8_list *address);

void wire_wallet_init(int64_t port_,
                      struct wire_BdkDescriptor descriptor,
                      struct wire_BdkDescriptor *change_descriptor,
                      int32_t network,
                      struct wire_DatabaseConfig *database_config);

void wire_get_address(int64_t port_,
                      struct wire_WalletInstance wallet,
                      struct wire_AddressIndex *address_index);

void wire_get_internal_address(int64_t port_,
                               struct wire_WalletInstance wallet,
                               struct wire_AddressIndex *address_index);

void wire_get_internalized_address(int64_t port_,
                                   struct wire_WalletInstance wallet,
                                   struct wire_AddressIndex *address_index);

void wire_sync_wallet(int64_t port_,
                      struct wire_WalletInstance wallet,
                      struct wire_BlockchainInstance blockchain);

void wire_get_balance(int64_t port_, struct wire_WalletInstance wallet);

void wire_list_unspent_outputs(int64_t port_, struct wire_WalletInstance wallet);

void wire_get_transactions(int64_t port_, struct wire_WalletInstance wallet);

void wire_sign(int64_t port_,
               struct wire_WalletInstance wallet,
               struct wire_uint_8_list *psbt_str,
               bool is_multi_sig);

void wire_get_network(int64_t port_, struct wire_WalletInstance wallet);

void wire_list_unspent(int64_t port_, struct wire_WalletInstance wallet);

void wire_generate_seed_from_word_count(int64_t port_, int32_t word_count);

void wire_generate_seed_from_string(int64_t port_, struct wire_uint_8_list *mnemonic);

void wire_generate_seed_from_entropy(int64_t port_, struct wire_uint_8_list *entropy);

struct wire_BdkDescriptor new_BdkDescriptor(void);

struct wire_BlockchainInstance new_BlockchainInstance(void);

struct wire_WalletInstance new_WalletInstance(void);

struct wire_BdkDescriptor *new_box_autoadd_BdkDescriptor_0(void);

struct wire_AddressIndex *new_box_autoadd_address_index_0(void);

struct wire_BlockchainConfig *new_box_autoadd_blockchain_config_0(void);

struct wire_DatabaseConfig *new_box_autoadd_database_config_0(void);

struct wire_ElectrumConfig *new_box_autoadd_electrum_config_0(void);

struct wire_EsploraConfig *new_box_autoadd_esplora_config_0(void);

float *new_box_autoadd_f32_0(float value);

struct wire_RpcConfig *new_box_autoadd_rpc_config_0(void);

struct wire_RpcSyncParams *new_box_autoadd_rpc_sync_params_0(void);

struct wire_SledDbConfiguration *new_box_autoadd_sled_db_configuration_0(void);

struct wire_SqliteDbConfiguration *new_box_autoadd_sqlite_db_configuration_0(void);

uint32_t *new_box_autoadd_u32_0(uint32_t value);

uint64_t *new_box_autoadd_u64_0(uint64_t value);

uint8_t *new_box_autoadd_u8_0(uint8_t value);

struct wire_UserPass *new_box_autoadd_user_pass_0(void);

struct wire_list_out_point *new_list_out_point_0(int32_t len);

struct wire_list_script_amount *new_list_script_amount_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void drop_opaque_BdkDescriptor(const void *ptr);

const void *share_opaque_BdkDescriptor(const void *ptr);

void drop_opaque_BlockchainInstance(const void *ptr);

const void *share_opaque_BlockchainInstance(const void *ptr);

void drop_opaque_WalletInstance(const void *ptr);

const void *share_opaque_WalletInstance(const void *ptr);

union AddressIndexKind *inflate_AddressIndex_Peek(void);

union AddressIndexKind *inflate_AddressIndex_Reset(void);

union BlockchainConfigKind *inflate_BlockchainConfig_Electrum(void);

union BlockchainConfigKind *inflate_BlockchainConfig_Esplora(void);

union BlockchainConfigKind *inflate_BlockchainConfig_Rpc(void);

union DatabaseConfigKind *inflate_DatabaseConfig_Sqlite(void);

union DatabaseConfigKind *inflate_DatabaseConfig_Sled(void);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_blockchain_init);
    dummy_var ^= ((int64_t) (void*) wire_get_blockchain_height);
    dummy_var ^= ((int64_t) (void*) wire_get_blockchain_hash);
    dummy_var ^= ((int64_t) (void*) wire_estimate_fee);
    dummy_var ^= ((int64_t) (void*) wire_broadcast);
    dummy_var ^= ((int64_t) (void*) wire_new_transaction);
    dummy_var ^= ((int64_t) (void*) wire_psbt_to_txid);
    dummy_var ^= ((int64_t) (void*) wire_extract_tx);
    dummy_var ^= ((int64_t) (void*) wire_get_psbt_fee_rate);
    dummy_var ^= ((int64_t) (void*) wire_get_fee_amount);
    dummy_var ^= ((int64_t) (void*) wire_combine_psbt);
    dummy_var ^= ((int64_t) (void*) wire_tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) wire_bump_fee_tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) wire_new_descriptor);
    dummy_var ^= ((int64_t) (void*) wire_new_bip44_descriptor);
    dummy_var ^= ((int64_t) (void*) wire_new_bip44_public);
    dummy_var ^= ((int64_t) (void*) wire_new_bip49_descriptor);
    dummy_var ^= ((int64_t) (void*) wire_new_bip49_public);
    dummy_var ^= ((int64_t) (void*) wire_new_bip84_descriptor);
    dummy_var ^= ((int64_t) (void*) wire_new_bip84_public);
    dummy_var ^= ((int64_t) (void*) wire_as_string_private);
    dummy_var ^= ((int64_t) (void*) wire_as_string);
    dummy_var ^= ((int64_t) (void*) wire_create_descriptor_secret);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_from_string);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_extend);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_derive);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_as_secret_bytes);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_as_public);
    dummy_var ^= ((int64_t) (void*) wire_create_derivation_path);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_public_from_string);
    dummy_var ^= ((int64_t) (void*) wire_create_descriptor_public);
    dummy_var ^= ((int64_t) (void*) wire_init_script);
    dummy_var ^= ((int64_t) (void*) wire_init_address);
    dummy_var ^= ((int64_t) (void*) wire_address_to_script_pubkey_hex);
    dummy_var ^= ((int64_t) (void*) wire_wallet_init);
    dummy_var ^= ((int64_t) (void*) wire_get_address);
    dummy_var ^= ((int64_t) (void*) wire_get_internal_address);
    dummy_var ^= ((int64_t) (void*) wire_get_internalized_address);
    dummy_var ^= ((int64_t) (void*) wire_sync_wallet);
    dummy_var ^= ((int64_t) (void*) wire_get_balance);
    dummy_var ^= ((int64_t) (void*) wire_list_unspent_outputs);
    dummy_var ^= ((int64_t) (void*) wire_get_transactions);
    dummy_var ^= ((int64_t) (void*) wire_sign);
    dummy_var ^= ((int64_t) (void*) wire_get_network);
    dummy_var ^= ((int64_t) (void*) wire_list_unspent);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_word_count);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_string);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_entropy);
    dummy_var ^= ((int64_t) (void*) new_BdkDescriptor);
    dummy_var ^= ((int64_t) (void*) new_BlockchainInstance);
    dummy_var ^= ((int64_t) (void*) new_WalletInstance);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_BdkDescriptor_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_address_index_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_blockchain_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_database_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_electrum_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_esplora_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_f32_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_rpc_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_rpc_sync_params_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_sled_db_configuration_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_sqlite_db_configuration_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u32_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u64_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u8_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_user_pass_0);
    dummy_var ^= ((int64_t) (void*) new_list_out_point_0);
    dummy_var ^= ((int64_t) (void*) new_list_script_amount_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) drop_opaque_BdkDescriptor);
    dummy_var ^= ((int64_t) (void*) share_opaque_BdkDescriptor);
    dummy_var ^= ((int64_t) (void*) drop_opaque_BlockchainInstance);
    dummy_var ^= ((int64_t) (void*) share_opaque_BlockchainInstance);
    dummy_var ^= ((int64_t) (void*) drop_opaque_WalletInstance);
    dummy_var ^= ((int64_t) (void*) share_opaque_WalletInstance);
    dummy_var ^= ((int64_t) (void*) inflate_AddressIndex_Peek);
    dummy_var ^= ((int64_t) (void*) inflate_AddressIndex_Reset);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_Electrum);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_Esplora);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_Rpc);
    dummy_var ^= ((int64_t) (void*) inflate_DatabaseConfig_Sqlite);
    dummy_var ^= ((int64_t) (void*) inflate_DatabaseConfig_Sled);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}