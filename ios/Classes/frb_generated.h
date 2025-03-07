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

typedef struct wire_cst_ffi_address {
  uintptr_t field0;
} wire_cst_ffi_address;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_ffi_script_buf {
  struct wire_cst_list_prim_u_8_strict *bytes;
} wire_cst_ffi_script_buf;

typedef struct wire_cst_ffi_psbt {
  uintptr_t opaque;
} wire_cst_ffi_psbt;

typedef struct wire_cst_ffi_transaction {
  uintptr_t opaque;
} wire_cst_ffi_transaction;

typedef struct wire_cst_list_prim_u_8_loose {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_loose;

typedef struct wire_cst_LockTime_Blocks {
  uint32_t field0;
} wire_cst_LockTime_Blocks;

typedef struct wire_cst_LockTime_Seconds {
  uint32_t field0;
} wire_cst_LockTime_Seconds;

typedef union LockTimeKind {
  struct wire_cst_LockTime_Blocks Blocks;
  struct wire_cst_LockTime_Seconds Seconds;
} LockTimeKind;

typedef struct wire_cst_lock_time {
  int32_t tag;
  union LockTimeKind kind;
} wire_cst_lock_time;

typedef struct wire_cst_out_point {
  struct wire_cst_list_prim_u_8_strict *txid;
  uint32_t vout;
} wire_cst_out_point;

typedef struct wire_cst_list_list_prim_u_8_strict {
  struct wire_cst_list_prim_u_8_strict **ptr;
  int32_t len;
} wire_cst_list_list_prim_u_8_strict;

typedef struct wire_cst_bdk_tx_in {
  struct wire_cst_out_point previous_output;
  struct wire_cst_ffi_script_buf script_sig;
  uint32_t sequence;
  struct wire_cst_list_list_prim_u_8_strict *witness;
} wire_cst_bdk_tx_in;

typedef struct wire_cst_list_bdk_tx_in {
  struct wire_cst_bdk_tx_in *ptr;
  int32_t len;
} wire_cst_list_bdk_tx_in;

typedef struct wire_cst_bdk_tx_out {
  uint64_t value;
  struct wire_cst_ffi_script_buf script_pubkey;
} wire_cst_tx_out;

typedef struct wire_cst_list_bdk_tx_out {
  struct wire_cst_bdk_tx_out *ptr;
  int32_t len;
} wire_cst_list_tx_out;

typedef struct wire_cst_ffi_descriptor {
  uintptr_t extended_descriptor;
  uintptr_t key_map;
} wire_cst_ffi_descriptor;

typedef struct wire_cst_ffi_descriptor_secret_key {
  uintptr_t opaque;
} wire_cst_ffi_descriptor_secret_key;

typedef struct wire_cst_ffi_descriptor_public_key {
  uintptr_t opaque;
} wire_cst_ffi_descriptor_public_key;

typedef struct wire_cst_ffi_electrum_client {
  uintptr_t opaque;
} wire_cst_ffi_electrum_client;

typedef struct wire_cst_ffi_full_scan_request {
  uintptr_t field0;
} wire_cst_ffi_full_scan_request;

typedef struct wire_cst_ffi_sync_request {
  uintptr_t field0;
} wire_cst_ffi_sync_request;

typedef struct wire_cst_ffi_esplora_client {
  uintptr_t opaque;
} wire_cst_ffi_esplora_client;

typedef struct wire_cst_ffi_derivation_path {
  uintptr_t opaque;
} wire_cst_ffi_derivation_path;

typedef struct wire_cst_ffi_mnemonic {
  uintptr_t opaque;
} wire_cst_ffi_mnemonic;

typedef struct wire_cst_fee_rate {
  uint64_t sat_kwu;
} wire_cst_fee_rate;

typedef struct wire_cst_ffi_wallet {
  uintptr_t opaque;
} wire_cst_ffi_wallet;

typedef struct wire_cst_record_ffi_script_buf_u_64 {
  struct wire_cst_ffi_script_buf field0;
  uint64_t field1;
} wire_cst_record_ffi_script_buf_u_64;

typedef struct wire_cst_list_record_ffi_script_buf_u_64 {
  struct wire_cst_record_ffi_script_buf_u_64 *ptr;
  int32_t len;
} wire_cst_list_record_ffi_script_buf_u_64;

typedef struct wire_cst_list_out_point {
  struct wire_cst_out_point *ptr;
  int32_t len;
} wire_cst_list_out_point;

typedef struct wire_cst_list_prim_usize_strict {
  uintptr_t *ptr;
  int32_t len;
} wire_cst_list_prim_usize_strict;

typedef struct wire_cst_record_string_list_prim_usize_strict {
  struct wire_cst_list_prim_u_8_strict *field0;
  struct wire_cst_list_prim_usize_strict *field1;
} wire_cst_record_string_list_prim_usize_strict;

typedef struct wire_cst_list_record_string_list_prim_usize_strict {
  struct wire_cst_record_string_list_prim_usize_strict *ptr;
  int32_t len;
} wire_cst_list_record_string_list_prim_usize_strict;

typedef struct wire_cst_record_map_string_list_prim_usize_strict_keychain_kind {
  struct wire_cst_list_record_string_list_prim_usize_strict *field0;
  int32_t field1;
} wire_cst_record_map_string_list_prim_usize_strict_keychain_kind;

typedef struct wire_cst_RbfValue_Value {
  uint32_t field0;
} wire_cst_RbfValue_Value;

typedef union RbfValueKind {
  struct wire_cst_RbfValue_Value Value;
} RbfValueKind;

typedef struct wire_cst_rbf_value {
  int32_t tag;
  union RbfValueKind kind;
} wire_cst_rbf_value;

typedef struct wire_cst_ffi_full_scan_request_builder {
  uintptr_t field0;
} wire_cst_ffi_full_scan_request_builder;

typedef struct wire_cst_ffi_policy {
  uintptr_t opaque;
} wire_cst_ffi_policy;

typedef struct wire_cst_ffi_sync_request_builder {
  uintptr_t field0;
} wire_cst_ffi_sync_request_builder;

typedef struct wire_cst_ffi_update {
  uintptr_t field0;
} wire_cst_ffi_update;

typedef struct wire_cst_ffi_connection {
  uintptr_t field0;
} wire_cst_ffi_connection;

typedef struct wire_cst_sign_options {
  bool trust_witness_utxo;
  uint32_t *assume_height;
  bool allow_all_sighashes;
  bool try_finalize;
  bool sign_with_tap_internal_key;
  bool allow_grinding;
} wire_cst_sign_options;

typedef struct wire_cst_block_id {
  uint32_t height;
  struct wire_cst_list_prim_u_8_strict *hash;
} wire_cst_block_id;

typedef struct wire_cst_confirmation_block_time {
  struct wire_cst_block_id block_id;
  uint64_t confirmation_time;
} wire_cst_confirmation_block_time;

typedef struct wire_cst_ChainPosition_Confirmed {
  struct wire_cst_confirmation_block_time *confirmation_block_time;
} wire_cst_ChainPosition_Confirmed;

typedef struct wire_cst_ChainPosition_Unconfirmed {
  uint64_t timestamp;
} wire_cst_ChainPosition_Unconfirmed;

typedef union ChainPositionKind {
  struct wire_cst_ChainPosition_Confirmed Confirmed;
  struct wire_cst_ChainPosition_Unconfirmed Unconfirmed;
} ChainPositionKind;

typedef struct wire_cst_chain_position {
  int32_t tag;
  union ChainPositionKind kind;
} wire_cst_chain_position;

typedef struct wire_cst_ffi_canonical_tx {
  struct wire_cst_ffi_transaction transaction;
  struct wire_cst_chain_position chain_position;
} wire_cst_ffi_canonical_tx;

typedef struct wire_cst_list_ffi_canonical_tx {
  struct wire_cst_ffi_canonical_tx *ptr;
  int32_t len;
} wire_cst_list_ffi_canonical_tx;

typedef struct wire_cst_local_output {
  struct wire_cst_out_point outpoint;
  struct wire_cst_tx_out txout;
  int32_t keychain;
  bool is_spent;
} wire_cst_local_output;

typedef struct wire_cst_list_local_output {
  struct wire_cst_local_output *ptr;
  int32_t len;
} wire_cst_list_local_output;

typedef struct wire_cst_address_info {
  uint32_t index;
  struct wire_cst_ffi_address address;
  int32_t keychain;
} wire_cst_address_info;

typedef struct wire_cst_AddressParseError_WitnessVersion {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_AddressParseError_WitnessVersion;

typedef struct wire_cst_AddressParseError_WitnessProgram {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_AddressParseError_WitnessProgram;

typedef union AddressParseErrorKind {
  struct wire_cst_AddressParseError_WitnessVersion WitnessVersion;
  struct wire_cst_AddressParseError_WitnessProgram WitnessProgram;
} AddressParseErrorKind;

typedef struct wire_cst_address_parse_error {
  int32_t tag;
  union AddressParseErrorKind kind;
} wire_cst_address_parse_error;

typedef struct wire_cst_balance {
  uint64_t immature;
  uint64_t trusted_pending;
  uint64_t untrusted_pending;
  uint64_t confirmed;
  uint64_t spendable;
  uint64_t total;
} wire_cst_balance;

typedef struct wire_cst_Bip32Error_Secp256k1 {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_Bip32Error_Secp256k1;

typedef struct wire_cst_Bip32Error_InvalidChildNumber {
  uint32_t child_number;
} wire_cst_Bip32Error_InvalidChildNumber;

typedef struct wire_cst_Bip32Error_UnknownVersion {
  struct wire_cst_list_prim_u_8_strict *version;
} wire_cst_Bip32Error_UnknownVersion;

typedef struct wire_cst_Bip32Error_WrongExtendedKeyLength {
  uint32_t length;
} wire_cst_Bip32Error_WrongExtendedKeyLength;

typedef struct wire_cst_Bip32Error_Base58 {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_Bip32Error_Base58;

typedef struct wire_cst_Bip32Error_Hex {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_Bip32Error_Hex;

typedef struct wire_cst_Bip32Error_InvalidPublicKeyHexLength {
  uint32_t length;
} wire_cst_Bip32Error_InvalidPublicKeyHexLength;

typedef struct wire_cst_Bip32Error_UnknownError {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_Bip32Error_UnknownError;

typedef union Bip32ErrorKind {
  struct wire_cst_Bip32Error_Secp256k1 Secp256k1;
  struct wire_cst_Bip32Error_InvalidChildNumber InvalidChildNumber;
  struct wire_cst_Bip32Error_UnknownVersion UnknownVersion;
  struct wire_cst_Bip32Error_WrongExtendedKeyLength WrongExtendedKeyLength;
  struct wire_cst_Bip32Error_Base58 Base58;
  struct wire_cst_Bip32Error_Hex Hex;
  struct wire_cst_Bip32Error_InvalidPublicKeyHexLength InvalidPublicKeyHexLength;
  struct wire_cst_Bip32Error_UnknownError UnknownError;
} Bip32ErrorKind;

typedef struct wire_cst_bip_32_error {
  int32_t tag;
  union Bip32ErrorKind kind;
} wire_cst_bip_32_error;

typedef struct wire_cst_Bip39Error_BadWordCount {
  uint64_t word_count;
} wire_cst_Bip39Error_BadWordCount;

typedef struct wire_cst_Bip39Error_UnknownWord {
  uint64_t index;
} wire_cst_Bip39Error_UnknownWord;

typedef struct wire_cst_Bip39Error_BadEntropyBitCount {
  uint64_t bit_count;
} wire_cst_Bip39Error_BadEntropyBitCount;

typedef struct wire_cst_Bip39Error_AmbiguousLanguages {
  struct wire_cst_list_prim_u_8_strict *languages;
} wire_cst_Bip39Error_AmbiguousLanguages;

typedef struct wire_cst_Bip39Error_Generic {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_Bip39Error_Generic;

typedef union Bip39ErrorKind {
  struct wire_cst_Bip39Error_BadWordCount BadWordCount;
  struct wire_cst_Bip39Error_UnknownWord UnknownWord;
  struct wire_cst_Bip39Error_BadEntropyBitCount BadEntropyBitCount;
  struct wire_cst_Bip39Error_AmbiguousLanguages AmbiguousLanguages;
  struct wire_cst_Bip39Error_Generic Generic;
} Bip39ErrorKind;

typedef struct wire_cst_bip_39_error {
  int32_t tag;
  union Bip39ErrorKind kind;
} wire_cst_bip_39_error;

typedef struct wire_cst_CalculateFeeError_Generic {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CalculateFeeError_Generic;

typedef struct wire_cst_CalculateFeeError_MissingTxOut {
  struct wire_cst_list_out_point *out_points;
} wire_cst_CalculateFeeError_MissingTxOut;

typedef struct wire_cst_CalculateFeeError_NegativeFee {
  struct wire_cst_list_prim_u_8_strict *amount;
} wire_cst_CalculateFeeError_NegativeFee;

typedef union CalculateFeeErrorKind {
  struct wire_cst_CalculateFeeError_Generic Generic;
  struct wire_cst_CalculateFeeError_MissingTxOut MissingTxOut;
  struct wire_cst_CalculateFeeError_NegativeFee NegativeFee;
} CalculateFeeErrorKind;

typedef struct wire_cst_calculate_fee_error {
  int32_t tag;
  union CalculateFeeErrorKind kind;
} wire_cst_calculate_fee_error;

typedef struct wire_cst_CannotConnectError_Include {
  uint32_t height;
} wire_cst_CannotConnectError_Include;

typedef union CannotConnectErrorKind {
  struct wire_cst_CannotConnectError_Include Include;
} CannotConnectErrorKind;

typedef struct wire_cst_cannot_connect_error {
  int32_t tag;
  union CannotConnectErrorKind kind;
} wire_cst_cannot_connect_error;

typedef struct wire_cst_CreateTxError_TransactionNotFound {
  struct wire_cst_list_prim_u_8_strict *txid;
} wire_cst_CreateTxError_TransactionNotFound;

typedef struct wire_cst_CreateTxError_TransactionConfirmed {
  struct wire_cst_list_prim_u_8_strict *txid;
} wire_cst_CreateTxError_TransactionConfirmed;

typedef struct wire_cst_CreateTxError_IrreplaceableTransaction {
  struct wire_cst_list_prim_u_8_strict *txid;
} wire_cst_CreateTxError_IrreplaceableTransaction;

typedef struct wire_cst_CreateTxError_Generic {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateTxError_Generic;

typedef struct wire_cst_CreateTxError_Descriptor {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateTxError_Descriptor;

typedef struct wire_cst_CreateTxError_Policy {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateTxError_Policy;

typedef struct wire_cst_CreateTxError_SpendingPolicyRequired {
  struct wire_cst_list_prim_u_8_strict *kind;
} wire_cst_CreateTxError_SpendingPolicyRequired;

typedef struct wire_cst_CreateTxError_LockTime {
  struct wire_cst_list_prim_u_8_strict *requested_time;
  struct wire_cst_list_prim_u_8_strict *required_time;
} wire_cst_CreateTxError_LockTime;

typedef struct wire_cst_CreateTxError_RbfSequenceCsv {
  struct wire_cst_list_prim_u_8_strict *rbf;
  struct wire_cst_list_prim_u_8_strict *csv;
} wire_cst_CreateTxError_RbfSequenceCsv;

typedef struct wire_cst_CreateTxError_FeeTooLow {
  struct wire_cst_list_prim_u_8_strict *fee_required;
} wire_cst_CreateTxError_FeeTooLow;

typedef struct wire_cst_CreateTxError_FeeRateTooLow {
  struct wire_cst_list_prim_u_8_strict *fee_rate_required;
} wire_cst_CreateTxError_FeeRateTooLow;

typedef struct wire_cst_CreateTxError_OutputBelowDustLimit {
  uint64_t index;
} wire_cst_CreateTxError_OutputBelowDustLimit;

typedef struct wire_cst_CreateTxError_CoinSelection {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateTxError_CoinSelection;

typedef struct wire_cst_CreateTxError_InsufficientFunds {
  uint64_t needed;
  uint64_t available;
} wire_cst_CreateTxError_InsufficientFunds;

typedef struct wire_cst_CreateTxError_Psbt {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateTxError_Psbt;

typedef struct wire_cst_CreateTxError_MissingKeyOrigin {
  struct wire_cst_list_prim_u_8_strict *key;
} wire_cst_CreateTxError_MissingKeyOrigin;

typedef struct wire_cst_CreateTxError_UnknownUtxo {
  struct wire_cst_list_prim_u_8_strict *outpoint;
} wire_cst_CreateTxError_UnknownUtxo;

typedef struct wire_cst_CreateTxError_MissingNonWitnessUtxo {
  struct wire_cst_list_prim_u_8_strict *outpoint;
} wire_cst_CreateTxError_MissingNonWitnessUtxo;

typedef struct wire_cst_CreateTxError_MiniscriptPsbt {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateTxError_MiniscriptPsbt;

typedef union CreateTxErrorKind {
  struct wire_cst_CreateTxError_TransactionNotFound TransactionNotFound;
  struct wire_cst_CreateTxError_TransactionConfirmed TransactionConfirmed;
  struct wire_cst_CreateTxError_IrreplaceableTransaction IrreplaceableTransaction;
  struct wire_cst_CreateTxError_Generic Generic;
  struct wire_cst_CreateTxError_Descriptor Descriptor;
  struct wire_cst_CreateTxError_Policy Policy;
  struct wire_cst_CreateTxError_SpendingPolicyRequired SpendingPolicyRequired;
  struct wire_cst_CreateTxError_LockTime LockTime;
  struct wire_cst_CreateTxError_RbfSequenceCsv RbfSequenceCsv;
  struct wire_cst_CreateTxError_FeeTooLow FeeTooLow;
  struct wire_cst_CreateTxError_FeeRateTooLow FeeRateTooLow;
  struct wire_cst_CreateTxError_OutputBelowDustLimit OutputBelowDustLimit;
  struct wire_cst_CreateTxError_CoinSelection CoinSelection;
  struct wire_cst_CreateTxError_InsufficientFunds InsufficientFunds;
  struct wire_cst_CreateTxError_Psbt Psbt;
  struct wire_cst_CreateTxError_MissingKeyOrigin MissingKeyOrigin;
  struct wire_cst_CreateTxError_UnknownUtxo UnknownUtxo;
  struct wire_cst_CreateTxError_MissingNonWitnessUtxo MissingNonWitnessUtxo;
  struct wire_cst_CreateTxError_MiniscriptPsbt MiniscriptPsbt;
} CreateTxErrorKind;

typedef struct wire_cst_create_tx_error {
  int32_t tag;
  union CreateTxErrorKind kind;
} wire_cst_create_tx_error;

typedef struct wire_cst_CreateWithPersistError_Persist {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateWithPersistError_Persist;

typedef struct wire_cst_CreateWithPersistError_Descriptor {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_CreateWithPersistError_Descriptor;

typedef union CreateWithPersistErrorKind {
  struct wire_cst_CreateWithPersistError_Persist Persist;
  struct wire_cst_CreateWithPersistError_Descriptor Descriptor;
} CreateWithPersistErrorKind;

typedef struct wire_cst_create_with_persist_error {
  int32_t tag;
  union CreateWithPersistErrorKind kind;
} wire_cst_create_with_persist_error;

typedef struct wire_cst_DescriptorError_Key {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Key;

typedef struct wire_cst_DescriptorError_Generic {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Generic;

typedef struct wire_cst_DescriptorError_Policy {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Policy;

typedef struct wire_cst_DescriptorError_InvalidDescriptorCharacter {
  struct wire_cst_list_prim_u_8_strict *charector;
} wire_cst_DescriptorError_InvalidDescriptorCharacter;

typedef struct wire_cst_DescriptorError_Bip32 {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Bip32;

typedef struct wire_cst_DescriptorError_Base58 {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Base58;

typedef struct wire_cst_DescriptorError_Pk {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Pk;

typedef struct wire_cst_DescriptorError_Miniscript {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Miniscript;

typedef struct wire_cst_DescriptorError_Hex {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorError_Hex;

typedef union DescriptorErrorKind {
  struct wire_cst_DescriptorError_Key Key;
  struct wire_cst_DescriptorError_Generic Generic;
  struct wire_cst_DescriptorError_Policy Policy;
  struct wire_cst_DescriptorError_InvalidDescriptorCharacter InvalidDescriptorCharacter;
  struct wire_cst_DescriptorError_Bip32 Bip32;
  struct wire_cst_DescriptorError_Base58 Base58;
  struct wire_cst_DescriptorError_Pk Pk;
  struct wire_cst_DescriptorError_Miniscript Miniscript;
  struct wire_cst_DescriptorError_Hex Hex;
} DescriptorErrorKind;

typedef struct wire_cst_descriptor_error {
  int32_t tag;
  union DescriptorErrorKind kind;
} wire_cst_descriptor_error;

typedef struct wire_cst_DescriptorKeyError_Parse {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorKeyError_Parse;

typedef struct wire_cst_DescriptorKeyError_Bip32 {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_DescriptorKeyError_Bip32;

typedef union DescriptorKeyErrorKind {
  struct wire_cst_DescriptorKeyError_Parse Parse;
  struct wire_cst_DescriptorKeyError_Bip32 Bip32;
} DescriptorKeyErrorKind;

typedef struct wire_cst_descriptor_key_error {
  int32_t tag;
  union DescriptorKeyErrorKind kind;
} wire_cst_descriptor_key_error;

typedef struct wire_cst_ElectrumError_IOError {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_IOError;

typedef struct wire_cst_ElectrumError_Json {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_Json;

typedef struct wire_cst_ElectrumError_Hex {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_Hex;

typedef struct wire_cst_ElectrumError_Protocol {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_Protocol;

typedef struct wire_cst_ElectrumError_Bitcoin {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_Bitcoin;

typedef struct wire_cst_ElectrumError_InvalidResponse {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_InvalidResponse;

typedef struct wire_cst_ElectrumError_Message {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_Message;

typedef struct wire_cst_ElectrumError_InvalidDNSNameError {
  struct wire_cst_list_prim_u_8_strict *domain;
} wire_cst_ElectrumError_InvalidDNSNameError;

typedef struct wire_cst_ElectrumError_SharedIOError {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_SharedIOError;

typedef struct wire_cst_ElectrumError_CouldNotCreateConnection {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_ElectrumError_CouldNotCreateConnection;

typedef union ElectrumErrorKind {
  struct wire_cst_ElectrumError_IOError IOError;
  struct wire_cst_ElectrumError_Json Json;
  struct wire_cst_ElectrumError_Hex Hex;
  struct wire_cst_ElectrumError_Protocol Protocol;
  struct wire_cst_ElectrumError_Bitcoin Bitcoin;
  struct wire_cst_ElectrumError_InvalidResponse InvalidResponse;
  struct wire_cst_ElectrumError_Message Message;
  struct wire_cst_ElectrumError_InvalidDNSNameError InvalidDNSNameError;
  struct wire_cst_ElectrumError_SharedIOError SharedIOError;
  struct wire_cst_ElectrumError_CouldNotCreateConnection CouldNotCreateConnection;
} ElectrumErrorKind;

typedef struct wire_cst_electrum_error {
  int32_t tag;
  union ElectrumErrorKind kind;
} wire_cst_electrum_error;

typedef struct wire_cst_EsploraError_Minreq {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_Minreq;

typedef struct wire_cst_EsploraError_HttpResponse {
  uint16_t status;
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_HttpResponse;

typedef struct wire_cst_EsploraError_Parsing {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_Parsing;

typedef struct wire_cst_EsploraError_StatusCode {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_StatusCode;

typedef struct wire_cst_EsploraError_BitcoinEncoding {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_BitcoinEncoding;

typedef struct wire_cst_EsploraError_HexToArray {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_HexToArray;

typedef struct wire_cst_EsploraError_HexToBytes {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_EsploraError_HexToBytes;

typedef struct wire_cst_EsploraError_HeaderHeightNotFound {
  uint32_t height;
} wire_cst_EsploraError_HeaderHeightNotFound;

typedef struct wire_cst_EsploraError_InvalidHttpHeaderName {
  struct wire_cst_list_prim_u_8_strict *name;
} wire_cst_EsploraError_InvalidHttpHeaderName;

typedef struct wire_cst_EsploraError_InvalidHttpHeaderValue {
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_EsploraError_InvalidHttpHeaderValue;

typedef union EsploraErrorKind {
  struct wire_cst_EsploraError_Minreq Minreq;
  struct wire_cst_EsploraError_HttpResponse HttpResponse;
  struct wire_cst_EsploraError_Parsing Parsing;
  struct wire_cst_EsploraError_StatusCode StatusCode;
  struct wire_cst_EsploraError_BitcoinEncoding BitcoinEncoding;
  struct wire_cst_EsploraError_HexToArray HexToArray;
  struct wire_cst_EsploraError_HexToBytes HexToBytes;
  struct wire_cst_EsploraError_HeaderHeightNotFound HeaderHeightNotFound;
  struct wire_cst_EsploraError_InvalidHttpHeaderName InvalidHttpHeaderName;
  struct wire_cst_EsploraError_InvalidHttpHeaderValue InvalidHttpHeaderValue;
} EsploraErrorKind;

typedef struct wire_cst_esplora_error {
  int32_t tag;
  union EsploraErrorKind kind;
} wire_cst_esplora_error;

typedef struct wire_cst_ExtractTxError_AbsurdFeeRate {
  uint64_t fee_rate;
} wire_cst_ExtractTxError_AbsurdFeeRate;

typedef union ExtractTxErrorKind {
  struct wire_cst_ExtractTxError_AbsurdFeeRate AbsurdFeeRate;
} ExtractTxErrorKind;

typedef struct wire_cst_extract_tx_error {
  int32_t tag;
  union ExtractTxErrorKind kind;
} wire_cst_extract_tx_error;

typedef struct wire_cst_FromScriptError_WitnessProgram {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_FromScriptError_WitnessProgram;

typedef struct wire_cst_FromScriptError_WitnessVersion {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_FromScriptError_WitnessVersion;

typedef union FromScriptErrorKind {
  struct wire_cst_FromScriptError_WitnessProgram WitnessProgram;
  struct wire_cst_FromScriptError_WitnessVersion WitnessVersion;
} FromScriptErrorKind;

typedef struct wire_cst_from_script_error {
  int32_t tag;
  union FromScriptErrorKind kind;
} wire_cst_from_script_error;

typedef struct wire_cst_LoadWithPersistError_Persist {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_LoadWithPersistError_Persist;

typedef struct wire_cst_LoadWithPersistError_InvalidChangeSet {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_LoadWithPersistError_InvalidChangeSet;

typedef union LoadWithPersistErrorKind {
  struct wire_cst_LoadWithPersistError_Persist Persist;
  struct wire_cst_LoadWithPersistError_InvalidChangeSet InvalidChangeSet;
} LoadWithPersistErrorKind;

typedef struct wire_cst_load_with_persist_error {
  int32_t tag;
  union LoadWithPersistErrorKind kind;
} wire_cst_load_with_persist_error;

typedef struct wire_cst_PsbtError_InvalidKey {
  struct wire_cst_list_prim_u_8_strict *key;
} wire_cst_PsbtError_InvalidKey;

typedef struct wire_cst_PsbtError_DuplicateKey {
  struct wire_cst_list_prim_u_8_strict *key;
} wire_cst_PsbtError_DuplicateKey;

typedef struct wire_cst_PsbtError_NonStandardSighashType {
  uint32_t sighash;
} wire_cst_PsbtError_NonStandardSighashType;

typedef struct wire_cst_PsbtError_InvalidHash {
  struct wire_cst_list_prim_u_8_strict *hash;
} wire_cst_PsbtError_InvalidHash;

typedef struct wire_cst_PsbtError_CombineInconsistentKeySources {
  struct wire_cst_list_prim_u_8_strict *xpub;
} wire_cst_PsbtError_CombineInconsistentKeySources;

typedef struct wire_cst_PsbtError_ConsensusEncoding {
  struct wire_cst_list_prim_u_8_strict *encoding_error;
} wire_cst_PsbtError_ConsensusEncoding;

typedef struct wire_cst_PsbtError_InvalidPublicKey {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtError_InvalidPublicKey;

typedef struct wire_cst_PsbtError_InvalidSecp256k1PublicKey {
  struct wire_cst_list_prim_u_8_strict *secp256k1_error;
} wire_cst_PsbtError_InvalidSecp256k1PublicKey;

typedef struct wire_cst_PsbtError_InvalidEcdsaSignature {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtError_InvalidEcdsaSignature;

typedef struct wire_cst_PsbtError_InvalidTaprootSignature {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtError_InvalidTaprootSignature;

typedef struct wire_cst_PsbtError_TapTree {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtError_TapTree;

typedef struct wire_cst_PsbtError_Version {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtError_Version;

typedef struct wire_cst_PsbtError_Io {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtError_Io;

typedef union PsbtErrorKind {
  struct wire_cst_PsbtError_InvalidKey InvalidKey;
  struct wire_cst_PsbtError_DuplicateKey DuplicateKey;
  struct wire_cst_PsbtError_NonStandardSighashType NonStandardSighashType;
  struct wire_cst_PsbtError_InvalidHash InvalidHash;
  struct wire_cst_PsbtError_CombineInconsistentKeySources CombineInconsistentKeySources;
  struct wire_cst_PsbtError_ConsensusEncoding ConsensusEncoding;
  struct wire_cst_PsbtError_InvalidPublicKey InvalidPublicKey;
  struct wire_cst_PsbtError_InvalidSecp256k1PublicKey InvalidSecp256k1PublicKey;
  struct wire_cst_PsbtError_InvalidEcdsaSignature InvalidEcdsaSignature;
  struct wire_cst_PsbtError_InvalidTaprootSignature InvalidTaprootSignature;
  struct wire_cst_PsbtError_TapTree TapTree;
  struct wire_cst_PsbtError_Version Version;
  struct wire_cst_PsbtError_Io Io;
} PsbtErrorKind;

typedef struct wire_cst_psbt_error {
  int32_t tag;
  union PsbtErrorKind kind;
} wire_cst_psbt_error;

typedef struct wire_cst_PsbtParseError_PsbtEncoding {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtParseError_PsbtEncoding;

typedef struct wire_cst_PsbtParseError_Base64Encoding {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_PsbtParseError_Base64Encoding;

typedef union PsbtParseErrorKind {
  struct wire_cst_PsbtParseError_PsbtEncoding PsbtEncoding;
  struct wire_cst_PsbtParseError_Base64Encoding Base64Encoding;
} PsbtParseErrorKind;

typedef struct wire_cst_psbt_parse_error {
  int32_t tag;
  union PsbtParseErrorKind kind;
} wire_cst_psbt_parse_error;

typedef struct wire_cst_SignerError_SighashP2wpkh {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_SignerError_SighashP2wpkh;

typedef struct wire_cst_SignerError_SighashTaproot {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_SignerError_SighashTaproot;

typedef struct wire_cst_SignerError_TxInputsIndexError {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_SignerError_TxInputsIndexError;

typedef struct wire_cst_SignerError_MiniscriptPsbt {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_SignerError_MiniscriptPsbt;

typedef struct wire_cst_SignerError_External {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_SignerError_External;

typedef struct wire_cst_SignerError_Psbt {
  struct wire_cst_list_prim_u_8_strict *error_message;
} wire_cst_SignerError_Psbt;

typedef union SignerErrorKind {
  struct wire_cst_SignerError_SighashP2wpkh SighashP2wpkh;
  struct wire_cst_SignerError_SighashTaproot SighashTaproot;
  struct wire_cst_SignerError_TxInputsIndexError TxInputsIndexError;
  struct wire_cst_SignerError_MiniscriptPsbt MiniscriptPsbt;
  struct wire_cst_SignerError_External External;
  struct wire_cst_SignerError_Psbt Psbt;
} SignerErrorKind;

typedef struct wire_cst_signer_error {
  int32_t tag;
  union SignerErrorKind kind;
} wire_cst_signer_error;

typedef struct wire_cst_SqliteError_Sqlite {
  struct wire_cst_list_prim_u_8_strict *rusqlite_error;
} wire_cst_SqliteError_Sqlite;

typedef union SqliteErrorKind {
  struct wire_cst_SqliteError_Sqlite Sqlite;
} SqliteErrorKind;

typedef struct wire_cst_sqlite_error {
  int32_t tag;
  union SqliteErrorKind kind;
} wire_cst_sqlite_error;

typedef struct wire_cst_sync_progress {
  uint64_t spks_consumed;
  uint64_t spks_remaining;
  uint64_t txids_consumed;
  uint64_t txids_remaining;
  uint64_t outpoints_consumed;
  uint64_t outpoints_remaining;
} wire_cst_sync_progress;

typedef struct wire_cst_TransactionError_InvalidChecksum {
  struct wire_cst_list_prim_u_8_strict *expected;
  struct wire_cst_list_prim_u_8_strict *actual;
} wire_cst_TransactionError_InvalidChecksum;

typedef struct wire_cst_TransactionError_UnsupportedSegwitFlag {
  uint8_t flag;
} wire_cst_TransactionError_UnsupportedSegwitFlag;

typedef union TransactionErrorKind {
  struct wire_cst_TransactionError_InvalidChecksum InvalidChecksum;
  struct wire_cst_TransactionError_UnsupportedSegwitFlag UnsupportedSegwitFlag;
} TransactionErrorKind;

typedef struct wire_cst_transaction_error {
  int32_t tag;
  union TransactionErrorKind kind;
} wire_cst_transaction_error;

typedef struct wire_cst_TxidParseError_InvalidTxid {
  struct wire_cst_list_prim_u_8_strict *txid;
} wire_cst_TxidParseError_InvalidTxid;

typedef union TxidParseErrorKind {
  struct wire_cst_TxidParseError_InvalidTxid InvalidTxid;
} TxidParseErrorKind;

typedef struct wire_cst_txid_parse_error {
  int32_t tag;
  union TxidParseErrorKind kind;
} wire_cst_txid_parse_error;

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_as_string(struct wire_cst_ffi_address *that);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_from_script(int64_t port_,
                                                                           struct wire_cst_ffi_script_buf *script,
                                                                           int32_t network);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_from_string(int64_t port_,
                                                                           struct wire_cst_list_prim_u_8_strict *address,
                                                                           int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_is_valid_for_network(struct wire_cst_ffi_address *that,
                                                                                                    int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_script(struct wire_cst_ffi_address *opaque);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_to_qr_uri(struct wire_cst_ffi_address *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_as_string(struct wire_cst_ffi_psbt *that);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_combine(int64_t port_,
                                                                    struct wire_cst_ffi_psbt *opaque,
                                                                    struct wire_cst_ffi_psbt *other);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_extract_tx(struct wire_cst_ffi_psbt *opaque);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_fee_amount(struct wire_cst_ffi_psbt *that);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_from_str(int64_t port_,
                                                                     struct wire_cst_list_prim_u_8_strict *psbt_base64);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_json_serialize(struct wire_cst_ffi_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_serialize(struct wire_cst_ffi_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_script_buf_as_string(struct wire_cst_ffi_script_buf *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_script_buf_empty(void);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_script_buf_with_capacity(int64_t port_,
                                                                                uintptr_t capacity);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_compute_txid(struct wire_cst_ffi_transaction *that);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_from_bytes(int64_t port_,
                                                                              struct wire_cst_list_prim_u_8_loose *transaction_bytes);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_input(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_is_coinbase(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_is_explicitly_rbf(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_is_lock_time_enabled(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_lock_time(struct wire_cst_ffi_transaction *that);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_new(int64_t port_,
                                                                       int32_t version,
                                                                       struct wire_cst_lock_time *lock_time,
                                                                       struct wire_cst_list_tx_in *input,
                                                                       struct wire_cst_list_tx_out *output);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_output(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_serialize(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_version(struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_vsize(struct wire_cst_ffi_transaction *that);

void frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_weight(int64_t port_,
                                                                          struct wire_cst_ffi_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_as_string(struct wire_cst_ffi_descriptor *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_max_satisfaction_weight(struct wire_cst_ffi_descriptor *that);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new(int64_t port_,
                                                                         struct wire_cst_list_prim_u_8_strict *descriptor,
                                                                         int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip44(int64_t port_,
                                                                               struct wire_cst_ffi_descriptor_secret_key *secret_key,
                                                                               int32_t keychain_kind,
                                                                               int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip44_public(int64_t port_,
                                                                                      struct wire_cst_ffi_descriptor_public_key *public_key,
                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                      int32_t keychain_kind,
                                                                                      int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip49(int64_t port_,
                                                                               struct wire_cst_ffi_descriptor_secret_key *secret_key,
                                                                               int32_t keychain_kind,
                                                                               int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip49_public(int64_t port_,
                                                                                      struct wire_cst_ffi_descriptor_public_key *public_key,
                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                      int32_t keychain_kind,
                                                                                      int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip84(int64_t port_,
                                                                               struct wire_cst_ffi_descriptor_secret_key *secret_key,
                                                                               int32_t keychain_kind,
                                                                               int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip84_public(int64_t port_,
                                                                                      struct wire_cst_ffi_descriptor_public_key *public_key,
                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                      int32_t keychain_kind,
                                                                                      int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip86(int64_t port_,
                                                                               struct wire_cst_ffi_descriptor_secret_key *secret_key,
                                                                               int32_t keychain_kind,
                                                                               int32_t network);

void frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip86_public(int64_t port_,
                                                                                      struct wire_cst_ffi_descriptor_public_key *public_key,
                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                      int32_t keychain_kind,
                                                                                      int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_to_string_with_secret(struct wire_cst_ffi_descriptor *that);

void frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_broadcast(int64_t port_,
                                                                                  struct wire_cst_ffi_electrum_client *opaque,
                                                                                  struct wire_cst_ffi_transaction *transaction);

void frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_full_scan(int64_t port_,
                                                                                  struct wire_cst_ffi_electrum_client *opaque,
                                                                                  struct wire_cst_ffi_full_scan_request *request,
                                                                                  uint64_t stop_gap,
                                                                                  uint64_t batch_size,
                                                                                  bool fetch_prev_txouts);

void frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_new(int64_t port_,
                                                                            struct wire_cst_list_prim_u_8_strict *url);

void frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_sync(int64_t port_,
                                                                             struct wire_cst_ffi_electrum_client *opaque,
                                                                             struct wire_cst_ffi_sync_request *request,
                                                                             uint64_t batch_size,
                                                                             bool fetch_prev_txouts);

void frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_broadcast(int64_t port_,
                                                                                struct wire_cst_ffi_esplora_client *opaque,
                                                                                struct wire_cst_ffi_transaction *transaction);

void frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_full_scan(int64_t port_,
                                                                                struct wire_cst_ffi_esplora_client *opaque,
                                                                                struct wire_cst_ffi_full_scan_request *request,
                                                                                uint64_t stop_gap,
                                                                                uint64_t parallel_requests);

void frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_new(int64_t port_,
                                                                          struct wire_cst_list_prim_u_8_strict *url);

void frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_sync(int64_t port_,
                                                                           struct wire_cst_ffi_esplora_client *opaque,
                                                                           struct wire_cst_ffi_sync_request *request,
                                                                           uint64_t parallel_requests);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__ffi_derivation_path_as_string(struct wire_cst_ffi_derivation_path *that);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_derivation_path_from_string(int64_t port_,
                                                                               struct wire_cst_list_prim_u_8_strict *path);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_as_string(struct wire_cst_ffi_descriptor_public_key *that);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_derive(int64_t port_,
                                                                                struct wire_cst_ffi_descriptor_public_key *opaque,
                                                                                struct wire_cst_ffi_derivation_path *path);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_extend(int64_t port_,
                                                                                struct wire_cst_ffi_descriptor_public_key *opaque,
                                                                                struct wire_cst_ffi_derivation_path *path);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_from_string(int64_t port_,
                                                                                     struct wire_cst_list_prim_u_8_strict *public_key);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_as_public(struct wire_cst_ffi_descriptor_secret_key *opaque);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_as_string(struct wire_cst_ffi_descriptor_secret_key *that);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_create(int64_t port_,
                                                                                int32_t network,
                                                                                struct wire_cst_ffi_mnemonic *mnemonic,
                                                                                struct wire_cst_list_prim_u_8_strict *password);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_derive(int64_t port_,
                                                                                struct wire_cst_ffi_descriptor_secret_key *opaque,
                                                                                struct wire_cst_ffi_derivation_path *path);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_extend(int64_t port_,
                                                                                struct wire_cst_ffi_descriptor_secret_key *opaque,
                                                                                struct wire_cst_ffi_derivation_path *path);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_from_string(int64_t port_,
                                                                                     struct wire_cst_list_prim_u_8_strict *secret_key);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_secret_bytes(struct wire_cst_ffi_descriptor_secret_key *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_as_string(struct wire_cst_ffi_mnemonic *that);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_from_entropy(int64_t port_,
                                                                         struct wire_cst_list_prim_u_8_loose *entropy);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_from_string(int64_t port_,
                                                                        struct wire_cst_list_prim_u_8_strict *mnemonic);

void frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_new(int64_t port_, int32_t word_count);

void frbgen_bdk_flutter_wire__crate__api__store__ffi_connection_new(int64_t port_,
                                                                    struct wire_cst_list_prim_u_8_strict *path);

void frbgen_bdk_flutter_wire__crate__api__store__ffi_connection_new_in_memory(int64_t port_);

void frbgen_bdk_flutter_wire__crate__api__tx_builder__finish_bump_fee_tx_builder(int64_t port_,
                                                                                 struct wire_cst_list_prim_u_8_strict *txid,
                                                                                 struct wire_cst_fee_rate *fee_rate,
                                                                                 struct wire_cst_ffi_wallet *wallet,
                                                                                 bool enable_rbf,
                                                                                 uint32_t *n_sequence);

void frbgen_bdk_flutter_wire__crate__api__tx_builder__tx_builder_finish(int64_t port_,
                                                                        struct wire_cst_ffi_wallet *wallet,
                                                                        struct wire_cst_list_record_ffi_script_buf_u_64 *recipients,
                                                                        struct wire_cst_list_out_point *utxos,
                                                                        struct wire_cst_list_out_point *un_spendable,
                                                                        int32_t change_policy,
                                                                        bool manually_selected_only,
                                                                        struct wire_cst_fee_rate *fee_rate,
                                                                        uint64_t *fee_absolute,
                                                                        bool drain_wallet,
                                                                        struct wire_cst_record_map_string_list_prim_usize_strict_keychain_kind *policy_path,
                                                                        struct wire_cst_ffi_script_buf *drain_to,
                                                                        struct wire_cst_rbf_value *rbf,
                                                                        struct wire_cst_list_prim_u_8_loose *data);

void frbgen_bdk_flutter_wire__crate__api__types__change_spend_policy_default(int64_t port_);

void frbgen_bdk_flutter_wire__crate__api__types__ffi_full_scan_request_builder_build(int64_t port_,
                                                                                     struct wire_cst_ffi_full_scan_request_builder *that);

void frbgen_bdk_flutter_wire__crate__api__types__ffi_full_scan_request_builder_inspect_spks_for_all_keychains(int64_t port_,
                                                                                                              struct wire_cst_ffi_full_scan_request_builder *that,
                                                                                                              const void *inspector);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__ffi_policy_id(struct wire_cst_ffi_policy *that);

void frbgen_bdk_flutter_wire__crate__api__types__ffi_sync_request_builder_build(int64_t port_,
                                                                                struct wire_cst_ffi_sync_request_builder *that);

void frbgen_bdk_flutter_wire__crate__api__types__ffi_sync_request_builder_inspect_spks(int64_t port_,
                                                                                       struct wire_cst_ffi_sync_request_builder *that,
                                                                                       const void *inspector);

void frbgen_bdk_flutter_wire__crate__api__types__network_default(int64_t port_);

void frbgen_bdk_flutter_wire__crate__api__types__sign_options_default(int64_t port_);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_apply_update(int64_t port_,
                                                                          struct wire_cst_ffi_wallet *that,
                                                                          struct wire_cst_ffi_update *update);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_calculate_fee(int64_t port_,
                                                                           struct wire_cst_ffi_wallet *opaque,
                                                                           struct wire_cst_ffi_transaction *tx);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_calculate_fee_rate(int64_t port_,
                                                                                struct wire_cst_ffi_wallet *opaque,
                                                                                struct wire_cst_ffi_transaction *tx);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_get_balance(struct wire_cst_ffi_wallet *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_get_tx(struct wire_cst_ffi_wallet *that,
                                                                                    struct wire_cst_list_prim_u_8_strict *txid);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_is_mine(struct wire_cst_ffi_wallet *that,
                                                                                     struct wire_cst_ffi_script_buf *script);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_list_output(struct wire_cst_ffi_wallet *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_list_unspent(struct wire_cst_ffi_wallet *that);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_load(int64_t port_,
                                                                  struct wire_cst_ffi_descriptor *descriptor,
                                                                  struct wire_cst_ffi_descriptor *change_descriptor,
                                                                  struct wire_cst_ffi_connection *connection);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_network(struct wire_cst_ffi_wallet *that);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_new(int64_t port_,
                                                                 struct wire_cst_ffi_descriptor *descriptor,
                                                                 struct wire_cst_ffi_descriptor *change_descriptor,
                                                                 int32_t network,
                                                                 struct wire_cst_ffi_connection *connection);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_persist(int64_t port_,
                                                                     struct wire_cst_ffi_wallet *opaque,
                                                                     struct wire_cst_ffi_connection *connection);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_policies(struct wire_cst_ffi_wallet *opaque,
                                                                                      int32_t keychain_kind);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_reveal_next_address(struct wire_cst_ffi_wallet *opaque,
                                                                                                 int32_t keychain_kind);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_sign(int64_t port_,
                                                                  struct wire_cst_ffi_wallet *opaque,
                                                                  struct wire_cst_ffi_psbt *psbt,
                                                                  struct wire_cst_sign_options *sign_options);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_start_full_scan(int64_t port_,
                                                                             struct wire_cst_ffi_wallet *that);

void frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_start_sync_with_revealed_spks(int64_t port_,
                                                                                           struct wire_cst_ffi_wallet *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_transactions(struct wire_cst_ffi_wallet *that);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_corebitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_corebitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_corebitcoinTransaction(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_corebitcoinTransaction(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_electrumBdkElectrumClientbdk_electrumelectrum_clientClient(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_electrumBdkElectrumClientbdk_electrumelectrum_clientClient(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_esploraesplora_clientBlockingClient(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_esploraesplora_clientBlockingClient(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletUpdate(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletUpdate(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletbitcoinbip32DerivationPath(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletbitcoinbip32DerivationPath(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletdescriptorExtendedDescriptor(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletdescriptorExtendedDescriptor(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletdescriptorPolicy(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletdescriptorPolicy(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysDescriptorPublicKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysDescriptorPublicKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysDescriptorSecretKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysDescriptorSecretKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysKeyMap(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysKeyMap(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysbip39Mnemonic(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysbip39Mnemonic(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestBuilderbdk_walletKeychainKind(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestBuilderbdk_walletKeychainKind(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestbdk_walletKeychainKind(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestbdk_walletKeychainKind(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestBuilderbdk_walletKeychainKindu32(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestBuilderbdk_walletKeychainKindu32(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestbdk_walletKeychainKindu32(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestbdk_walletKeychainKindu32(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdk_corebitcoinpsbtPsbt(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdk_corebitcoinpsbtPsbt(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdk_walletPersistedWalletbdk_walletrusqliteConnection(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdk_walletPersistedWalletbdk_walletrusqliteConnection(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdk_walletrusqliteConnection(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdk_walletrusqliteConnection(const void *ptr);

struct wire_cst_confirmation_block_time *frbgen_bdk_flutter_cst_new_box_autoadd_confirmation_block_time(void);

struct wire_cst_fee_rate *frbgen_bdk_flutter_cst_new_box_autoadd_fee_rate(void);

struct wire_cst_ffi_address *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_address(void);

struct wire_cst_ffi_canonical_tx *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_canonical_tx(void);

struct wire_cst_ffi_connection *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_connection(void);

struct wire_cst_ffi_derivation_path *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_derivation_path(void);

struct wire_cst_ffi_descriptor *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_descriptor(void);

struct wire_cst_ffi_descriptor_public_key *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_descriptor_public_key(void);

struct wire_cst_ffi_descriptor_secret_key *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_descriptor_secret_key(void);

struct wire_cst_ffi_electrum_client *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_electrum_client(void);

struct wire_cst_ffi_esplora_client *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_esplora_client(void);

struct wire_cst_ffi_full_scan_request *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_full_scan_request(void);

struct wire_cst_ffi_full_scan_request_builder *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_full_scan_request_builder(void);

struct wire_cst_ffi_mnemonic *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_mnemonic(void);

struct wire_cst_ffi_policy *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_policy(void);

struct wire_cst_ffi_psbt *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_psbt(void);

struct wire_cst_ffi_script_buf *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_script_buf(void);

struct wire_cst_ffi_sync_request *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_sync_request(void);

struct wire_cst_ffi_sync_request_builder *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_sync_request_builder(void);

struct wire_cst_ffi_transaction *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_transaction(void);

struct wire_cst_ffi_update *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_update(void);

struct wire_cst_ffi_wallet *frbgen_bdk_flutter_cst_new_box_autoadd_ffi_wallet(void);

struct wire_cst_lock_time *frbgen_bdk_flutter_cst_new_box_autoadd_lock_time(void);

struct wire_cst_rbf_value *frbgen_bdk_flutter_cst_new_box_autoadd_rbf_value(void);

struct wire_cst_record_map_string_list_prim_usize_strict_keychain_kind *frbgen_bdk_flutter_cst_new_box_autoadd_record_map_string_list_prim_usize_strict_keychain_kind(void);

struct wire_cst_sign_options *frbgen_bdk_flutter_cst_new_box_autoadd_sign_options(void);

uint32_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_32(uint32_t value);

uint64_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_64(uint64_t value);

struct wire_cst_list_ffi_canonical_tx *frbgen_bdk_flutter_cst_new_list_ffi_canonical_tx(int32_t len);

struct wire_cst_list_bdk_policy *frbgen_bdk_flutter_cst_new_list_bdk_policy(int32_t len);

struct wire_cst_list_bdk_transaction_details *frbgen_bdk_flutter_cst_new_list_bdk_transaction_details(int32_t len);

struct wire_cst_list_bdk_tx_in *frbgen_bdk_flutter_cst_new_list_bdk_tx_in(int32_t len);

struct wire_cst_list_bdk_tx_out *frbgen_bdk_flutter_cst_new_list_bdk_tx_out(int32_t len);

struct wire_cst_list_condition *frbgen_bdk_flutter_cst_new_list_condition(int32_t len);

struct wire_cst_list_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_local_output *frbgen_bdk_flutter_cst_new_list_local_output(int32_t len);

struct wire_cst_list_out_point *frbgen_bdk_flutter_cst_new_list_out_point(int32_t len);

struct wire_cst_list_pk_or_f *frbgen_bdk_flutter_cst_new_list_pk_or_f(int32_t len);

struct wire_cst_list_prim_u_32_strict *frbgen_bdk_flutter_cst_new_list_prim_u_32_strict(int32_t len);

struct wire_cst_list_prim_u_64_strict *frbgen_bdk_flutter_cst_new_list_prim_u_64_strict(int32_t len);

struct wire_cst_list_prim_u_8_loose *frbgen_bdk_flutter_cst_new_list_prim_u_8_loose(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_prim_usize_strict *frbgen_bdk_flutter_cst_new_list_prim_usize_strict(int32_t len);

struct wire_cst_list_record_ffi_script_buf_u_64 *frbgen_bdk_flutter_cst_new_list_record_ffi_script_buf_u_64(int32_t len);

struct wire_cst_list_record_string_list_prim_usize_strict *frbgen_bdk_flutter_cst_new_list_record_string_list_prim_usize_strict(int32_t len);

struct wire_cst_list_tx_in *frbgen_bdk_flutter_cst_new_list_tx_in(int32_t len);

struct wire_cst_list_tx_out *frbgen_bdk_flutter_cst_new_list_tx_out(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_confirmation_block_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_fee_rate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_canonical_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_connection);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_derivation_path);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_descriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_descriptor_public_key);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_descriptor_secret_key);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_electrum_client);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_esplora_client);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_full_scan_request);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_full_scan_request_builder);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_policy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_psbt);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_script_buf);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_sync_request);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_sync_request_builder);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_transaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_update);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_ffi_wallet);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rbf_value);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_record_map_string_list_prim_usize_strict_keychain_kind);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sign_options);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_64);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_ffi_canonical_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_local_output);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_out_point);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_pk_or_f);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_32_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_64_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_loose);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_usize_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_record_ffi_script_buf_u_64);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_record_string_list_prim_usize_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_tx_in);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_tx_out);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_corebitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_corebitcoinTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_electrumBdkElectrumClientbdk_electrumelectrum_clientClient);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_esploraesplora_clientBlockingClient);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletUpdate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletbitcoinbip32DerivationPath);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletdescriptorExtendedDescriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletdescriptorPolicy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysDescriptorPublicKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysDescriptorSecretKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysKeyMap);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdk_walletkeysbip39Mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestBuilderbdk_walletKeychainKind);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestbdk_walletKeychainKind);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestBuilderbdk_walletKeychainKindu32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestbdk_walletKeychainKindu32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdk_corebitcoinpsbtPsbt);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdk_walletPersistedWalletbdk_walletrusqliteConnection);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdk_walletrusqliteConnection);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_corebitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_corebitcoinTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_electrumBdkElectrumClientbdk_electrumelectrum_clientClient);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_esploraesplora_clientBlockingClient);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletUpdate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletbitcoinbip32DerivationPath);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletdescriptorExtendedDescriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletdescriptorPolicy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysDescriptorPublicKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysDescriptorSecretKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysKeyMap);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdk_walletkeysbip39Mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestBuilderbdk_walletKeychainKind);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientFullScanRequestbdk_walletKeychainKind);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestBuilderbdk_walletKeychainKindu32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexOptionbdk_corespk_clientSyncRequestbdk_walletKeychainKindu32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdk_corebitcoinpsbtPsbt);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdk_walletPersistedWalletbdk_walletrusqliteConnection);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdk_walletrusqliteConnection);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_from_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_is_valid_for_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_address_to_qr_uri);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_combine);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_extract_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_fee_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_from_str);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_json_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_psbt_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_script_buf_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_script_buf_empty);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_script_buf_with_capacity);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_compute_txid);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_from_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_input);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_is_coinbase);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_is_explicitly_rbf);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_is_lock_time_enabled);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_output);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_version);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_vsize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__bitcoin__ffi_transaction_weight);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_max_satisfaction_weight);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip44);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip44_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip49);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip49_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip84);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip84_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip86);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_new_bip86_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__ffi_descriptor_to_string_with_secret);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_broadcast);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_full_scan);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__electrum__ffi_electrum_client_sync);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_broadcast);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_full_scan);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__esplora__ffi_esplora_client_sync);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_derivation_path_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_derivation_path_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_derive);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_extend);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_public_key_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_as_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_derive);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_extend);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_descriptor_secret_key_secret_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_from_entropy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__ffi_mnemonic_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__store__ffi_connection_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__store__ffi_connection_new_in_memory);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__tx_builder__finish_bump_fee_tx_builder);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__tx_builder__tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__change_spend_policy_default);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__ffi_full_scan_request_builder_build);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__ffi_full_scan_request_builder_inspect_spks_for_all_keychains);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__ffi_policy_id);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__ffi_sync_request_builder_build);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__ffi_sync_request_builder_inspect_spks);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__network_default);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__sign_options_default);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_apply_update);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_calculate_fee);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_calculate_fee_rate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_get_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_get_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_is_mine);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_list_output);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_list_unspent);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_load);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_persist);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_policies);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_reveal_next_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_sign);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_start_full_scan);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_start_sync_with_revealed_spks);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__ffi_wallet_transactions);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
