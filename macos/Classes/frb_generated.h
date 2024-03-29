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

typedef struct wire_cst_blockchain_base {
  uintptr_t ptr;
} wire_cst_blockchain_base;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_transaction_base {
  struct wire_cst_list_prim_u_8_strict *inner;
} wire_cst_transaction_base;

typedef struct wire_cst_electrum_config {
  struct wire_cst_list_prim_u_8_strict *url;
  struct wire_cst_list_prim_u_8_strict *socks5;
  uint8_t retry;
  uint8_t *timeout;
  uint64_t stop_gap;
  bool validate_domain;
} wire_cst_electrum_config;

typedef struct wire_cst_BlockchainConfig_Electrum {
  struct wire_cst_electrum_config *config;
} wire_cst_BlockchainConfig_Electrum;

typedef struct wire_cst_esplora_config {
  struct wire_cst_list_prim_u_8_strict *base_url;
  struct wire_cst_list_prim_u_8_strict *proxy;
  uint8_t *concurrency;
  uint64_t stop_gap;
  uint64_t *timeout;
} wire_cst_esplora_config;

typedef struct wire_cst_BlockchainConfig_Esplora {
  struct wire_cst_esplora_config *config;
} wire_cst_BlockchainConfig_Esplora;

typedef struct wire_cst_Auth_UserPass {
  struct wire_cst_list_prim_u_8_strict *username;
  struct wire_cst_list_prim_u_8_strict *password;
} wire_cst_Auth_UserPass;

typedef struct wire_cst_Auth_Cookie {
  struct wire_cst_list_prim_u_8_strict *file;
} wire_cst_Auth_Cookie;

typedef union AuthKind {
  struct wire_cst_Auth_UserPass UserPass;
  struct wire_cst_Auth_Cookie Cookie;
} AuthKind;

typedef struct wire_cst_auth {
  int32_t tag;
  union AuthKind kind;
} wire_cst_auth;

typedef struct wire_cst_rpc_sync_params {
  uint64_t start_script_count;
  uint64_t start_time;
  bool force_start_time;
  uint64_t poll_rate_sec;
} wire_cst_rpc_sync_params;

typedef struct wire_cst_rpc_config {
  struct wire_cst_list_prim_u_8_strict *url;
  struct wire_cst_auth auth;
  int32_t network;
  struct wire_cst_list_prim_u_8_strict *wallet_name;
  struct wire_cst_rpc_sync_params *sync_params;
} wire_cst_rpc_config;

typedef struct wire_cst_BlockchainConfig_Rpc {
  struct wire_cst_rpc_config *config;
} wire_cst_BlockchainConfig_Rpc;

typedef union BlockchainConfigKind {
  struct wire_cst_BlockchainConfig_Electrum Electrum;
  struct wire_cst_BlockchainConfig_Esplora Esplora;
  struct wire_cst_BlockchainConfig_Rpc Rpc;
} BlockchainConfigKind;

typedef struct wire_cst_blockchain_config {
  int32_t tag;
  union BlockchainConfigKind kind;
} wire_cst_blockchain_config;

typedef struct wire_cst_descriptor_base {
  uintptr_t extended_descriptor;
  uintptr_t key_map;
} wire_cst_descriptor_base;

typedef struct wire_cst_descriptor_secret_key_base {
  uintptr_t ptr;
} wire_cst_descriptor_secret_key_base;

typedef struct wire_cst_descriptor_public_key_base {
  uintptr_t ptr;
} wire_cst_descriptor_public_key_base;

typedef struct wire_cst_derivation_path_base {
  uintptr_t ptr;
} wire_cst_derivation_path_base;

typedef struct wire_cst_mnemonic_base {
  uintptr_t ptr;
} wire_cst_mnemonic_base;

