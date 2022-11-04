#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

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
} wire_ElectrumConfig;

typedef struct BlockchainConfig_Electrum {
  struct wire_ElectrumConfig *config;
} BlockchainConfig_Electrum;

typedef struct wire_EsploraConfig {
  struct wire_uint_8_list *base_url;
  struct wire_uint_8_list *proxy;
  uint8_t *concurrency;
  uint64_t stop_gap;
  uint64_t *timeout;
} wire_EsploraConfig;

typedef struct BlockchainConfig_Esplora {
  struct wire_EsploraConfig *config;
} BlockchainConfig_Esplora;

typedef union BlockchainConfigKind {
  struct BlockchainConfig_Electrum *Electrum;
  struct BlockchainConfig_Esplora *Esplora;
} BlockchainConfigKind;

typedef struct wire_BlockchainConfig {
  int32_t tag;
  union BlockchainConfigKind *kind;
} wire_BlockchainConfig;

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

typedef struct DatabaseConfig_Memory {

} DatabaseConfig_Memory;

typedef struct wire_SqliteDbConfiguration {
  struct wire_uint_8_list *path;
} wire_SqliteDbConfiguration;

typedef struct DatabaseConfig_Sqlite {
  struct wire_SqliteDbConfiguration *config;
} DatabaseConfig_Sqlite;

typedef struct wire_SledDbConfiguration {
  struct wire_uint_8_list *path;
  struct wire_uint_8_list *tree_name;
} wire_SledDbConfiguration;

typedef struct DatabaseConfig_Sled {
  struct wire_SledDbConfiguration *config;
} DatabaseConfig_Sled;

typedef union DatabaseConfigKind {
  struct DatabaseConfig_Memory *Memory;
  struct DatabaseConfig_Sqlite *Sqlite;
  struct DatabaseConfig_Sled *Sled;
} DatabaseConfigKind;

typedef struct wire_DatabaseConfig {
  int32_t tag;
  union DatabaseConfigKind *kind;
} wire_DatabaseConfig;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_blockchain_init(int64_t port_, struct wire_BlockchainConfig *config);

void wire_get_blockchain_height(int64_t port_, struct wire_uint_8_list *blockchain_id);

void wire_get_blockchain_hash(int64_t port_,
                              uint64_t blockchain_height,
                              struct wire_uint_8_list *id);

void wire_broadcast(int64_t port_,
                    struct wire_uint_8_list *psbt_str,
                    struct wire_uint_8_list *blockchain_id);

