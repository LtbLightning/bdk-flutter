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

typedef struct wire_cst_bdk_address {
  uintptr_t ptr;
} wire_cst_bdk_address;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_bdk_script_buf {
  struct wire_cst_list_prim_u_8_strict *bytes;
} wire_cst_bdk_script_buf;

typedef struct wire_cst_bdk_blockchain {
  uintptr_t ptr;
} wire_cst_bdk_blockchain;

typedef struct wire_cst_bdk_transaction {
  struct wire_cst_list_prim_u_8_strict *s;
} wire_cst_bdk_transaction;

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

typedef struct wire_cst_bdk_derivation_path {
  uintptr_t ptr;
} wire_cst_bdk_derivation_path;

typedef struct wire_cst_bdk_descriptor {
  uintptr_t extended_descriptor;
  uintptr_t key_map;
} wire_cst_bdk_descriptor;

typedef struct wire_cst_bdk_descriptor_secret_key {
  uintptr_t ptr;
} wire_cst_bdk_descriptor_secret_key;

typedef struct wire_cst_bdk_descriptor_public_key {
  uintptr_t ptr;
} wire_cst_bdk_descriptor_public_key;

typedef struct wire_cst_bdk_mnemonic {
  uintptr_t ptr;
} wire_cst_bdk_mnemonic;

typedef struct wire_cst_list_prim_u_8_loose {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_loose;

typedef struct wire_cst_bdk_policy {
  uintptr_t ptr;
} wire_cst_bdk_policy;

typedef struct wire_cst_bdk_psbt {
  uintptr_t ptr;
} wire_cst_bdk_psbt;

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
  struct wire_cst_bdk_script_buf *script_sig;
  uint32_t sequence;
  struct wire_cst_list_list_prim_u_8_strict *witness;
} wire_cst_bdk_tx_in;

typedef struct wire_cst_list_bdk_tx_in {
  struct wire_cst_bdk_tx_in *ptr;
  int32_t len;
} wire_cst_list_bdk_tx_in;

typedef struct wire_cst_bdk_tx_out {
  uint64_t value;
  struct wire_cst_bdk_script_buf script_pubkey;
} wire_cst_bdk_tx_out;

typedef struct wire_cst_list_bdk_tx_out {
  struct wire_cst_bdk_tx_out *ptr;
  int32_t len;
} wire_cst_list_bdk_tx_out;

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

typedef struct wire_cst_bdk_wallet {
  uintptr_t ptr;
} wire_cst_bdk_wallet;

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

typedef struct wire_cst_local_utxo {
  struct wire_cst_out_point outpoint;
  struct wire_cst_bdk_tx_out txout;
  int32_t keychain;
  bool is_spent;
} wire_cst_local_utxo;

typedef struct wire_cst_psbt_sig_hash_type {
  uint32_t inner;
} wire_cst_psbt_sig_hash_type;

typedef struct wire_cst_sign_options {
  bool trust_witness_utxo;
  uint32_t *assume_height;
  bool allow_all_sighashes;
  bool remove_partial_sigs;
  bool try_finalize;
  bool sign_with_tap_internal_key;
  bool allow_grinding;
} wire_cst_sign_options;

