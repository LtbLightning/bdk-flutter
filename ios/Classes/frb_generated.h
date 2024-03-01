#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
// EXTRA BEGIN
typedef struct DartCObject *WireSyncRust2DartDco;
typedef struct WireSyncRust2DartSse {
  uint8_t *ptr;
  int32_t len;
} WireSyncRust2DartSse;

typedef int64_t DartPort;
typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);
void store_dart_post_cobject(DartPostCObjectFnType ptr);
// EXTRA END
typedef struct _Dart_Handle* Dart_Handle;

typedef struct wire_cst_address_base {
  uintptr_t field0;
} wire_cst_address_base;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_script_buf_base {
  struct wire_cst_list_prim_u_8_strict *bytes;
} wire_cst_script_buf_base;

typedef struct wire_cst_transaction_base {
  struct wire_cst_list_prim_u_8_strict *inner;
} wire_cst_transaction_base;

typedef struct wire_cst_list_prim_u_8_loose {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_loose;

typedef struct wire_cst_BitcoinAddressError_Base58 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BitcoinAddressError_Base58;

typedef struct wire_cst_BitcoinAddressError_Bech32 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BitcoinAddressError_Bech32;

typedef struct wire_cst_BitcoinAddressError_InvalidBech32Variant {
  int32_t expected;
  int32_t found;
} wire_cst_BitcoinAddressError_InvalidBech32Variant;

typedef struct wire_cst_BitcoinAddressError_InvalidWitnessVersion {
  uint8_t field0;
} wire_cst_BitcoinAddressError_InvalidWitnessVersion;

typedef struct wire_cst_BitcoinAddressError_UnparsableWitnessVersion {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BitcoinAddressError_UnparsableWitnessVersion;

typedef struct wire_cst_BitcoinAddressError_InvalidWitnessProgramLength {
  uintptr_t field0;
} wire_cst_BitcoinAddressError_InvalidWitnessProgramLength;

typedef struct wire_cst_BitcoinAddressError_InvalidSegwitV0ProgramLength {
  uintptr_t field0;
} wire_cst_BitcoinAddressError_InvalidSegwitV0ProgramLength;

typedef struct wire_cst_BitcoinAddressError_UnknownAddressType {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BitcoinAddressError_UnknownAddressType;

typedef struct wire_cst_BitcoinAddressError_NetworkValidation {
  int32_t network_required;
  int32_t network_found;
  struct wire_cst_list_prim_u_8_strict *address;
} wire_cst_BitcoinAddressError_NetworkValidation;

typedef union BitcoinAddressErrorKind {
  struct wire_cst_BitcoinAddressError_Base58 Base58;
  struct wire_cst_BitcoinAddressError_Bech32 Bech32;
  struct wire_cst_BitcoinAddressError_InvalidBech32Variant InvalidBech32Variant;
  struct wire_cst_BitcoinAddressError_InvalidWitnessVersion InvalidWitnessVersion;
  struct wire_cst_BitcoinAddressError_UnparsableWitnessVersion UnparsableWitnessVersion;
  struct wire_cst_BitcoinAddressError_InvalidWitnessProgramLength InvalidWitnessProgramLength;
  struct wire_cst_BitcoinAddressError_InvalidSegwitV0ProgramLength InvalidSegwitV0ProgramLength;
  struct wire_cst_BitcoinAddressError_UnknownAddressType UnknownAddressType;
  struct wire_cst_BitcoinAddressError_NetworkValidation NetworkValidation;
} BitcoinAddressErrorKind;

typedef struct wire_cst_bitcoin_address_error {
  int32_t tag;
  union BitcoinAddressErrorKind kind;
} wire_cst_bitcoin_address_error;

typedef struct wire_cst_BitcoinConsensusError_Io {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BitcoinConsensusError_Io;

typedef struct wire_cst_BitcoinConsensusError_OversizedVectorAllocation {
  uintptr_t requested;
  uintptr_t max;
} wire_cst_BitcoinConsensusError_OversizedVectorAllocation;

typedef struct wire_cst_BitcoinConsensusError_InvalidChecksum {
  struct wire_cst_list_prim_u_8_strict *expected;
  struct wire_cst_list_prim_u_8_strict *actual;
} wire_cst_BitcoinConsensusError_InvalidChecksum;

typedef struct wire_cst_BitcoinConsensusError_ParseFailed {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BitcoinConsensusError_ParseFailed;

typedef struct wire_cst_BitcoinConsensusError_UnsupportedSegwitFlag {
  uint8_t field0;
} wire_cst_BitcoinConsensusError_UnsupportedSegwitFlag;

typedef union BitcoinConsensusErrorKind {
  struct wire_cst_BitcoinConsensusError_Io Io;
  struct wire_cst_BitcoinConsensusError_OversizedVectorAllocation OversizedVectorAllocation;
  struct wire_cst_BitcoinConsensusError_InvalidChecksum InvalidChecksum;
  struct wire_cst_BitcoinConsensusError_ParseFailed ParseFailed;
  struct wire_cst_BitcoinConsensusError_UnsupportedSegwitFlag UnsupportedSegwitFlag;
} BitcoinConsensusErrorKind;

typedef struct wire_cst_bitcoin_consensus_error {
  int32_t tag;
  union BitcoinConsensusErrorKind kind;
} wire_cst_bitcoin_consensus_error;

typedef struct wire_cst_BitcoinHexError_InvalidChar {
  uint8_t field0;
} wire_cst_BitcoinHexError_InvalidChar;

typedef struct wire_cst_BitcoinHexError_OddLengthString {
  uintptr_t field0;
} wire_cst_BitcoinHexError_OddLengthString;

typedef struct wire_cst_BitcoinHexError_InvalidLength {
  uintptr_t field0;
  uintptr_t field1;
} wire_cst_BitcoinHexError_InvalidLength;

typedef union BitcoinHexErrorKind {
  struct wire_cst_BitcoinHexError_InvalidChar InvalidChar;
  struct wire_cst_BitcoinHexError_OddLengthString OddLengthString;
  struct wire_cst_BitcoinHexError_InvalidLength InvalidLength;
} BitcoinHexErrorKind;

typedef struct wire_cst_bitcoin_hex_error {
  int32_t tag;
  union BitcoinHexErrorKind kind;
} wire_cst_bitcoin_hex_error;

typedef struct wire_cst_list_list_prim_u_8_strict {
  struct wire_cst_list_prim_u_8_strict **ptr;
  int32_t len;
} wire_cst_list_list_prim_u_8_strict;

typedef struct wire_cst_out_point {
  struct wire_cst_list_prim_u_8_strict *txid;
  uint32_t vout;
} wire_cst_out_point;

typedef struct wire_cst_tx_in {
  struct wire_cst_out_point previous_output;
  struct wire_cst_script_buf_base script_sig;
  uint32_t sequence;
  struct wire_cst_list_list_prim_u_8_strict *witness;
} wire_cst_tx_in;

typedef struct wire_cst_list_tx_in {
  struct wire_cst_tx_in *ptr;
  int32_t len;
} wire_cst_list_tx_in;

typedef struct wire_cst_tx_out {
  uint64_t value;
  struct wire_cst_script_buf_base script_pubkey;
} wire_cst_tx_out;

typedef struct wire_cst_list_tx_out {
  struct wire_cst_tx_out *ptr;
  int32_t len;
} wire_cst_list_tx_out;

typedef struct wire_cst_BdkError_HexError {
  struct wire_cst_bitcoin_hex_error *field0;
} wire_cst_BdkError_HexError;

typedef struct wire_cst_BdkError_ConsensusError {
  struct wire_cst_bitcoin_consensus_error *field0;
} wire_cst_BdkError_ConsensusError;

typedef struct wire_cst_BdkError_AddressError {
  struct wire_cst_bitcoin_address_error *field0;
} wire_cst_BdkError_AddressError;

typedef union BdkErrorKind {
  struct wire_cst_BdkError_HexError HexError;
  struct wire_cst_BdkError_ConsensusError ConsensusError;
  struct wire_cst_BdkError_AddressError AddressError;
} BdkErrorKind;

typedef struct wire_cst_bdk_error {
  int32_t tag;
  union BdkErrorKind kind;
} wire_cst_bdk_error;

typedef struct wire_cst_Payload_PubkeyHash {
  struct wire_cst_list_prim_u_8_strict *pubkey_hash;
} wire_cst_Payload_PubkeyHash;

typedef struct wire_cst_Payload_ScriptHash {
  struct wire_cst_list_prim_u_8_strict *script_hash;
} wire_cst_Payload_ScriptHash;

typedef struct wire_cst_Payload_WitnessProgram {
  int32_t version;
  struct wire_cst_list_prim_u_8_strict *program;
} wire_cst_Payload_WitnessProgram;

typedef union PayloadKind {
  struct wire_cst_Payload_PubkeyHash PubkeyHash;
  struct wire_cst_Payload_ScriptHash ScriptHash;
  struct wire_cst_Payload_WitnessProgram WitnessProgram;
} PayloadKind;

typedef struct wire_cst_payload {
  int32_t tag;
  union PayloadKind kind;
} wire_cst_payload;

void frbgen_bdk_flutter_wire_AddressBase_as_string(int64_t port_,
                                                   struct wire_cst_address_base *that);

void frbgen_bdk_flutter_wire_AddressBase_from_script(int64_t port_,
                                                     struct wire_cst_script_buf_base *script,
                                                     int32_t network);

void frbgen_bdk_flutter_wire_AddressBase_from_string(int64_t port_,
                                                     struct wire_cst_list_prim_u_8_strict *address,
                                                     int32_t network);

void frbgen_bdk_flutter_wire_AddressBase_is_valid_for_network(int64_t port_,
                                                              struct wire_cst_address_base *that,
                                                              int32_t network);

void frbgen_bdk_flutter_wire_AddressBase_network(int64_t port_, struct wire_cst_address_base *that);

void frbgen_bdk_flutter_wire_AddressBase_payload(int64_t port_, struct wire_cst_address_base *that);

void frbgen_bdk_flutter_wire_AddressBase_script_pubkey(int64_t port_,
                                                       struct wire_cst_address_base *that);

void frbgen_bdk_flutter_wire_AddressBase_to_qr_uri(int64_t port_,
                                                   struct wire_cst_address_base *that);

void frbgen_bdk_flutter_wire_ScriptBufBase_empty(int64_t port_);

void frbgen_bdk_flutter_wire_ScriptBufBase_from_hex(int64_t port_,
                                                    struct wire_cst_list_prim_u_8_strict *s);

void frbgen_bdk_flutter_wire_ScriptBufBase_with_capacity(int64_t port_, uintptr_t capacity);

void frbgen_bdk_flutter_wire_TransactionBase_input(int64_t port_,
                                                   struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_is_coin_base(int64_t port_,
                                                          struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_is_explicitly_rbf(int64_t port_,
                                                               struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_is_lock_time_enabled(int64_t port_,
                                                                  struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_lock_time(int64_t port_,
                                                       struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_new(int64_t port_,
                                                 struct wire_cst_list_prim_u_8_loose *transaction_bytes);

void frbgen_bdk_flutter_wire_TransactionBase_output(int64_t port_,
                                                    struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_serialize(int64_t port_,
                                                       struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_size(int64_t port_,
                                                  struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_txid(int64_t port_,
                                                  struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_version(int64_t port_,
                                                     struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_vsize(int64_t port_,
                                                   struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_wire_TransactionBase_weight(int64_t port_,
                                                    struct wire_cst_transaction_base *that);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedrust_asyncRwLockbdkbitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedrust_asyncRwLockbdkbitcoinAddress(const void *ptr);

struct wire_cst_address_base *frbgen_bdk_flutter_cst_new_box_autoadd_address_base(void);

struct wire_cst_bitcoin_address_error *frbgen_bdk_flutter_cst_new_box_autoadd_bitcoin_address_error(void);

struct wire_cst_bitcoin_consensus_error *frbgen_bdk_flutter_cst_new_box_autoadd_bitcoin_consensus_error(void);

struct wire_cst_bitcoin_hex_error *frbgen_bdk_flutter_cst_new_box_autoadd_bitcoin_hex_error(void);

struct wire_cst_script_buf_base *frbgen_bdk_flutter_cst_new_box_autoadd_script_buf_base(void);

struct wire_cst_transaction_base *frbgen_bdk_flutter_cst_new_box_autoadd_transaction_base(void);

struct wire_cst_list_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_prim_u_8_loose *frbgen_bdk_flutter_cst_new_list_prim_u_8_loose(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_tx_in *frbgen_bdk_flutter_cst_new_list_tx_in(int32_t len);

struct wire_cst_list_tx_out *frbgen_bdk_flutter_cst_new_list_tx_out(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_address_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bitcoin_address_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bitcoin_consensus_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bitcoin_hex_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_script_buf_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_transaction_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_loose);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_tx_in);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_tx_out);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedrust_asyncRwLockbdkbitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedrust_asyncRwLockbdkbitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_from_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_is_valid_for_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_payload);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_script_pubkey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_to_qr_uri);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_ScriptBufBase_empty);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_ScriptBufBase_from_hex);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_ScriptBufBase_with_capacity);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_input);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_is_coin_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_is_explicitly_rbf);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_is_lock_time_enabled);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_output);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_size);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_txid);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_version);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_vsize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_TransactionBase_weight);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