void wire_psbt_to_txid(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_extract_tx(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_combine_psbt(int64_t port_,
                       struct wire_uint_8_list *psbt_str,
                       struct wire_uint_8_list *other);

void wire_tx_builder_finish(int64_t port_,
                            struct wire_uint_8_list *wallet_id,
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
                                     struct wire_uint_8_list *wallet_id,
                                     bool enable_rbf,
                                     uint32_t *n_sequence);

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

void wire_create_descriptor_secret(int64_t port_,
                                   int32_t network,
                                   struct wire_uint_8_list *mnemonic,
                                   struct wire_uint_8_list *password);

void wire_create_derivation_path(int64_t port_, struct wire_uint_8_list *path);

void wire_create_descriptor_public(int64_t port_,
                                   struct wire_uint_8_list *xpub,
                                   struct wire_uint_8_list *path,
                                   bool derive);

void wire_init_script(int64_t port_, struct wire_uint_8_list *raw_output_script);

void wire_init_address(int64_t port_, struct wire_uint_8_list *address);

void wire_address_to_script_pubkey_hex(int64_t port_, struct wire_uint_8_list *address);

void wire_wallet_init(int64_t port_,
                      struct wire_uint_8_list *descriptor,
                      struct wire_uint_8_list *change_descriptor,
                      int32_t network,
                      struct wire_DatabaseConfig *database_config);

void wire_get_address(int64_t port_, struct wire_uint_8_list *wallet_id, int32_t address_index);

void wire_sync_wallet(int64_t port_,
                      struct wire_uint_8_list *wallet_id,
                      struct wire_uint_8_list *blockchain_id);

void wire_get_balance(int64_t port_, struct wire_uint_8_list *wallet_id);

void wire_list_unspent_outputs(int64_t port_, struct wire_uint_8_list *wallet_id);

void wire_get_transactions(int64_t port_, struct wire_uint_8_list *wallet_id);

void wire_sign(int64_t port_,
               struct wire_uint_8_list *wallet_id,
               struct wire_uint_8_list *psbt_str,
               bool is_multi_sig);

void wire_get_network(int64_t port_, struct wire_uint_8_list *wallet_id);

void wire_list_unspent(int64_t port_, struct wire_uint_8_list *wallet_id);

void wire_generate_seed_from_word_count(int64_t port_, int32_t word_count);

struct wire_BlockchainConfig *new_box_autoadd_blockchain_config_0(void);

struct wire_DatabaseConfig *new_box_autoadd_database_config_0(void);

struct wire_ElectrumConfig *new_box_autoadd_electrum_config_0(void);

struct wire_EsploraConfig *new_box_autoadd_esplora_config_0(void);

float *new_box_autoadd_f32_0(float value);

struct wire_SledDbConfiguration *new_box_autoadd_sled_db_configuration_0(void);

struct wire_SqliteDbConfiguration *new_box_autoadd_sqlite_db_configuration_0(void);

uint32_t *new_box_autoadd_u32_0(uint32_t value);

uint64_t *new_box_autoadd_u64_0(uint64_t value);

uint8_t *new_box_autoadd_u8_0(uint8_t value);

struct wire_list_out_point *new_list_out_point_0(int32_t len);

struct wire_list_script_amount *new_list_script_amount_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

union BlockchainConfigKind *inflate_BlockchainConfig_Electrum(void);

union BlockchainConfigKind *inflate_BlockchainConfig_Esplora(void);

union DatabaseConfigKind *inflate_DatabaseConfig_Sqlite(void);

union DatabaseConfigKind *inflate_DatabaseConfig_Sled(void);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_blockchain_init);
    dummy_var ^= ((int64_t) (void*) wire_get_blockchain_height);
    dummy_var ^= ((int64_t) (void*) wire_get_blockchain_hash);
    dummy_var ^= ((int64_t) (void*) wire_broadcast);
    dummy_var ^= ((int64_t) (void*) wire_psbt_to_txid);
    dummy_var ^= ((int64_t) (void*) wire_extract_tx);
    dummy_var ^= ((int64_t) (void*) wire_combine_psbt);
    dummy_var ^= ((int64_t) (void*) wire_tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) wire_bump_fee_tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_extend);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_derive);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_as_secret_bytes);
    dummy_var ^= ((int64_t) (void*) wire_descriptor_secret_as_public);
    dummy_var ^= ((int64_t) (void*) wire_create_descriptor_secret);
    dummy_var ^= ((int64_t) (void*) wire_create_derivation_path);
    dummy_var ^= ((int64_t) (void*) wire_create_descriptor_public);
    dummy_var ^= ((int64_t) (void*) wire_init_script);
    dummy_var ^= ((int64_t) (void*) wire_init_address);
    dummy_var ^= ((int64_t) (void*) wire_address_to_script_pubkey_hex);
    dummy_var ^= ((int64_t) (void*) wire_wallet_init);
    dummy_var ^= ((int64_t) (void*) wire_get_address);
    dummy_var ^= ((int64_t) (void*) wire_sync_wallet);
    dummy_var ^= ((int64_t) (void*) wire_get_balance);
    dummy_var ^= ((int64_t) (void*) wire_list_unspent_outputs);
    dummy_var ^= ((int64_t) (void*) wire_get_transactions);
    dummy_var ^= ((int64_t) (void*) wire_sign);
    dummy_var ^= ((int64_t) (void*) wire_get_network);
    dummy_var ^= ((int64_t) (void*) wire_list_unspent);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_word_count);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_blockchain_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_database_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_electrum_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_esplora_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_f32_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_sled_db_configuration_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_sqlite_db_configuration_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u32_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u64_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u8_0);
    dummy_var ^= ((int64_t) (void*) new_list_out_point_0);
    dummy_var ^= ((int64_t) (void*) new_list_script_amount_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_Electrum);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_Esplora);
    dummy_var ^= ((int64_t) (void*) inflate_DatabaseConfig_Sqlite);
    dummy_var ^= ((int64_t) (void*) inflate_DatabaseConfig_Sled);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}