typedef struct wire_cst_script_amount {
  struct wire_cst_bdk_script_buf script;
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

typedef struct wire_cst_list_prim_u_32_strict {
  uint32_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_32_strict;

typedef struct wire_cst_record_string_list_prim_u_32_strict {
  struct wire_cst_list_prim_u_8_strict *field0;
  struct wire_cst_list_prim_u_32_strict *field1;
} wire_cst_record_string_list_prim_u_32_strict;

typedef struct wire_cst_list_record_string_list_prim_u_32_strict {
  struct wire_cst_record_string_list_prim_u_32_strict *ptr;
  int32_t len;
} wire_cst_list_record_string_list_prim_u_32_strict;

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

typedef struct wire_cst_condition {
  uint32_t *csv;
  struct wire_cst_lock_time *timelock;
} wire_cst_condition;

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

typedef struct wire_cst_PkOrF_Pubkey {
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_PkOrF_Pubkey;

typedef struct wire_cst_PkOrF_XOnlyPubkey {
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_PkOrF_XOnlyPubkey;

typedef struct wire_cst_PkOrF_Fingerprint {
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_PkOrF_Fingerprint;

typedef union PkOrFKind {
  struct wire_cst_PkOrF_Pubkey Pubkey;
  struct wire_cst_PkOrF_XOnlyPubkey XOnlyPubkey;
  struct wire_cst_PkOrF_Fingerprint Fingerprint;
} PkOrFKind;

typedef struct wire_cst_pk_or_f {
  int32_t tag;
  union PkOrFKind kind;
} wire_cst_pk_or_f;

typedef struct wire_cst_list_bdk_policy {
  struct wire_cst_bdk_policy *ptr;
  int32_t len;
} wire_cst_list_bdk_policy;

typedef struct wire_cst_bdk_transaction_details {
  struct wire_cst_bdk_transaction *transaction;
  struct wire_cst_list_prim_u_8_strict *txid;
  uint64_t received;
  uint64_t sent;
  uint64_t *fee;
  struct wire_cst_block_time *confirmation_time;
} wire_cst_bdk_transaction_details;

typedef struct wire_cst_list_bdk_transaction_details {
  struct wire_cst_bdk_transaction_details *ptr;
  int32_t len;
} wire_cst_list_bdk_transaction_details;

typedef struct wire_cst_list_condition {
  struct wire_cst_condition *ptr;
  int32_t len;
} wire_cst_list_condition;

typedef struct wire_cst_list_local_utxo {
  struct wire_cst_local_utxo *ptr;
  int32_t len;
} wire_cst_list_local_utxo;

typedef struct wire_cst_list_pk_or_f {
  struct wire_cst_pk_or_f *ptr;
  int32_t len;
} wire_cst_list_pk_or_f;

typedef struct wire_cst_list_prim_u_64_strict {
  uint64_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_64_strict;

typedef struct wire_cst_record_list_prim_u_32_strict_list_condition {
  struct wire_cst_list_prim_u_32_strict *field0;
  struct wire_cst_list_condition *field1;
} wire_cst_record_list_prim_u_32_strict_list_condition;

typedef struct wire_cst_list_record_list_prim_u_32_strict_list_condition {
  struct wire_cst_record_list_prim_u_32_strict_list_condition *ptr;
  int32_t len;
} wire_cst_list_record_list_prim_u_32_strict_list_condition;

typedef struct wire_cst_record_u_32_list_condition {
  uint32_t field0;
  struct wire_cst_list_condition *field1;
} wire_cst_record_u_32_list_condition;

typedef struct wire_cst_list_record_u_32_list_condition {
  struct wire_cst_record_u_32_list_condition *ptr;
  int32_t len;
} wire_cst_list_record_u_32_list_condition;

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

typedef struct wire_cst_BdkError_VerifyTransaction {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_VerifyTransaction;

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

typedef struct wire_cst_BdkError_InvalidInput {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_InvalidInput;

typedef struct wire_cst_BdkError_InvalidLockTime {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_InvalidLockTime;

typedef struct wire_cst_BdkError_InvalidTransaction {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_BdkError_InvalidTransaction;

typedef union BdkErrorKind {
  struct wire_cst_BdkError_Hex Hex;
  struct wire_cst_BdkError_Consensus Consensus;
  struct wire_cst_BdkError_VerifyTransaction VerifyTransaction;
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
  struct wire_cst_BdkError_InvalidInput InvalidInput;
  struct wire_cst_BdkError_InvalidLockTime InvalidLockTime;
  struct wire_cst_BdkError_InvalidTransaction InvalidTransaction;
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

typedef struct wire_cst_record_bdk_address_u_32 {
  struct wire_cst_bdk_address field0;
  uint32_t field1;
} wire_cst_record_bdk_address_u_32;

typedef struct wire_cst_record_bdk_psbt_bdk_transaction_details {
  struct wire_cst_bdk_psbt field0;
  struct wire_cst_bdk_transaction_details field1;
} wire_cst_record_bdk_psbt_bdk_transaction_details;

typedef struct wire_cst_Satisfaction_Partial {
  uint64_t n;
  uint64_t m;
  struct wire_cst_list_prim_u_64_strict *items;
  bool *sorted;
  struct wire_cst_list_record_u_32_list_condition *conditions;
} wire_cst_Satisfaction_Partial;

typedef struct wire_cst_Satisfaction_PartialComplete {
  uint64_t n;
  uint64_t m;
  struct wire_cst_list_prim_u_64_strict *items;
  bool *sorted;
  struct wire_cst_list_record_list_prim_u_32_strict_list_condition *conditions;
} wire_cst_Satisfaction_PartialComplete;

typedef struct wire_cst_Satisfaction_Complete {
  struct wire_cst_condition *condition;
} wire_cst_Satisfaction_Complete;

typedef struct wire_cst_Satisfaction_None {
  struct wire_cst_list_prim_u_8_strict *msg;
} wire_cst_Satisfaction_None;

typedef union SatisfactionKind {
  struct wire_cst_Satisfaction_Partial Partial;
  struct wire_cst_Satisfaction_PartialComplete PartialComplete;
  struct wire_cst_Satisfaction_Complete Complete;
  struct wire_cst_Satisfaction_None None;
} SatisfactionKind;

typedef struct wire_cst_satisfaction {
  int32_t tag;
  union SatisfactionKind kind;
} wire_cst_satisfaction;

typedef struct wire_cst_SatisfiableItem_EcdsaSignature {
  struct wire_cst_pk_or_f *key;
} wire_cst_SatisfiableItem_EcdsaSignature;

typedef struct wire_cst_SatisfiableItem_SchnorrSignature {
  struct wire_cst_pk_or_f *key;
} wire_cst_SatisfiableItem_SchnorrSignature;

typedef struct wire_cst_SatisfiableItem_Sha256Preimage {
  struct wire_cst_list_prim_u_8_strict *hash;
} wire_cst_SatisfiableItem_Sha256Preimage;

typedef struct wire_cst_SatisfiableItem_Hash256Preimage {
  struct wire_cst_list_prim_u_8_strict *hash;
} wire_cst_SatisfiableItem_Hash256Preimage;

typedef struct wire_cst_SatisfiableItem_Ripemd160Preimage {
  struct wire_cst_list_prim_u_8_strict *hash;
} wire_cst_SatisfiableItem_Ripemd160Preimage;

typedef struct wire_cst_SatisfiableItem_Hash160Preimage {
  struct wire_cst_list_prim_u_8_strict *hash;
} wire_cst_SatisfiableItem_Hash160Preimage;

typedef struct wire_cst_SatisfiableItem_AbsoluteTimelock {
  struct wire_cst_lock_time *value;
} wire_cst_SatisfiableItem_AbsoluteTimelock;

typedef struct wire_cst_SatisfiableItem_RelativeTimelock {
  uint32_t value;
} wire_cst_SatisfiableItem_RelativeTimelock;

typedef struct wire_cst_SatisfiableItem_Multisig {
  struct wire_cst_list_pk_or_f *keys;
  uint64_t threshold;
} wire_cst_SatisfiableItem_Multisig;

typedef struct wire_cst_SatisfiableItem_Thresh {
  struct wire_cst_list_bdk_policy *items;
  uint64_t threshold;
} wire_cst_SatisfiableItem_Thresh;

typedef union SatisfiableItemKind {
  struct wire_cst_SatisfiableItem_EcdsaSignature EcdsaSignature;
  struct wire_cst_SatisfiableItem_SchnorrSignature SchnorrSignature;
  struct wire_cst_SatisfiableItem_Sha256Preimage Sha256Preimage;
  struct wire_cst_SatisfiableItem_Hash256Preimage Hash256Preimage;
  struct wire_cst_SatisfiableItem_Ripemd160Preimage Ripemd160Preimage;
  struct wire_cst_SatisfiableItem_Hash160Preimage Hash160Preimage;
  struct wire_cst_SatisfiableItem_AbsoluteTimelock AbsoluteTimelock;
  struct wire_cst_SatisfiableItem_RelativeTimelock RelativeTimelock;
  struct wire_cst_SatisfiableItem_Multisig Multisig;
  struct wire_cst_SatisfiableItem_Thresh Thresh;
} SatisfiableItemKind;

typedef struct wire_cst_satisfiable_item {
  int32_t tag;
  union SatisfiableItemKind kind;
} wire_cst_satisfiable_item;

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_as_string(struct wire_cst_bdk_address *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_from_script(struct wire_cst_bdk_script_buf *script,
                                                                                         int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_from_string(struct wire_cst_list_prim_u_8_strict *address,
                                                                                         int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_is_valid_for_network(struct wire_cst_bdk_address *that,
                                                                                                  int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_network(struct wire_cst_bdk_address *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_payload(struct wire_cst_bdk_address *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_script(struct wire_cst_bdk_address *ptr);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_address_to_qr_uri(struct wire_cst_bdk_address *that);

void frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_broadcast(int64_t port_,
                                                                               struct wire_cst_bdk_blockchain *ptr,
                                                                               struct wire_cst_bdk_transaction *transaction);

void frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_create(int64_t port_,
                                                                            struct wire_cst_blockchain_config *blockchain_config);

void frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_estimate_fee(int64_t port_,
                                                                                  struct wire_cst_bdk_blockchain *that,
                                                                                  uint64_t target);

void frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_get_block_hash(int64_t port_,
                                                                                    struct wire_cst_bdk_blockchain *that,
                                                                                    uint32_t height);

void frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_get_height(int64_t port_,
                                                                                struct wire_cst_bdk_blockchain *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_derivation_path_as_string(struct wire_cst_bdk_derivation_path *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_derivation_path_from_string(struct wire_cst_list_prim_u_8_strict *path);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_as_string(struct wire_cst_bdk_descriptor *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_create(struct wire_cst_list_prim_u_8_strict *descriptor,
                                                                                            int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_max_satisfaction_weight(struct wire_cst_bdk_descriptor *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip44(struct wire_cst_bdk_descriptor_secret_key *secret_key,
                                                                                               int32_t keychain_kind,
                                                                                               int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip44_public(struct wire_cst_bdk_descriptor_public_key *public_key,
                                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                                      int32_t keychain_kind,
                                                                                                      int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip49(struct wire_cst_bdk_descriptor_secret_key *secret_key,
                                                                                               int32_t keychain_kind,
                                                                                               int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip49_public(struct wire_cst_bdk_descriptor_public_key *public_key,
                                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                                      int32_t keychain_kind,
                                                                                                      int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip84(struct wire_cst_bdk_descriptor_secret_key *secret_key,
                                                                                               int32_t keychain_kind,
                                                                                               int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip84_public(struct wire_cst_bdk_descriptor_public_key *public_key,
                                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                                      int32_t keychain_kind,
                                                                                                      int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip86(struct wire_cst_bdk_descriptor_secret_key *secret_key,
                                                                                               int32_t keychain_kind,
                                                                                               int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip86_public(struct wire_cst_bdk_descriptor_public_key *public_key,
                                                                                                      struct wire_cst_list_prim_u_8_strict *fingerprint,
                                                                                                      int32_t keychain_kind,
                                                                                                      int32_t network);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_as_string(struct wire_cst_bdk_descriptor_public_key *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_derive(struct wire_cst_bdk_descriptor_public_key *ptr,
                                                                                                struct wire_cst_bdk_derivation_path *path);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_extend(struct wire_cst_bdk_descriptor_public_key *ptr,
                                                                                                struct wire_cst_bdk_derivation_path *path);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_from_string(struct wire_cst_list_prim_u_8_strict *public_key);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_as_public(struct wire_cst_bdk_descriptor_secret_key *ptr);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_as_string(struct wire_cst_bdk_descriptor_secret_key *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_create(int32_t network,
                                                                                                struct wire_cst_bdk_mnemonic *mnemonic,
                                                                                                struct wire_cst_list_prim_u_8_strict *password);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_derive(struct wire_cst_bdk_descriptor_secret_key *ptr,
                                                                                                struct wire_cst_bdk_derivation_path *path);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_extend(struct wire_cst_bdk_descriptor_secret_key *ptr,
                                                                                                struct wire_cst_bdk_derivation_path *path);

void frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_from_string(int64_t port_,
                                                                                     struct wire_cst_list_prim_u_8_strict *secret_key);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_secret_bytes(struct wire_cst_bdk_descriptor_secret_key *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_to_string_private(struct wire_cst_bdk_descriptor *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_as_string(struct wire_cst_bdk_mnemonic *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_create(int32_t word_count);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_from_entropy(struct wire_cst_list_prim_u_8_loose *entropy);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_from_string(struct wire_cst_list_prim_u_8_strict *mnemonic);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_as_string(struct wire_cst_bdk_policy *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_contribution(struct wire_cst_bdk_policy *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_id(struct wire_cst_bdk_policy *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_item(struct wire_cst_bdk_policy *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_requires_path(struct wire_cst_bdk_policy *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_satisfaction(struct wire_cst_bdk_policy *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_as_string(struct wire_cst_bdk_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_combine(struct wire_cst_bdk_psbt *ptr,
                                                                                 struct wire_cst_bdk_psbt *other);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_extract_tx(struct wire_cst_bdk_psbt *ptr);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_fee_amount(struct wire_cst_bdk_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_fee_rate(struct wire_cst_bdk_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_from_str(struct wire_cst_list_prim_u_8_strict *psbt_base64);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_json_serialize(struct wire_cst_bdk_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_serialize(struct wire_cst_bdk_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_txid(struct wire_cst_bdk_psbt *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_as_string(struct wire_cst_bdk_script_buf *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_empty(void);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_from_hex(struct wire_cst_list_prim_u_8_strict *s);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_with_capacity(uintptr_t capacity);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_create(int32_t version,
                                                                                        struct wire_cst_lock_time *lock_time,
                                                                                        struct wire_cst_list_bdk_tx_in *input,
                                                                                        struct wire_cst_list_bdk_tx_out *output);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_from_bytes(struct wire_cst_list_prim_u_8_loose *transaction_bytes);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_input(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_is_coin_base(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_is_explicitly_rbf(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_is_lock_time_enabled(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_lock_time(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_output(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_serialize(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_size(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_txid(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_version(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_vsize(struct wire_cst_bdk_transaction *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_weight(struct wire_cst_bdk_transaction *that);

void frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_create(int64_t port_,
                                                                    struct wire_cst_bdk_descriptor *descriptor,
                                                                    struct wire_cst_bdk_descriptor *change_descriptor,
                                                                    int32_t network,
                                                                    struct wire_cst_database_config *database_config);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_address(struct wire_cst_bdk_wallet *ptr,
                                                                                         struct wire_cst_address_index *address_index);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_balance(struct wire_cst_bdk_wallet *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_descriptor_for_keychain(struct wire_cst_bdk_wallet *ptr,
                                                                                                         int32_t keychain);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_internal_address(struct wire_cst_bdk_wallet *ptr,
                                                                                                  struct wire_cst_address_index *address_index);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_psbt_input(struct wire_cst_bdk_wallet *that,
                                                                                            struct wire_cst_local_utxo *utxo,
                                                                                            bool only_witness_utxo,
                                                                                            struct wire_cst_psbt_sig_hash_type *sighash_type);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_is_mine(struct wire_cst_bdk_wallet *ptr,
                                                                                     struct wire_cst_bdk_script_buf *script);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_list_transactions(struct wire_cst_bdk_wallet *that,
                                                                                               bool include_raw);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_list_unspent(struct wire_cst_bdk_wallet *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_network(struct wire_cst_bdk_wallet *that);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_policies(struct wire_cst_bdk_wallet *ptr,
                                                                                      int32_t keychain);

WireSyncRust2DartDco frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_sign(struct wire_cst_bdk_wallet *ptr,
                                                                                  struct wire_cst_bdk_psbt *psbt,
                                                                                  struct wire_cst_sign_options *sign_options);

void frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_sync(int64_t port_,
                                                                  struct wire_cst_bdk_wallet *ptr,
                                                                  struct wire_cst_bdk_blockchain *blockchain);

void frbgen_bdk_flutter_wire__crate__api__wallet__finish_bump_fee_tx_builder(int64_t port_,
                                                                             struct wire_cst_list_prim_u_8_strict *txid,
                                                                             float fee_rate,
                                                                             struct wire_cst_bdk_address *allow_shrinking,
                                                                             struct wire_cst_bdk_wallet *wallet,
                                                                             bool enable_rbf,
                                                                             uint32_t *n_sequence);

void frbgen_bdk_flutter_wire__crate__api__types__network_default(int64_t port_);

void frbgen_bdk_flutter_wire__crate__api__types__sign_options_default(int64_t port_);

void frbgen_bdk_flutter_wire__crate__api__wallet__tx_builder_finish(int64_t port_,
                                                                    struct wire_cst_bdk_wallet *wallet,
                                                                    struct wire_cst_list_script_amount *recipients,
                                                                    struct wire_cst_list_out_point *utxos,
                                                                    struct wire_cst_record_out_point_input_usize *foreign_utxo,
                                                                    struct wire_cst_list_out_point *un_spendable,
                                                                    int32_t change_policy,
                                                                    bool manually_selected_only,
                                                                    float *fee_rate,
                                                                    uint64_t *fee_absolute,
                                                                    bool drain_wallet,
                                                                    struct wire_cst_bdk_script_buf *drain_to,
                                                                    struct wire_cst_rbf_value *rbf,
                                                                    struct wire_cst_list_record_string_list_prim_u_32_strict *internal_policy_path,
                                                                    struct wire_cst_list_record_string_list_prim_u_32_strict *external_policy_path,
                                                                    struct wire_cst_list_prim_u_8_loose *data);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkbitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkbitcoinAddress(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkbitcoinbip32DerivationPath(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkbitcoinbip32DerivationPath(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkblockchainAnyBlockchain(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkblockchainAnyBlockchain(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkdescriptorExtendedDescriptor(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkdescriptorExtendedDescriptor(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkdescriptorPolicy(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkdescriptorPolicy(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysDescriptorPublicKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysDescriptorPublicKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysDescriptorSecretKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysDescriptorSecretKey(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysKeyMap(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysKeyMap(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysbip39Mnemonic(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysbip39Mnemonic(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdkWalletbdkdatabaseAnyDatabase(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdkWalletbdkdatabaseAnyDatabase(const void *ptr);

void frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdkbitcoinpsbtPartiallySignedTransaction(const void *ptr);

void frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdkbitcoinpsbtPartiallySignedTransaction(const void *ptr);

struct wire_cst_address_error *frbgen_bdk_flutter_cst_new_box_autoadd_address_error(void);

struct wire_cst_address_index *frbgen_bdk_flutter_cst_new_box_autoadd_address_index(void);

struct wire_cst_bdk_address *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_address(void);

struct wire_cst_bdk_blockchain *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_blockchain(void);

struct wire_cst_bdk_derivation_path *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_derivation_path(void);

struct wire_cst_bdk_descriptor *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_descriptor(void);

struct wire_cst_bdk_descriptor_public_key *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_descriptor_public_key(void);

struct wire_cst_bdk_descriptor_secret_key *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_descriptor_secret_key(void);

struct wire_cst_bdk_mnemonic *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_mnemonic(void);

struct wire_cst_bdk_policy *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_policy(void);

struct wire_cst_bdk_psbt *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_psbt(void);

struct wire_cst_bdk_script_buf *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_script_buf(void);

struct wire_cst_bdk_transaction *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_transaction(void);

struct wire_cst_bdk_wallet *frbgen_bdk_flutter_cst_new_box_autoadd_bdk_wallet(void);

struct wire_cst_block_time *frbgen_bdk_flutter_cst_new_box_autoadd_block_time(void);

struct wire_cst_blockchain_config *frbgen_bdk_flutter_cst_new_box_autoadd_blockchain_config(void);

bool *frbgen_bdk_flutter_cst_new_box_autoadd_bool(bool value);

struct wire_cst_condition *frbgen_bdk_flutter_cst_new_box_autoadd_condition(void);

struct wire_cst_consensus_error *frbgen_bdk_flutter_cst_new_box_autoadd_consensus_error(void);

struct wire_cst_database_config *frbgen_bdk_flutter_cst_new_box_autoadd_database_config(void);

struct wire_cst_descriptor_error *frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_error(void);

struct wire_cst_electrum_config *frbgen_bdk_flutter_cst_new_box_autoadd_electrum_config(void);

struct wire_cst_esplora_config *frbgen_bdk_flutter_cst_new_box_autoadd_esplora_config(void);

float *frbgen_bdk_flutter_cst_new_box_autoadd_f_32(float value);

struct wire_cst_fee_rate *frbgen_bdk_flutter_cst_new_box_autoadd_fee_rate(void);

struct wire_cst_hex_error *frbgen_bdk_flutter_cst_new_box_autoadd_hex_error(void);

struct wire_cst_local_utxo *frbgen_bdk_flutter_cst_new_box_autoadd_local_utxo(void);

struct wire_cst_lock_time *frbgen_bdk_flutter_cst_new_box_autoadd_lock_time(void);

struct wire_cst_out_point *frbgen_bdk_flutter_cst_new_box_autoadd_out_point(void);

struct wire_cst_pk_or_f *frbgen_bdk_flutter_cst_new_box_autoadd_pk_or_f(void);

struct wire_cst_psbt_sig_hash_type *frbgen_bdk_flutter_cst_new_box_autoadd_psbt_sig_hash_type(void);

struct wire_cst_rbf_value *frbgen_bdk_flutter_cst_new_box_autoadd_rbf_value(void);

struct wire_cst_record_out_point_input_usize *frbgen_bdk_flutter_cst_new_box_autoadd_record_out_point_input_usize(void);

struct wire_cst_rpc_config *frbgen_bdk_flutter_cst_new_box_autoadd_rpc_config(void);

struct wire_cst_rpc_sync_params *frbgen_bdk_flutter_cst_new_box_autoadd_rpc_sync_params(void);

struct wire_cst_sign_options *frbgen_bdk_flutter_cst_new_box_autoadd_sign_options(void);

struct wire_cst_sled_db_configuration *frbgen_bdk_flutter_cst_new_box_autoadd_sled_db_configuration(void);

struct wire_cst_sqlite_db_configuration *frbgen_bdk_flutter_cst_new_box_autoadd_sqlite_db_configuration(void);

uint32_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_32(uint32_t value);

uint64_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_64(uint64_t value);

uint8_t *frbgen_bdk_flutter_cst_new_box_autoadd_u_8(uint8_t value);

struct wire_cst_list_bdk_policy *frbgen_bdk_flutter_cst_new_list_bdk_policy(int32_t len);

struct wire_cst_list_bdk_transaction_details *frbgen_bdk_flutter_cst_new_list_bdk_transaction_details(int32_t len);

struct wire_cst_list_bdk_tx_in *frbgen_bdk_flutter_cst_new_list_bdk_tx_in(int32_t len);

struct wire_cst_list_bdk_tx_out *frbgen_bdk_flutter_cst_new_list_bdk_tx_out(int32_t len);

struct wire_cst_list_condition *frbgen_bdk_flutter_cst_new_list_condition(int32_t len);

struct wire_cst_list_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_local_utxo *frbgen_bdk_flutter_cst_new_list_local_utxo(int32_t len);

struct wire_cst_list_out_point *frbgen_bdk_flutter_cst_new_list_out_point(int32_t len);

struct wire_cst_list_pk_or_f *frbgen_bdk_flutter_cst_new_list_pk_or_f(int32_t len);

struct wire_cst_list_prim_u_32_strict *frbgen_bdk_flutter_cst_new_list_prim_u_32_strict(int32_t len);

struct wire_cst_list_prim_u_64_strict *frbgen_bdk_flutter_cst_new_list_prim_u_64_strict(int32_t len);

struct wire_cst_list_prim_u_8_loose *frbgen_bdk_flutter_cst_new_list_prim_u_8_loose(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_bdk_flutter_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_record_list_prim_u_32_strict_list_condition *frbgen_bdk_flutter_cst_new_list_record_list_prim_u_32_strict_list_condition(int32_t len);

struct wire_cst_list_record_string_list_prim_u_32_strict *frbgen_bdk_flutter_cst_new_list_record_string_list_prim_u_32_strict(int32_t len);

struct wire_cst_list_record_u_32_list_condition *frbgen_bdk_flutter_cst_new_list_record_u_32_list_condition(int32_t len);

struct wire_cst_list_script_amount *frbgen_bdk_flutter_cst_new_list_script_amount(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_address_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_address_index);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_blockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_derivation_path);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_descriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_descriptor_public_key);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_descriptor_secret_key);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_policy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_psbt);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_script_buf);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_transaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bdk_wallet);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_block_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_blockchain_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_bool);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_condition);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_consensus_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_database_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_descriptor_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_electrum_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_esplora_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_f_32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_fee_rate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_hex_error);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_local_utxo);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_out_point);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_pk_or_f);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_psbt_sig_hash_type);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rbf_value);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_record_out_point_input_usize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rpc_config);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_rpc_sync_params);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sign_options);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sled_db_configuration);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_sqlite_db_configuration);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_32);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_64);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_box_autoadd_u_8);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_bdk_policy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_bdk_transaction_details);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_bdk_tx_in);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_bdk_tx_out);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_condition);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_local_utxo);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_out_point);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_pk_or_f);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_32_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_64_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_loose);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_record_list_prim_u_32_strict_list_condition);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_record_string_list_prim_u_32_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_record_u_32_list_condition);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_cst_new_list_script_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkbitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkbitcoinbip32DerivationPath);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkblockchainAnyBlockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkdescriptorExtendedDescriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkdescriptorPolicy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysDescriptorPublicKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysDescriptorSecretKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysKeyMap);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_bdkkeysbip39Mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdkWalletbdkdatabaseAnyDatabase);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_decrement_strong_count_RustOpaque_stdsyncMutexbdkbitcoinpsbtPartiallySignedTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkbitcoinAddress);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkbitcoinbip32DerivationPath);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkblockchainAnyBlockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkdescriptorExtendedDescriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkdescriptorPolicy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysDescriptorPublicKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysDescriptorSecretKey);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysKeyMap);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_bdkkeysbip39Mnemonic);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdkWalletbdkdatabaseAnyDatabase);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_rust_arc_increment_strong_count_RustOpaque_stdsyncMutexbdkbitcoinpsbtPartiallySignedTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_broadcast);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_estimate_fee);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_get_block_hash);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__blockchain__bdk_blockchain_get_height);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_max_satisfaction_weight);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip44);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip44_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip49);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip49_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip84);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip84_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip86);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_new_bip86_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__descriptor__bdk_descriptor_to_string_private);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_derivation_path_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_derivation_path_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_derive);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_extend);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_public_key_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_as_public);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_derive);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_extend);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_descriptor_secret_key_secret_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_from_entropy);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__key__bdk_mnemonic_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_combine);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_extract_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_fee_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_fee_rate);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_from_str);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_json_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__psbt__bdk_psbt_txid);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_from_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_is_valid_for_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_payload);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_script);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_address_to_qr_uri);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_contribution);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_id);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_item);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_requires_path);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_policy_satisfaction);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_as_string);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_empty);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_from_hex);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_script_buf_with_capacity);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_from_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_input);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_is_coin_base);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_is_explicitly_rbf);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_is_lock_time_enabled);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_output);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_serialize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_size);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_txid);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_version);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_vsize);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__bdk_transaction_weight);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__network_default);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__types__sign_options_default);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_create);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_descriptor_for_keychain);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_internal_address);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_get_psbt_input);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_is_mine);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_list_transactions);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_list_unspent);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_network);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_policies);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_sign);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__bdk_wallet_sync);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__finish_bump_fee_tx_builder);
    dummy_var ^= ((int64_t) (void*) frbgen_bdk_flutter_wire__crate__api__wallet__tx_builder_finish);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
