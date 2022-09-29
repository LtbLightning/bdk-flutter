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

typedef struct BlockchainConfig_ELECTRUM {
  struct wire_ElectrumConfig *config;
} BlockchainConfig_ELECTRUM;

typedef struct wire_EsploraConfig {
  struct wire_uint_8_list *base_url;
  struct wire_uint_8_list *proxy;
  uint8_t *concurrency;
  uint64_t stop_gap;
  uint64_t *timeout;
} wire_EsploraConfig;

typedef struct BlockchainConfig_ESPLORA {
  struct wire_EsploraConfig *config;
} BlockchainConfig_ESPLORA;

typedef union BlockchainConfigKind {
  struct BlockchainConfig_ELECTRUM *ELECTRUM;
  struct BlockchainConfig_ESPLORA *ESPLORA;
} BlockchainConfigKind;

typedef struct wire_BlockchainConfig {
  int32_t tag;
  union BlockchainConfigKind *kind;
} wire_BlockchainConfig;

typedef struct DatabaseConfig_MEMORY {

} DatabaseConfig_MEMORY;

typedef struct wire_SqliteConfiguration {
  struct wire_uint_8_list *path;
} wire_SqliteConfiguration;

typedef struct DatabaseConfig_SQLITE {
  struct wire_SqliteConfiguration *config;
} DatabaseConfig_SQLITE;

typedef union DatabaseConfigKind {
  struct DatabaseConfig_MEMORY *MEMORY;
  struct DatabaseConfig_SQLITE *SQLITE;
} DatabaseConfigKind;

typedef struct wire_DatabaseConfig {
  int32_t tag;
  union DatabaseConfigKind *kind;
} wire_DatabaseConfig;

typedef struct wire_AddressAmount {
  struct wire_uint_8_list *address;
  uint64_t amount;
} wire_AddressAmount;

typedef struct wire_list_address_amount {
  struct wire_AddressAmount *ptr;
  int32_t len;
} wire_list_address_amount;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_generate_seed_from_entropy(int64_t port_, int32_t entropy);

void wire_generate_seed_from_word_count(int64_t port_, int32_t word_count);

void wire_create_key(int64_t port_,
                     int32_t node_network,
                     struct wire_uint_8_list *mnemonic,
                     struct wire_uint_8_list *password);

void wire_create_descriptor_secret_keys(int64_t port_,
                                        int32_t node_network,
                                        struct wire_uint_8_list *mnemonic,
                                        struct wire_uint_8_list *path,
                                        struct wire_uint_8_list *password);

void wire_wallet_init(int64_t port_,
                      struct wire_uint_8_list *descriptor,
                      struct wire_uint_8_list *change_descriptor,
                      int32_t network,
                      struct wire_BlockchainConfig *blockchain_config,
                      struct wire_DatabaseConfig *database_config);

void wire_export_wallet(int64_t port_, struct wire_uint_8_list *wallet_name);

void wire_import_wallet(int64_t port_,
                        struct wire_uint_8_list *json_wallet,
                        int32_t network,
                        struct wire_BlockchainConfig *blockchain_config,
                        struct wire_DatabaseConfig *database_config);

void wire_get_public_descriptor(int64_t port_);

void wire_get_descriptor_for_keychain(int64_t port_, int32_t keychain_kind_str);

void wire_get_descriptor_checksum(int64_t port_, int32_t keychain_kind_str);

void wire_get_wallet(int64_t port_);

void wire_get_wallet_network(int64_t port_);

void wire_get_blockchain_height(int64_t port_);

void wire_get_blockchain_hash(int64_t port_, uint64_t blockchain_height);

void wire_sync_wallet(int64_t port_);

void wire_get_balance(int64_t port_);

void wire_list_unspent_outputs(int64_t port_);

void wire_get_new_address(int64_t port_);

void wire_get_new_internal_address(int64_t port_);

void wire_get_last_unused_address(int64_t port_);