typedef struct wire_cst_list_prim_u_8_loose {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_loose;

typedef struct wire_cst_psbt_base {
  uintptr_t ptr;
} wire_cst_psbt_base;

typedef struct wire_cst_address_base {
  uintptr_t ptr;
} wire_cst_address_base;

typedef struct wire_cst_script_buf_base {
  struct wire_cst_list_prim_u_8_strict *bytes;
} wire_cst_script_buf_base;

typedef struct wire_cst_wallet_base {
  uintptr_t ptr;
} wire_cst_wallet_base;

typedef struct wire_cst_AddressIndex_Peek {
  uint32_t index;
} wire_cst_AddressIndex_Peek;

typedef struct wire_cst_AddressIndex_Reset {
  uint32_t index;
} wire_cst_AddressIndex_Reset;

typedef union AddressIndexKind {
  struct wire_cst_AddressIndex_Peek Peek;
  struct wire_cst_AddressIndex_Reset Reset;
} AddressIndexKind;

typedef struct wire_cst_address_index {
  int32_t tag;
  union AddressIndexKind kind;
} wire_cst_address_index;

typedef struct wire_cst_out_point {
  struct wire_cst_list_prim_u_8_strict *txid;
  uint32_t vout;
} wire_cst_out_point;

typedef struct wire_cst_tx_out {
  uint64_t value;
  struct wire_cst_script_buf_base script_pubkey;
} wire_cst_tx_out;

typedef struct wire_cst_local_utxo {
  struct wire_cst_out_point outpoint;
  struct wire_cst_tx_out txout;
  int32_t keychain;
  bool is_spent;
} wire_cst_local_utxo;

typedef struct wire_cst_psbt_sig_hash_type {
  uint32_t inner;
} wire_cst_psbt_sig_hash_type;

typedef struct wire_cst_sqlite_db_configuration {
  struct wire_cst_list_prim_u_8_strict *path;
} wire_cst_sqlite_db_configuration;

typedef struct wire_cst_DatabaseConfig_Sqlite {
  struct wire_cst_sqlite_db_configuration *config;
} wire_cst_DatabaseConfig_Sqlite;

typedef struct wire_cst_sled_db_configuration {
  struct wire_cst_list_prim_u_8_strict *path;
  struct wire_cst_list_prim_u_8_strict *tree_name;
} wire_cst_sled_db_configuration;

typedef struct wire_cst_DatabaseConfig_Sled {
  struct wire_cst_sled_db_configuration *config;
} wire_cst_DatabaseConfig_Sled;

typedef union DatabaseConfigKind {
  struct wire_cst_DatabaseConfig_Sqlite Sqlite;
  struct wire_cst_DatabaseConfig_Sled Sled;
} DatabaseConfigKind;

typedef struct wire_cst_database_config {
  int32_t tag;
  union DatabaseConfigKind kind;
} wire_cst_database_config;

typedef struct wire_cst_sign_options {
  bool multi_sig;
  bool trust_witness_utxo;
  uint32_t *assume_height;
  bool allow_all_sighashes;
  bool remove_partial_sigs;
  bool try_finalize;
  bool sign_with_tap_internal_key;
  bool allow_grinding;
} wire_cst_sign_options;

typedef struct wire_cst_script_amount {
  struct wire_cst_script_buf_base script;
  uint64_t amount;
} wire_cst_script_amount;

typedef struct wire_cst_list_script_amount {
  struct wire_cst_script_amount *ptr;
  int32_t len;
} wire_cst_list_script_amount;

typedef struct wire_cst_list_out_point {
  struct wire_cst_out_point *ptr;
  int32_t len;
} wire_cst_list_out_point;

typedef struct wire_cst_input {
  struct wire_cst_list_prim_u_8_strict *s;
} wire_cst_input;

typedef struct wire_cst_record_out_point_input_usize {
  struct wire_cst_out_point field0;
  struct wire_cst_input field1;
  uintptr_t field2;
} wire_cst_record_out_point_input_usize;

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

typedef struct wire_cst_AddressError_Base58 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_AddressError_Base58;

typedef struct wire_cst_AddressError_Bech32 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_AddressError_Bech32;

typedef struct wire_cst_AddressError_InvalidBech32Variant {
  int32_t expected;
  int32_t found;
} wire_cst_AddressError_InvalidBech32Variant;

typedef struct wire_cst_AddressError_InvalidWitnessVersion {
  uint8_t field0;
} wire_cst_AddressError_InvalidWitnessVersion;

typedef struct wire_cst_AddressError_UnparsableWitnessVersion {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_AddressError_UnparsableWitnessVersion;

typedef struct wire_cst_AddressError_InvalidWitnessProgramLength {
  uintptr_t field0;
} wire_cst_AddressError_InvalidWitnessProgramLength;

typedef struct wire_cst_AddressError_InvalidSegwitV0ProgramLength {
  uintptr_t field0;
} wire_cst_AddressError_InvalidSegwitV0ProgramLength;

typedef struct wire_cst_AddressError_UnknownAddressType {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_AddressError_UnknownAddressType;

typedef struct wire_cst_AddressError_NetworkValidation {
  int32_t network_required;
  int32_t network_found;
  struct wire_cst_list_prim_u_8_strict *address;
} wire_cst_AddressError_NetworkValidation;

typedef union AddressErrorKind {
  struct wire_cst_AddressError_Base58 Base58;
  struct wire_cst_AddressError_Bech32 Bech32;
  struct wire_cst_AddressError_InvalidBech32Variant InvalidBech32Variant;
  struct wire_cst_AddressError_InvalidWitnessVersion InvalidWitnessVersion;
  struct wire_cst_AddressError_UnparsableWitnessVersion UnparsableWitnessVersion;
  struct wire_cst_AddressError_InvalidWitnessProgramLength InvalidWitnessProgramLength;
  struct wire_cst_AddressError_InvalidSegwitV0ProgramLength InvalidSegwitV0ProgramLength;
  struct wire_cst_AddressError_UnknownAddressType UnknownAddressType;
  struct wire_cst_AddressError_NetworkValidation NetworkValidation;
} AddressErrorKind;

typedef struct wire_cst_address_error {
  int32_t tag;
  union AddressErrorKind kind;
} wire_cst_address_error;

typedef struct wire_cst_block_time {
  uint32_t height;
  uint64_t timestamp;
} wire_cst_block_time;

typedef struct wire_cst_ConsensusError_Io {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_ConsensusError_Io;

typedef struct wire_cst_ConsensusError_OversizedVectorAllocation {
  uintptr_t requested;
  uintptr_t max;
} wire_cst_ConsensusError_OversizedVectorAllocation;

typedef struct wire_cst_ConsensusError_InvalidChecksum {
  struct wire_cst_list_prim_u_8_strict *expected;
  struct wire_cst_list_prim_u_8_strict *actual;
} wire_cst_ConsensusError_InvalidChecksum;

typedef struct wire_cst_ConsensusError_ParseFailed {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_ConsensusError_ParseFailed;

typedef struct wire_cst_ConsensusError_UnsupportedSegwitFlag {
  uint8_t field0;
} wire_cst_ConsensusError_UnsupportedSegwitFlag;

typedef union ConsensusErrorKind {
  struct wire_cst_ConsensusError_Io Io;
  struct wire_cst_ConsensusError_OversizedVectorAllocation OversizedVectorAllocation;
  struct wire_cst_ConsensusError_InvalidChecksum InvalidChecksum;
  struct wire_cst_ConsensusError_ParseFailed ParseFailed;
  struct wire_cst_ConsensusError_UnsupportedSegwitFlag UnsupportedSegwitFlag;
} ConsensusErrorKind;

typedef struct wire_cst_consensus_error {
  int32_t tag;
  union ConsensusErrorKind kind;
} wire_cst_consensus_error;

typedef struct wire_cst_DescriptorError_Key {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Key;

typedef struct wire_cst_DescriptorError_Policy {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Policy;

typedef struct wire_cst_DescriptorError_InvalidDescriptorCharacter {
  uint8_t field0;
} wire_cst_DescriptorError_InvalidDescriptorCharacter;

typedef struct wire_cst_DescriptorError_Bip32 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Bip32;

typedef struct wire_cst_DescriptorError_Base58 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Base58;

typedef struct wire_cst_DescriptorError_Pk {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Pk;

typedef struct wire_cst_DescriptorError_Miniscript {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Miniscript;

typedef struct wire_cst_DescriptorError_Hex {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_DescriptorError_Hex;

typedef union DescriptorErrorKind {
  struct wire_cst_DescriptorError_Key Key;
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

typedef struct wire_cst_fee_rate {
  float sat_per_vb;
} wire_cst_fee_rate;

typedef struct wire_cst_HexError_InvalidChar {
  uint8_t field0;
} wire_cst_HexError_InvalidChar;

typedef struct wire_cst_HexError_OddLengthString {
  uintptr_t field0;
} wire_cst_HexError_OddLengthString;

typedef struct wire_cst_HexError_InvalidLength {
  uintptr_t field0;
  uintptr_t field1;
} wire_cst_HexError_InvalidLength;

typedef union HexErrorKind {
  struct wire_cst_HexError_InvalidChar InvalidChar;
  struct wire_cst_HexError_OddLengthString OddLengthString;
  struct wire_cst_HexError_InvalidLength InvalidLength;
} HexErrorKind;

typedef struct wire_cst_hex_error {
  int32_t tag;
  union HexErrorKind kind;
} wire_cst_hex_error;

typedef struct wire_cst_list_list_prim_u_8_strict {
  struct wire_cst_list_prim_u_8_strict **ptr;
  int32_t len;
} wire_cst_list_list_prim_u_8_strict;

typedef struct wire_cst_list_local_utxo {
  struct wire_cst_local_utxo *ptr;
  int32_t len;
} wire_cst_list_local_utxo;

typedef struct wire_cst_transaction_details {
  struct wire_cst_transaction_base *transaction;
  struct wire_cst_list_prim_u_8_strict *txid;
  uint64_t received;
  uint64_t sent;
  uint64_t *fee;
  struct wire_cst_block_time *confirmation_time;
} wire_cst_transaction_details;

typedef struct wire_cst_list_transaction_details {
  struct wire_cst_transaction_details *ptr;
  int32_t len;
} wire_cst_list_transaction_details;

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

typedef struct wire_cst_list_tx_out {
  struct wire_cst_tx_out *ptr;
  int32_t len;
} wire_cst_list_tx_out;

typedef struct wire_cst_address_info {
  uint32_t index;
  struct wire_cst_list_prim_u_8_strict *address;
} wire_cst_address_info;

typedef struct wire_cst_balance {
  uint64_t immature;
  uint64_t trusted_pending;
  uint64_t untrusted_pending;
  uint64_t confirmed;
  uint64_t spendable;
  uint64_t total;
} wire_cst_balance;

typedef struct wire_cst_BdkError_Hex {
  struct wire_cst_hex_error *field0;
} wire_cst_BdkError_Hex;

typedef struct wire_cst_BdkError_Consensus {
  struct wire_cst_consensus_error *field0;
} wire_cst_BdkError_Consensus;

typedef struct wire_cst_BdkError_Address {
  struct wire_cst_address_error *field0;
} wire_cst_BdkError_Address;

typedef struct wire_cst_BdkError_Descriptor {
  struct wire_cst_descriptor_error *field0;
} wire_cst_BdkError_Descriptor;

typedef struct wire_cst_BdkError_InvalidU32Bytes {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_InvalidU32Bytes;

typedef struct wire_cst_BdkError_Generic {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Generic;

typedef struct wire_cst_BdkError_OutputBelowDustLimit {
  uintptr_t field0;
} wire_cst_BdkError_OutputBelowDustLimit;

typedef struct wire_cst_BdkError_InsufficientFunds {
  uint64_t needed;
  uint64_t available;
} wire_cst_BdkError_InsufficientFunds;

typedef struct wire_cst_BdkError_FeeRateTooLow {
  float needed;
} wire_cst_BdkError_FeeRateTooLow;

typedef struct wire_cst_BdkError_FeeTooLow {
  uint64_t needed;
} wire_cst_BdkError_FeeTooLow;

typedef struct wire_cst_BdkError_MissingKeyOrigin {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_MissingKeyOrigin;

typedef struct wire_cst_BdkError_Key {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Key;

typedef struct wire_cst_BdkError_SpendingPolicyRequired {
  int32_t field0;
} wire_cst_BdkError_SpendingPolicyRequired;

typedef struct wire_cst_BdkError_InvalidPolicyPathError {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_InvalidPolicyPathError;

typedef struct wire_cst_BdkError_Signer {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Signer;

typedef struct wire_cst_BdkError_InvalidNetwork {
  int32_t requested;
  int32_t found;
} wire_cst_BdkError_InvalidNetwork;

typedef struct wire_cst_BdkError_InvalidOutpoint {
  struct wire_cst_out_point *field0;
} wire_cst_BdkError_InvalidOutpoint;

typedef struct wire_cst_BdkError_Encode {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Encode;

typedef struct wire_cst_BdkError_Miniscript {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Miniscript;

typedef struct wire_cst_BdkError_MiniscriptPsbt {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_MiniscriptPsbt;

typedef struct wire_cst_BdkError_Bip32 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Bip32;

typedef struct wire_cst_BdkError_Bip39 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Bip39;

typedef struct wire_cst_BdkError_Secp256k1 {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Secp256k1;

typedef struct wire_cst_BdkError_Json {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Json;

typedef struct wire_cst_BdkError_Psbt {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Psbt;

typedef struct wire_cst_BdkError_PsbtParse {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_PsbtParse;

typedef struct wire_cst_BdkError_MissingCachedScripts {
  uintptr_t field0;
  uintptr_t field1;
} wire_cst_BdkError_MissingCachedScripts;

typedef struct wire_cst_BdkError_Electrum {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Electrum;

typedef struct wire_cst_BdkError_Esplora {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Esplora;

typedef struct wire_cst_BdkError_Sled {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Sled;

typedef struct wire_cst_BdkError_Rpc {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Rpc;

typedef struct wire_cst_BdkError_Rusqlite {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_Rusqlite;

typedef union BdkErrorKind {
  struct wire_cst_BdkError_Hex Hex;
  struct wire_cst_BdkError_Consensus Consensus;
  struct wire_cst_BdkError_Address Address;
  struct wire_cst_BdkError_Descriptor Descriptor;
  struct wire_cst_BdkError_InvalidU32Bytes InvalidU32Bytes;
  struct wire_cst_BdkError_Generic Generic;
  struct wire_cst_BdkError_OutputBelowDustLimit OutputBelowDustLimit;
  struct wire_cst_BdkError_InsufficientFunds InsufficientFunds;
  struct wire_cst_BdkError_FeeRateTooLow FeeRateTooLow;
  struct wire_cst_BdkError_FeeTooLow FeeTooLow;
  struct wire_cst_BdkError_MissingKeyOrigin MissingKeyOrigin;
  struct wire_cst_BdkError_Key Key;
  struct wire_cst_BdkError_SpendingPolicyRequired SpendingPolicyRequired;
  struct wire_cst_BdkError_InvalidPolicyPathError InvalidPolicyPathError;
  struct wire_cst_BdkError_Signer Signer;
  struct wire_cst_BdkError_InvalidNetwork InvalidNetwork;
  struct wire_cst_BdkError_InvalidOutpoint InvalidOutpoint;
  struct wire_cst_BdkError_Encode Encode;
  struct wire_cst_BdkError_Miniscript Miniscript;
  struct wire_cst_BdkError_MiniscriptPsbt MiniscriptPsbt;
  struct wire_cst_BdkError_Bip32 Bip32;
  struct wire_cst_BdkError_Bip39 Bip39;
  struct wire_cst_BdkError_Secp256k1 Secp256k1;
  struct wire_cst_BdkError_Json Json;
  struct wire_cst_BdkError_Psbt Psbt;
  struct wire_cst_BdkError_PsbtParse PsbtParse;
  struct wire_cst_BdkError_MissingCachedScripts MissingCachedScripts;
  struct wire_cst_BdkError_Electrum Electrum;
  struct wire_cst_BdkError_Esplora Esplora;
  struct wire_cst_BdkError_Sled Sled;
  struct wire_cst_BdkError_Rpc Rpc;
  struct wire_cst_BdkError_Rusqlite Rusqlite;
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

typedef struct wire_cst_record_psbt_base_transaction_details {
  struct wire_cst_psbt_base field0;
  struct wire_cst_transaction_details field1;
} wire_cst_record_psbt_base_transaction_details;

void frbgen_bdk_flutter_wire_BlockchainBase_broadcast(int64_t port_,
                                                      struct wire_cst_blockchain_base *that,
                                                      struct wire_cst_transaction_base *transaction);

void frbgen_bdk_flutter_wire_BlockchainBase_estimate_fee(int64_t port_,
                                                         struct wire_cst_blockchain_base *that,
                                                         uint64_t target);

void frbgen_bdk_flutter_wire_BlockchainBase_get_block_hash(int64_t port_,
                                                           struct wire_cst_blockchain_base *that,
                                                           uint32_t height);

void frbgen_bdk_flutter_wire_BlockchainBase_get_height(int64_t port_,
                                                       struct wire_cst_blockchain_base *that);

void frbgen_bdk_flutter_wire_BlockchainBase_new(int64_t port_,
                                                struct wire_cst_blockchain_config *blockchain_config);

void frbgen_bdk_flutter_wire_DescriptorBase_as_string(int64_t port_,
                                                      struct wire_cst_descriptor_base *that);

void frbgen_bdk_flutter_wire_DescriptorBase_as_string_private(int64_t port_,
                                                              struct wire_cst_descriptor_base *that);

void frbgen_bdk_flutter_wire_DescriptorBase_max_satisfaction_weight(int64_t port_,
                                                                    struct wire_cst_descriptor_base *that);

void frbgen_bdk_flutter_wire_DescriptorBase_new(int64_t port_,
                                                struct wire_cst_list_prim_u_8_strict *descriptor,
                                                int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip44(int64_t port_,
                                                      struct wire_cst_descriptor_secret_key_base *secret_key,
                                                      int32_t keychain_kind,
                                                      int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip44_public(int64_t port_,
                                                             struct wire_cst_descriptor_public_key_base *public_key,
                                                             struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                             int32_t keychain_kind,
                                                             int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip49(int64_t port_,
                                                      struct wire_cst_descriptor_secret_key_base *secret_key,
                                                      int32_t keychain_kind,
                                                      int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip49_public(int64_t port_,
                                                             struct wire_cst_descriptor_public_key_base *public_key,
                                                             struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                             int32_t keychain_kind,
                                                             int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip84(int64_t port_,
                                                      struct wire_cst_descriptor_secret_key_base *secret_key,
                                                      int32_t keychain_kind,
                                                      int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip84_public(int64_t port_,
                                                             struct wire_cst_descriptor_public_key_base *public_key,
                                                             struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                             int32_t keychain_kind,
                                                             int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip86(int64_t port_,
                                                      struct wire_cst_descriptor_secret_key_base *secret_key,
                                                      int32_t keychain_kind,
                                                      int32_t network);

void frbgen_bdk_flutter_wire_DescriptorBase_new_bip86_public(int64_t port_,
                                                             struct wire_cst_descriptor_public_key_base *public_key,
                                                             struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                             int32_t keychain_kind,
                                                             int32_t network);

void frbgen_bdk_flutter_wire_DerivationPathBase_from_string(int64_t port_,
                                                            struct wire_cst_list_prim_u_8_strict *path);

void frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_as_string(int64_t port_,
                                                               struct wire_cst_descriptor_public_key_base *that);

void frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_derive(int64_t port_,
                                                            struct wire_cst_descriptor_public_key_base *ptr,
                                                            struct wire_cst_derivation_path_base *path);

void frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_extend(int64_t port_,
                                                            struct wire_cst_descriptor_public_key_base *ptr,
                                                            struct wire_cst_derivation_path_base *path);

void frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_from_string(int64_t port_,
                                                                 struct wire_cst_list_prim_u_8_strict *public_key);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_as_public(int64_t port_,
                                                               struct wire_cst_descriptor_secret_key_base *ptr);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_as_string(int64_t port_,
                                                               struct wire_cst_descriptor_secret_key_base *that);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_create(int64_t port_,
                                                            int32_t network,
                                                            struct wire_cst_mnemonic_base *mnemonic,
                                                            struct wire_cst_list_prim_u_8_strict *password);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_derive(int64_t port_,
                                                            struct wire_cst_descriptor_secret_key_base *ptr,
                                                            struct wire_cst_derivation_path_base *path);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_extend(int64_t port_,
                                                            struct wire_cst_descriptor_secret_key_base *ptr,
                                                            struct wire_cst_derivation_path_base *path);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_from_string(int64_t port_,
                                                                 struct wire_cst_list_prim_u_8_strict *secret_key);

void frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_secret_bytes(int64_t port_,
                                                                  struct wire_cst_descriptor_secret_key_base *that);

void frbgen_bdk_flutter_wire_MnemonicBase_as_string(int64_t port_,
                                                    struct wire_cst_mnemonic_base *that);

void frbgen_bdk_flutter_wire_MnemonicBase_from_entropy(int64_t port_,
                                                       struct wire_cst_list_prim_u_8_loose *entropy);

void frbgen_bdk_flutter_wire_MnemonicBase_from_string(int64_t port_,
                                                      struct wire_cst_list_prim_u_8_strict *mnemonic);

void frbgen_bdk_flutter_wire_MnemonicBase_new(int64_t port_, int32_t word_count);

void frbgen_bdk_flutter_wire_PsbtBase_combine(int64_t port_,
                                              struct wire_cst_psbt_base *ptr,
                                              struct wire_cst_psbt_base *other);

void frbgen_bdk_flutter_wire_PsbtBase_extract_tx(int64_t port_, struct wire_cst_psbt_base *ptr);

void frbgen_bdk_flutter_wire_PsbtBase_fee_amount(int64_t port_, struct wire_cst_psbt_base *that);

void frbgen_bdk_flutter_wire_PsbtBase_fee_rate(int64_t port_, struct wire_cst_psbt_base *that);

void frbgen_bdk_flutter_wire_PsbtBase_from_str(int64_t port_,
                                               struct wire_cst_list_prim_u_8_strict *psbt_base64);

void frbgen_bdk_flutter_wire_PsbtBase_json_serialize(int64_t port_,
                                                     struct wire_cst_psbt_base *that);

void frbgen_bdk_flutter_wire_PsbtBase_serialize(int64_t port_, struct wire_cst_psbt_base *that);

void frbgen_bdk_flutter_wire_PsbtBase_txid(int64_t port_, struct wire_cst_psbt_base *that);

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

void frbgen_bdk_flutter_wire_AddressBase_script(int64_t port_, struct wire_cst_address_base *ptr);

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

void frbgen_bdk_flutter_wire_WalletBase_get_address(int64_t port_,
                                                    struct wire_cst_wallet_base *that,
                                                    struct wire_cst_address_index *address_index);

void frbgen_bdk_flutter_wire_WalletBase_get_balance(int64_t port_,
                                                    struct wire_cst_wallet_base *that);

void frbgen_bdk_flutter_wire_WalletBase_get_descriptor_for_keychain(int64_t port_,
                                                                    struct wire_cst_wallet_base *ptr,
                                                                    int32_t keychain);

void frbgen_bdk_flutter_wire_WalletBase_get_internal_address(int64_t port_,
                                                             struct wire_cst_wallet_base *that,
                                                             struct wire_cst_address_index *address_index);

void frbgen_bdk_flutter_wire_WalletBase_get_psbt_input(int64_t port_,
                                                       struct wire_cst_wallet_base *that,
                                                       struct wire_cst_local_utxo *utxo,
                                                       bool only_witness_utxo,
                                                       struct wire_cst_psbt_sig_hash_type *sighash_type);

void frbgen_bdk_flutter_wire_WalletBase_is_mine(int64_t port_,
                                                struct wire_cst_wallet_base *that,
                                                struct wire_cst_script_buf_base *script);

void frbgen_bdk_flutter_wire_WalletBase_list_transactions(int64_t port_,
                                                          struct wire_cst_wallet_base *that,
                                                          bool include_raw);

void frbgen_bdk_flutter_wire_WalletBase_list_unspent(int64_t port_,
                                                     struct wire_cst_wallet_base *that);

void frbgen_bdk_flutter_wire_WalletBase_network(int64_t port_, struct wire_cst_wallet_base *that);

void frbgen_bdk_flutter_wire_WalletBase_new(int64_t port_,
                                            struct wire_cst_descriptor_base *descriptor,
                                            struct wire_cst_descriptor_base *change_descriptor,
                                            int32_t network,
                                            struct wire_cst_database_config *database_config);

void frbgen_bdk_flutter_wire_WalletBase_sign(int64_t port_,
                                             struct wire_cst_wallet_base *ptr,
                                             struct wire_cst_psbt_base *psbt,
                                             struct wire_cst_sign_options *sign_options);

void frbgen_bdk_flutter_wire_WalletBase_sync(int64_t port_,
                                             struct wire_cst_wallet_base *ptr,
                                             struct wire_cst_blockchain_base *blockchain);

void frbgen_bdk_flutter_wire_finish_bump_fee_tx_builder(int64_t port_,
                                                        struct wire_cst_list_prim_u_8_strict *txid,
                                                        float fee_rate,
                                                        struct wire_cst_address_base *allow_shrinking,
                                                        struct wire_cst_wallet_base *wallet,
                                                        bool enable_rbf,
                                                        uint32_t *n_sequence);

void frbgen_bdk_flutter_wire_tx_builder_finish(int64_t port_,
                                               struct wire_cst_wallet_base *wallet,
                                               struct wire_cst_list_script_amount *recipients,
                                               struct wire_cst_list_out_point *utxos,
                                               struct wire_cst_record_out_point_input_usize *foreign_utxo,
                                               struct wire_cst_list_out_point *un_spendable,
                                               int32_t change_policy,
                                               bool manually_selected_only,
                                               float *fee_rate,
                                               uint64_t *fee_absolute,
                                               bool drain_wallet,
                                               struct wire_cst_script_buf_base *drain_to,
                                               struct wire_cst_rbf_value *rbf,
                                               struct wire_cst_list_prim_u_8_loose *data);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_AnyBlockchain(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_AnyBlockchain(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_ExtendedDescriptor(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_ExtendedDescriptor(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_MutexPartiallySignedTransaction(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_MutexPartiallySignedTransaction(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_MutexbdkWalletAnyDatabase(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_MutexbdkWalletAnyDatabase(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkbitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkbitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bitcoinbip32DerivationPath(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bitcoinbip32DerivationPath(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysDescriptorPublicKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysDescriptorPublicKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysDescriptorSecretKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysDescriptorSecretKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysKeyMap(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysKeyMap(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysbip39Mnemonic(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysbip39Mnemonic(const void *ptr);

struct wire_cst_address_base *frbgen_bdk_flutter_cst_new_box_autoadd_address_base(void);

struct wire_cst_address_error *frbgen_bdk_flutter_cst_new_box_autoadd_address_error(void);

struct wire_cst_address_index *frbgen_bdk_flutter_cst_new_box_autoadd_address_index(void);

struct wire_cst_block_time *frbgen_bdk_flutter_cst_new_box_autoadd_block_time(void);

struct wire_cst_blockchain_base *frbgen_bdk_flutter_cst_new_box_autoadd_blockchain_base(void);

struct wire_cst_blockchain_config *frbgen_bdk_flutter_cst_new_box_autoadd_blockchain_config(void);

struct wire_cst_consensus_error *frbgen_bdk_flutter_cst_new_box_autoadd_consensus_error(void);

struct wire_cst_database_config *frbgen_bdk_flutter_cst_new_box_autoadd_database_config(void);

struct wire_cst_derivation_path_base *frbgen_bdk_flutter_cst_new_box_autoadd_derivation_path_base(void);

struct wire_cst_descriptor_base *frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_base(void);

struct wire_cst_descriptor_error *frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_error(void);

struct wire_cst_descriptor_public_key_base *frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_public_key_base(void);

struct wire_cst_descriptor_secret_key_base *frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_secret_key_base(void);

struct wire_cst_electrum_config *frbgen_bdk_flutter_cst_new_box_autoadd_electrum_config(void);

struct wire_cst_esplora_config *frbgen_bdk_flutter_cst_new_box_autoadd_esplora_config(void);

float *frbgen_bdk_flutter_cst_new_box_autoadd_f_32(float value);

struct wire_cst_fee_rate *frbgen_bdk_flutter_cst_new_box_autoadd_fee_rate(void);

struct wire_cst_hex_error *frbgen_bdk_flutter_cst_new_box_autoadd_hex_error(void);

struct wire_cst_local_utxo *frbgen_bdk_flutter_cst_new_box_autoadd_local_utxo(void);

struct wire_cst_mnemonic_base *frbgen_bdk_flutter_cst_new_box_autoadd_mnemonic_base(void);

struct wire_cst_out_point *frbgen_bdk_flutter_cst_new_box_autoadd_out_point(void);

struct wire_cst_psbt_base *frbgen_bdk_flutter_cst_new_box_autoadd_psbt_base(void);

struct wire_cst_psbt_sig_hash_type *frbgen_bdk_flutter_cst_new_box_autoadd_psbt_sig_hash_type(void);

struct wire_cst_rbf_value *frbgen_bdk_flutter_cst_new_box_autoadd_rbf_value(void);

struct wire_cst_record_out_point_input_usize *frbgen_bdk_flutter_cst_new_box_autoadd_record_out_point_input_usize(void);

struct wire_cst_rpc_config *frbgen_bdk_flutter_cst_new_box_autoadd_rpc_config(void);

struct wire_cst_rpc_sync_params *frbgen_bdk_flutter_cst_new_box_autoadd_rpc_sync_params(void);

struct wire_cst_script_buf_base *frbgen_bdk_flutter_cst_new_box_autoadd_script_buf_base(void);

struct wire_cst_sign_options *frbgen_bdk_flutter_cst_new_box_autoadd_sign_options(void);

struct wire_cst_sled_db_configuration *frbgen_bdk_flutter_cst_new_box_autoadd_sled_db_configuration(void);

struct wire_cst_sqlite_db_configuration *frbgen_bdk_flutter_cst_new_box_autoadd_sqlite_db_configuration(void);

struct wire_cst_transaction_base *frbgen_bdk_flutter_cst_new_box_autoadd_transaction_base(void);

uint32_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_32(uint32_t value);

uint64_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_64(uint64_t value);

uint8_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_8(uint8_t value);

struct wire_cst_wallet_base *frbgen_bdk_flutter_cst_new_box_autoadd_wallet_base(void);

struct wire_cst_list_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_local_utxo *frbgen_bdk_flutter_cst_new_list_local_utxo(int32_t len);

struct wire_cst_list_out_point *frbgen_bdk_flutter_cst_new_list_out_point(int32_t len);

struct wire_cst_list_prim_u_8_loose *frbgen_bdk_flutter_cst_new_list_prim_u_8_loose(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_script_amount *frbgen_bdk_flutter_cst_new_list_script_amount(int32_t len);

struct wire_cst_list_transaction_details *frbgen_bdk_flutter_cst_new_list_transaction_details(int32_t len);

struct wire_cst_list_tx_in *frbgen_bdk_flutter_cst_new_list_tx_in(int32_t len);

struct wire_cst_list_tx_out *frbgen_bdk_flutter_cst_new_list_tx_out(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_address_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_address_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_address_index);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_block_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_blockchain_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_blockchain_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_consensus_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_database_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_derivation_path_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_public_key_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_secret_key_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_electrum_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_esplora_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_f_32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_fee_rate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_hex_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_local_utxo);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_mnemonic_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_out_point);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_psbt_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_psbt_sig_hash_type);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rbf_value);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_record_out_point_input_usize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rpc_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rpc_sync_params);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_script_buf_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sign_options);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sled_db_configuration);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sqlite_db_configuration);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_transaction_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_64);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_8);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_wallet_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_local_utxo);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_out_point);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_loose);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_script_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_transaction_details);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_tx_in);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_tx_out);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_AnyBlockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_ExtendedDescriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_MutexPartiallySignedTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_MutexbdkWalletAnyDatabase);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkbitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bitcoinbip32DerivationPath);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysDescriptorPublicKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysDescriptorSecretKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysKeyMap);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_keysbip39Mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_AnyBlockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_ExtendedDescriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_MutexPartiallySignedTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_MutexbdkWalletAnyDatabase);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkbitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bitcoinbip32DerivationPath);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysDescriptorPublicKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysDescriptorSecretKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysKeyMap);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_keysbip39Mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_from_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_is_valid_for_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_payload);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_AddressBase_to_qr_uri);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_BlockchainBase_broadcast);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_BlockchainBase_estimate_fee);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_BlockchainBase_get_block_hash);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_BlockchainBase_get_height);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_BlockchainBase_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DerivationPathBase_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_as_string_private);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_max_satisfaction_weight);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip44);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip44_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip49);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip49_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip84);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip84_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip86);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorBase_new_bip86_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_derive);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_extend);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorPublicKeyBase_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_as_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_derive);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_extend);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_DescriptorSecretKeyBase_secret_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_MnemonicBase_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_MnemonicBase_from_entropy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_MnemonicBase_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_MnemonicBase_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_combine);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_extract_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_fee_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_fee_rate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_from_str);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_json_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_PsbtBase_txid);
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
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_get_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_get_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_get_descriptor_for_keychain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_get_internal_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_get_psbt_input);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_is_mine);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_list_transactions);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_list_unspent);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_new);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_sign);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_WalletBase_sync);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_finish_bump_fee_tx_builder);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire_tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
