#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_wallet_init(int64_t port_,
                      struct wire_uint_8_list *descriptor,
                      struct wire_uint_8_list *change_descriptor,
                      struct wire_uint_8_list *network,
                      struct wire_uint_8_list *blockchain,
                      struct wire_uint_8_list *url,
                      struct wire_uint_8_list *socks5_or_proxy);

void wire_get_wallet(int64_t port_);

void wire_sync_wallet(int64_t port_);

void wire_get_balance(int64_t port_);

void wire_get_new_address(int64_t port_);

void wire_get_last_unused_address(int64_t port_);

void wire_get_transactions(int64_t port_);

void wire_create_transaction(int64_t port_,
                             struct wire_uint_8_list *recipient,
                             uint64_t amount,
                             float fee_rate);

void wire_sign_and_broadcast(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_sign(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_broadcast(int64_t port_, struct wire_uint_8_list *psbt_str);

void wire_generate_seed_from_entropy(int64_t port_, struct wire_uint_8_list *entropy);

void wire_generate_seed_from_word_count(int64_t port_, struct wire_uint_8_list *word_count);

void wire_create_key(int64_t port_,
                     struct wire_uint_8_list *node_network,
                     struct wire_uint_8_list *mnemonic,
                     struct wire_uint_8_list *path,
                     struct wire_uint_8_list *password);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_wallet_init);
    dummy_var ^= ((int64_t) (void*) wire_get_wallet);
    dummy_var ^= ((int64_t) (void*) wire_sync_wallet);
    dummy_var ^= ((int64_t) (void*) wire_get_balance);
    dummy_var ^= ((int64_t) (void*) wire_get_new_address);
    dummy_var ^= ((int64_t) (void*) wire_get_last_unused_address);
    dummy_var ^= ((int64_t) (void*) wire_get_transactions);
    dummy_var ^= ((int64_t) (void*) wire_create_transaction);
    dummy_var ^= ((int64_t) (void*) wire_sign_and_broadcast);
    dummy_var ^= ((int64_t) (void*) wire_sign);
    dummy_var ^= ((int64_t) (void*) wire_broadcast);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_entropy);
    dummy_var ^= ((int64_t) (void*) wire_generate_seed_from_word_count);
    dummy_var ^= ((int64_t) (void*) wire_create_key);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}