void wire_get_transaction(int64_t port_, struct wire_uint_8_list *txid);

void wire_get_transactions(int64_t port_);

void wire_create_transaction(int64_t port_,
                             struct wire_uint_8_list *recipient,
                             uint64_t amount,
                             float fee_rate);

void wire_create_multi_sig_transaction(int64_t port_,
                                       struct wire_list_address_amount *recipients,
                                       float fee_rate);

void wire_sign_and_broadcast(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_sign(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_broadcast(int64_t port_, struct wire_uint_8_list *psbt_str);

struct wire_BlockchainConfig *new_box_autoadd_blockchain_config_0(void);

struct wire_DatabaseConfig *new_box_autoadd_database_config_0(void);

struct wire_ElectrumConfig *new_box_autoadd_electrum_config_0(void);

struct wire_EsploraConfig *new_box_autoadd_esplora_config_0(void);

struct wire_SqliteConfiguration *new_box_autoadd_sqlite_configuration_0(void);

uint64_t *new_box_autoadd_u64_0(uint64_t value);

uint8_t *new_box_autoadd_u8_0(uint8_t value);

struct wire_list_address_amount *new_list_address_amount_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

union BlockchainConfigKind *inflate_BlockchainConfig_ELECTRUM(void);

union BlockchainConfigKind *inflate_BlockchainConfig_ESPLORA(void);

union DatabaseConfigKind *inflate_DatabaseConfig_SQLITE(void);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_entropy);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_word_count);
    dummy_var ^= ((int64_t) (void*) wire_create_key);
    dummy_var ^= ((int64_t) (void*) wire_create_descriptor_secret_keys);
    dummy_var ^= ((int64_t) (void*) wire_wallet_init);
    dummy_var ^= ((int64_t) (void*) wire_export_wallet);
    dummy_var ^= ((int64_t) (void*) wire_import_wallet);
    dummy_var ^= ((int64_t) (void*) wire_get_public_descriptor);
    dummy_var ^= ((int64_t) (void*) wire_get_descriptor_for_keychain);
    dummy_var ^= ((int64_t) (void*) wire_get_descriptor_checksum);
    dummy_var ^= ((int64_t) (void*) wire_get_wallet);
    dummy_var ^= ((int64_t) (void*) wire_get_wallet_network);
    dummy_var ^= ((int64_t) (void*) wire_get_blockchain_height);
    dummy_var ^= ((int64_t) (void*) wire_get_blockchain_hash);
    dummy_var ^= ((int64_t) (void*) wire_sync_wallet);
    dummy_var ^= ((int64_t) (void*) wire_get_balance);
    dummy_var ^= ((int64_t) (void*) wire_list_unspent_outputs);
    dummy_var ^= ((int64_t) (void*) wire_get_new_address);
    dummy_var ^= ((int64_t) (void*) wire_get_new_internal_address);
    dummy_var ^= ((int64_t) (void*) wire_get_last_unused_address);
    dummy_var ^= ((int64_t) (void*) wire_get_transaction);
    dummy_var ^= ((int64_t) (void*) wire_get_transactions);
    dummy_var ^= ((int64_t) (void*) wire_create_transaction);
    dummy_var ^= ((int64_t) (void*) wire_create_multi_sig_transaction);
    dummy_var ^= ((int64_t) (void*) wire_sign_and_broadcast);
    dummy_var ^= ((int64_t) (void*) wire_sign);
    dummy_var ^= ((int64_t) (void*) wire_broadcast);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_blockchain_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_database_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_electrum_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_esplora_config_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_sqlite_configuration_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u64_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u8_0);
    dummy_var ^= ((int64_t) (void*) new_list_address_amount_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_ELECTRUM);
    dummy_var ^= ((int64_t) (void*) inflate_BlockchainConfig_ESPLORA);
    dummy_var ^= ((int64_t) (void*) inflate_DatabaseConfig_SQLITE);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}