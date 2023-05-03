import 'dart:typed_data' as typed_data;

import 'package:flutter/foundation.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

import 'generated/bridge_definitions.dart';
import 'utils/utils.dart';

///A Bitcoin address.
class Address {
  String? _address;
  Address._();
  Address _setAddress(String address) {
    _address = address;
    return this;
  }

  /// Creates an instance of [Address] from address given.
  ///
  /// Throws a [BdkException] if the address is not valid
  static Future<Address> create({required String address}) async {
    try {
      final res =
          await loaderApi.createAddressStaticMethodApi(address: address);
      return Address._()._setAddress(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// [Constructor]
  ///
  static Future<Address> fromScript(Script script, Network network) async {
    final res = await loaderApi.addressFromScriptStaticMethodApi(
        script: script, network: network);
    return Address._()._setAddress(res);
  }

  ///The type of the address.
  ///
  Future<Payload> payload() async {
    final res = await loaderApi.payloadStaticMethodApi(address: _address!);
    return res;
  }

  Future<Network> network() async {
    final res =
        await loaderApi.addressNetworkStaticMethodApi(address: _address!);
    return res;
  }

  /// Returns the script pub key of the [Address] object
  Future<Script> scriptPubKey() async {
    try {
      final res = await loaderApi.addressToScriptPubkeyHexStaticMethodApi(
          address: _address.toString());
      return Script(scriptHex: res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return _address.toString();
  }
}

/// Blockchain backends  module provides the implementation of a few commonly-used backends like Electrum, and Esplora.
class Blockchain {
  BlockchainInstance? _blockchain;
  Blockchain._();
  Blockchain _setBlockchain(BlockchainInstance blockchain) {
    _blockchain = blockchain;
    return this;
  }

  ///  [Blockchain] constructor
  static Future<Blockchain> create({required BlockchainConfig config}) async {
    try {
      final res =
          await loaderApi.createBlockchainStaticMethodApi(config: config);
      return Blockchain._()._setBlockchain(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// The function for getting block hash by block height
  Future<String> getBlockHash(int height) async {
    try {
      var res = await loaderApi.getBlockchainHashStaticMethodApi(
          blockchainHeight: height, blockchain: _blockchain!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// The function for getting the current height of the blockchain.
  Future<int> getHeight() async {
    try {
      var res =
          await loaderApi.getHeightStaticMethodApi(blockchain: _blockchain!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Estimate the fee rate required to confirm a transaction in a given target of blocks
  Future<FeeRate> estimateFee(int target) async {
    try {
      var res = await loaderApi.estimateFeeStaticMethodApi(
          blockchain: _blockchain!, target: target);
      return FeeRate._()._setFeeRate(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// The function for broadcasting a transaction
  Future<void> broadcast(Transaction tx) async {
    try {
      final txid = await loaderApi.broadcastStaticMethodApi(
          blockchain: _blockchain!, tx: tx._tx!);
      if (kDebugMode) {
        print(txid);
      }
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }
}

/// The BumpFeeTxBuilder is used to bump the fee on a transaction that has been broadcast and has its RBF flag set to true.
class BumpFeeTxBuilder {
  int? _nSequence;
  String? _allowShrinking;
  bool _enableRbf = false;
  final String txid;
  final double feeRate;

  BumpFeeTxBuilder({required this.txid, required this.feeRate});

  ///Explicitly tells the wallet that it is allowed to reduce the amount of the output matching this `address` in order to bump the transaction fee. Without specifying this the wallet will attempt to find a change output to shrink instead.
  ///
  /// Note that the output may shrink to below the dust limit and therefore be removed. If it is preserved then it is currently not guaranteed to be in the same position as it was originally.
  ///
  /// Throws and exception if address can’t be found among the recipients of the transaction we are bumping.
  BumpFeeTxBuilder allowShrinking(String address) {
    _allowShrinking = address;
    return this;
  }

  ///Enable signaling RBF
  ///
  /// This will use the default nSequence value of `0xFFFFFFFD`
  BumpFeeTxBuilder enableRbf() {
    _enableRbf = true;
    return this;
  }

  ///Enable signaling RBF with a specific nSequence value
  ///
  /// This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.
  ///
  /// If the nsequence is higher than `0xFFFFFFFD` an error will be thrown, since it would not be a valid nSequence to signal RBF.

  BumpFeeTxBuilder enableRbfWithSequence(int nSequence) {
    _nSequence = nSequence;
    return this;
  }

  /// Finish building the transaction. Returns the  [TxBuilderResult].
  Future<TxBuilderResult> finish(Wallet wallet) async {
    try {
      final res = await loaderApi.bumpFeeTxBuilderFinishStaticMethodApi(
          txid: txid.toString(),
          enableRbf: _enableRbf,
          feeRate: feeRate,
          wallet: wallet._wallet!,
          nSequence: _nSequence,
          allowShrinking: _allowShrinking);
      return TxBuilderResult(
          psbt: PartiallySignedTransaction(psbtBase64: res.field0),
          txDetails: res.field1);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }
}

///A `BIP-32` derivation path
class DerivationPath {
  String? _path;
  DerivationPath._();
  DerivationPath _setDerivationPath(String path) {
    _path = path;
    return this;
  }

  ///  [DerivationPath] constructor
  static Future<DerivationPath> create({required String path}) async {
    try {
      final res =
          await loaderApi.createDerivationPathStaticMethodApi(path: path);
      return DerivationPath._()._setDerivationPath(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return _path!;
  }
}

///Script descriptor
class Descriptor {
  BdkDescriptor? _descriptorInstance;
  Descriptor._();
  Descriptor _setDescriptor(BdkDescriptor? descriptorInstance) {
    _descriptorInstance = descriptorInstance;
    return this;
  }

  ///  [Descriptor] constructor
  static Future<Descriptor> create(
      {required String descriptor, required Network network}) async {
    try {
      final res = await loaderApi.createDescriptorStaticMethodApi(
          descriptor: descriptor, network: network);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///BIP44 template. Expands to pkh(key/44'/{0,1}'/0'/{0,1}/*)
  ///
  /// Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip44(
      {required DescriptorSecretKey secretKey,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      final res = await loaderApi.newBip44DescriptorStaticMethodApi(
          secretKey: secretKey.asString(),
          network: network,
          keyChainKind: keychain);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///BIP44 public template. Expands to pkh(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/44'/0'/0' for Mainnet or m/44'/1'/0' for Testnet.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip44Public(
      {required DescriptorPublicKey publicKey,
      required String fingerPrint,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      final res = await loaderApi.newBip44PublicStaticMethodApi(
          keyChainKind: keychain,
          publicKey: publicKey.asString(),
          network: network,
          fingerprint: fingerPrint);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///BIP49 template. Expands to sh(wpkh(key/49'/{0,1}'/0'/{0,1}/*))
  ///
  ///Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip49(
      {required DescriptorSecretKey secretKey,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      final res = await loaderApi.newBip49DescriptorStaticMethodApi(
          secretKey: secretKey.asString(),
          network: network,
          keyChainKind: keychain);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///BIP49 public template. Expands to sh(wpkh(key/{0,1}/*))
  ///
  /// This assumes that the key used has already been derived with m/49'/0'/0'.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip49Public(
      {required DescriptorPublicKey publicKey,
      required String fingerPrint,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      final res = await loaderApi.newBip49PublicStaticMethodApi(
          keyChainKind: keychain,
          publicKey: publicKey.asString(),
          network: network,
          fingerprint: fingerPrint);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///BIP84 template. Expands to wpkh(key/84'/{0,1}'/0'/{0,1}/*)
  ///
  ///Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip84(
      {required DescriptorSecretKey secretKey,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      final res = await loaderApi.newBip84DescriptorStaticMethodApi(
          secretKey: secretKey.asString(),
          network: network,
          keyChainKind: keychain);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///BIP84 public template. Expands to wpkh(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/84'/0'/0'.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip84Public(
      {required DescriptorPublicKey publicKey,
      required fingerPrint,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      final res = await loaderApi.newBip84PublicStaticMethodApi(
          keyChainKind: keychain,
          publicKey: publicKey.asString(),
          network: network,
          fingerprint: fingerPrint);
      return Descriptor._()._setDescriptor(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return the private version of the output descriptor if available, otherwise return the public version.
  Future<String> asStringPrivate() async {
    try {
      final res = await loaderApi.asStringPrivateStaticMethodApi(
          descriptor: _descriptorInstance!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return the public version of the output descriptor.
  Future<String> asString() async {
    try {
      final res = await loaderApi.asStringStaticMethodApi(
          descriptor: _descriptorInstance!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }
}

///An extended public key.
class DescriptorPublicKey {
  String? _descriptorPublicKey;

  DescriptorPublicKey._();

  DescriptorPublicKey _setDescriptorPublicKey(String descriptorPublicKey) {
    _descriptorPublicKey = descriptorPublicKey;
    return this;
  }

  /// Get the public key as string.
  String asString() {
    return _descriptorPublicKey.toString();
  }

  ///Derive a public descriptor at a given path.
  Future<DescriptorPublicKey> derive(DerivationPath derivationPath) async {
    try {
      final res = await loaderApi.createDescriptorPublicStaticMethodApi(
          xpub: _descriptorPublicKey,
          path: derivationPath._path.toString(),
          derive: true);
      return DescriptorPublicKey._()._setDescriptorPublicKey(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Extend the public descriptor with a custom path.
  Future<DescriptorPublicKey> extend(DerivationPath derivationPath) async {
    try {
      final res = await loaderApi.createDescriptorPublicStaticMethodApi(
          xpub: _descriptorPublicKey,
          path: derivationPath._path.toString(),
          derive: false);
      return DescriptorPublicKey._()._setDescriptorPublicKey(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// [DescriptorPublicKey] constructor
  static Future<DescriptorPublicKey> fromString(String publicKey) async {
    try {
      final res = await loaderApi.descriptorPublicFromStringStaticMethodApi(
          publicKey: publicKey);
      return DescriptorPublicKey._()._setDescriptorPublicKey(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return asString();
  }
}

class DescriptorSecretKey {
  String? _descriptorSecretKey;
  String? _xprv;
  DescriptorSecretKey._();
  DescriptorSecretKey _setXprv(String key) {
    _xprv = key;
    return this;
  }

  DescriptorSecretKey _setDescriptorSecretKey(String secretKey) {
    _descriptorSecretKey = secretKey;
    return this;
  }

  ///Returns the public version of this key.
  ///
  /// If the key is an “XPrv”, the hardened derivation steps will be applied before converting it to a public key.
  Future<DescriptorPublicKey> asPublic() async {
    try {
      final xpub = await loaderApi.asPublicStaticMethodApi(
          xprv: _xprv, descriptorSecret: _descriptorSecretKey);
      return DescriptorPublicKey._()._setDescriptorPublicKey(xpub);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Get the private key as string.
  String asString() {
    return _descriptorSecretKey ?? _xprv.toString();
  }

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> create(
      {required Network network,
      required Mnemonic mnemonic,
      String? password}) async {
    try {
      final res = await loaderApi.createDescriptorSecretStaticMethodApi(
          network: network, mnemonic: mnemonic.asString(), password: password);
      return DescriptorSecretKey._()._setXprv(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Derived the `XPrv` using the derivation path
  Future<DescriptorSecretKey> derive(DerivationPath derivationPath) async {
    try {
      _descriptorSecretKey =
          await loaderApi.deriveDescriptorSecretStaticMethodApi(
              xprv: _xprv.toString(), path: derivationPath._path.toString());
      return this;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Extends the “XPrv” using the derivation path
  Future<DescriptorSecretKey> extend(DerivationPath derivationPath) async {
    try {
      _descriptorSecretKey =
          await loaderApi.extendDescriptorSecretStaticMethodApi(
              xprv: _xprv.toString(), path: derivationPath._path.toString());
      return this;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> fromString(String secretKey) async {
    try {
      final res = await loaderApi.descriptorSecretFromStringStaticMethodApi(
          xprv: secretKey);
      return DescriptorSecretKey._()._setDescriptorSecretKey(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Get the private key as bytes.
  Future<List<int>> secretBytes() async {
    try {
      final res = await loaderApi.asSecretBytesStaticMethodApi(
          xprv: _xprv, descriptorSecret: _descriptorSecretKey);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return asString();
  }
}

class FeeRate {
  double? _feeRate;
  FeeRate._();
  FeeRate _setFeeRate(double feeRate) {
    _feeRate = feeRate;
    return this;
  }

  double asSatPerVb() {
    return _feeRate!;
  }
}

/// Mnemonic phrases are a human-readable version of the private keys.
/// Supported number of words are 12, 18, and 24.
class Mnemonic {
  String? _mnemonic;
  Mnemonic._();
  Mnemonic _setMnemonic(String mnemonic) {
    _mnemonic = mnemonic;
    return this;
  }

  /// Generates [Mnemonic] with given [WordCount]
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> create(WordCount wordCount) async {
    try {
      final res = await loaderApi.generateSeedFromWordCountStaticMethodApi(
          wordCount: wordCount);
      return Mnemonic._()._setMnemonic(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Returns [Mnemonic] as string
  String asString() {
    return _mnemonic.toString();
  }

  /// Create a new [Mnemonic] in the specified language from the given entropy.
  /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromEntropy(typed_data.Uint8List entropy) async {
    try {
      final res = await loaderApi.generateSeedFromEntropyStaticMethodApi(
          entropy: entropy);
      return Mnemonic._()._setMnemonic(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Parse a [Mnemonic] with given string
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromString(String mnemonic) async {
    try {
      final res = await loaderApi.generateSeedFromStringStaticMethodApi(
          mnemonic: mnemonic);
      return Mnemonic._()._setMnemonic(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return asString();
  }
}

///A Partially Signed Transaction
class PartiallySignedTransaction {
  final String psbtBase64;

  PartiallySignedTransaction({required this.psbtBase64});

  /// Combines this [PartiallySignedTransaction] with other PSBT as described by BIP 174.
  ///
  /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
  Future<PartiallySignedTransaction> combine(
      PartiallySignedTransaction other) async {
    try {
      final res = await loaderApi.combinePsbtStaticMethodApi(
          psbtStr: psbtBase64, other: other.psbtBase64);
      return PartiallySignedTransaction(psbtBase64: res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Return the transaction as bytes.
  Future<Transaction> extractTx() async {
    try {
      final res = await loaderApi.extractTxStaticMethodApi(psbtStr: psbtBase64);
      return Transaction._()._setTransaction(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Return feeAmount
  Future<int?> feeAmount() async {
    try {
      final res =
          await loaderApi.psbtFeeAmountStaticMethodApi(psbtStr: psbtBase64);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Return Fee Rate
  Future<FeeRate?> feeRate() async {
    try {
      final res =
          await loaderApi.psbtFeeRateStaticMethodApi(psbtStr: psbtBase64);
      if (res == null) return null;
      return FeeRate._()._setFeeRate(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Return txid as string
  Future<String> serialize() async {
    try {
      final res =
          await loaderApi.serializePsbtStaticMethodApi(psbtStr: psbtBase64);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  Future<String> jsonSerialize() async {
    try {
      final res =
          await loaderApi.jsonSerializeStaticMethodApi(psbtStr: psbtBase64);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return psbtBase64;
  }

  /// Returns the [PartiallySignedTransaction] transaction id
  Future<String> txId() async {
    try {
      final res = await loaderApi.psbtTxidStaticMethodApi(psbtStr: psbtBase64);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }
}

///Bitcoin script.
///
/// A list of instructions in a simple, Forth-like, stack-based programming language that Bitcoin uses.
///
/// See [Bitcoin Wiki: Script](https://en.bitcoin.it/wiki/Script) for more information.
class Script extends BdkScript {
  Script({required super.scriptHex});

  /// [Script] constructor
  static Future<Script> create(typed_data.Uint8List rawOutputScript) async {
    try {
      final res = await loaderApi.createScriptStaticMethodApi(
          rawOutputScript: rawOutputScript);
      return Script(scriptHex: res.scriptHex);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  @override
  String toString() {
    return scriptHex;
  }
}

///A bitcoin transaction.
class Transaction {
  String? _tx;
  Transaction._();
  Transaction _setTransaction(String tx) {
    _tx = tx;
    return this;
  }

  ///  [Transaction] constructor
  static Future<Transaction> create({
    required List<int> transactionBytes,
  }) async {
    try {
      final tx = Uint8List.fromList(transactionBytes);
      final res = await loaderApi.createTransactionStaticMethodApi(tx: tx);
      return Transaction._()._setTransaction(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return the transaction bytes, bitcoin consensus encoded.
  Future<List<int>> serialize() async {
    final res = await loaderApi.serializeTxStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<String> txid() async {
    final res = await loaderApi.txTxidStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<int> weight() async {
    final res = await loaderApi.weightStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<int> size() async {
    final res = await loaderApi.sizeStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<int> vsize() async {
    final res = await loaderApi.vsizeStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<bool> isCoinBase() async {
    final res = await loaderApi.isCoinBaseStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<bool> isExplicitlyRbf() async {
    final res = await loaderApi.isExplicitlyRbfStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<bool> isLockTimeEnabled() async {
    final res = await loaderApi.isLockTimeEnabledStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<int> version() async {
    final res = await loaderApi.versionStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<int> lockTime() async {
    final res = await loaderApi.lockTimeStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<List<TxIn>> input() async {
    final res = await loaderApi.inputStaticMethodApi(tx: _tx!);
    return res;
  }

  Future<List<TxOut>> output() async {
    final res = await loaderApi.outputStaticMethodApi(tx: _tx!);
    return res;
  }

  @override
  String toString() {
    return _tx!;
  }
}

///A transaction builder
///
/// A TxBuilder is created by calling TxBuilder or BumpFeeTxBuilder on a wallet.
/// After assigning it, you set options on it until finally calling finish to consume the builder and generate the transaction.
class TxBuilder {
  final List<ScriptAmount> _recipients = [];
  final List<OutPoint> _utxos = [];
  final List<OutPoint> _unSpendable = [];
  bool _manuallySelectedOnly = false;
  double? _feeRate;
  ChangeSpendPolicy _changeSpendPolicy = ChangeSpendPolicy.ChangeAllowed;
  int? _feeAbsolute;
  bool _drainWallet = false;
  Script? _drainTo;
  RbfValue? _rbfValue;
  typed_data.Uint8List _data = typed_data.Uint8List.fromList([]);

  ///Add data as an output, using OP_RETURN
  TxBuilder addData({required List<int> data}) {
    if (data.isEmpty) {
      throw const BdkException.unExpected("List must not be empty");
    }
    _data = typed_data.Uint8List.fromList(data);
    return this;
  }

  ///Add a recipient to the internal list
  TxBuilder addRecipient(Script script, int amount) {
    _recipients.add(ScriptAmount(script: script, amount: amount));
    return this;
  }

  ///Add a utxo to the internal list of unspendable utxos
  ///
  /// It’s important to note that the “must-be-spent” utxos added with TxBuilder().addUtxo have priority over this.
  /// See the docs of the two linked methods for more details.
  TxBuilder unSpendable(List<OutPoint> outpoints) {
    for (var e in outpoints) {
      _unSpendable.add(e);
    }
    return this;
  }

  ///Add a utxo to the internal list of utxos that must be spent
  ///
  /// These have priority over the “unspendable” utxos, meaning that if a utxo is present both in the “utxos” and the “unspendable” list, it will be spent.
  TxBuilder addUtxo(OutPoint outpoint) {
    _utxos.add(outpoint);
    return this;
  }

  ///Add the list of outpoints to the internal list of UTXOs that must be spent.
  ///
  ///If an error occurs while adding any of the UTXOs then none of them are added and the error is returned.
  ///
  /// These have priority over the “unspendable” utxos, meaning that if a utxo is present both in the “utxos” and the “unspendable” list, it will be spent.
  TxBuilder addUtxos(List<OutPoint> outpoints) {
    for (var e in outpoints) {
      _utxos.add(e);
    }
    return this;
  }

  ///Do not spend change outputs
  ///
  /// This effectively adds all the change outputs to the “unspendable” list. See TxBuilder().addUtxos
  TxBuilder doNotSpendChange() {
    _changeSpendPolicy = ChangeSpendPolicy.ChangeForbidden;
    return this;
  }

  ///Spend all the available inputs. This respects filters like TxBuilder().unSpendable and the change policy.
  TxBuilder drainWallet() {
    _drainWallet = true;
    return this;
  }

  ///Sets the address to drain excess coins to.
  ///
  /// Usually, when there are excess coins they are sent to a change address generated by the wallet.
  /// This option replaces the usual change address with an arbitrary scriptPubkey of your choosing.
  /// Just as with a change output, if the drain output is not needed (the excess coins are too small) it will not be included in the resulting transaction. T
  /// he only difference is that it is valid to use drainTo without setting any ordinary recipients with add_recipient (but it is perfectly fine to add recipients as well).
  ///
  /// If you choose not to set any recipients, you should either provide the utxos that the transaction should spend via add_utxos, or set drainWallet to spend all of them.
  ///
  /// When bumping the fees of a transaction made with this option, you probably want to use allowShrinking to allow this output to be reduced to pay for the extra fees.
  TxBuilder drainTo(Script script) {
    _drainTo = script;
    return this;
  }

  ///Enable signaling RBF with a specific nSequence value
  ///
  /// This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.
  ///
  ///If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.
  TxBuilder enableRbfWithSequence(int nSequence) {
    _rbfValue = RbfValue.value(nSequence);
    return this;
  }

  ///Enable signaling RBF
  ///
  /// This will use the default nSequence value of 0xFFFFFFFD.
  TxBuilder enableRbf() {
    _rbfValue = RbfValue.rbfDefault();
    return this;
  }

  ///Set an absolute fee
  TxBuilder feeAbsolute(int feeAmount) {
    _feeAbsolute = feeAmount;
    return this;
  }

  ///Set a custom fee rate
  TxBuilder feeRate(double satPerVbyte) {
    _feeRate = satPerVbyte;
    return this;
  }

  ///Replace the recipients already added with a new list
  TxBuilder setRecipients(List<ScriptAmount> recipients) {
    for (var e in _recipients) {
      _recipients.add(e);
    }
    return this;
  }

  ///Only spend utxos added by add_utxo.
  ///
  /// The wallet will not add additional utxos to the transaction even if they are needed to make the transaction valid.
  TxBuilder manuallySelectedOnly() {
    _manuallySelectedOnly = true;
    return this;
  }

  ///Add a utxo to the internal list of unspendable utxos
  ///
  /// It’s important to note that the “must-be-spent” utxos added with TxBuilder().addUtxo
  /// have priority over this. See the docs of the two linked methods for more details.
  TxBuilder addUnSpendable(OutPoint unSpendable) {
    _unSpendable.add(unSpendable);
    return this;
  }

  ///Only spend change outputs
  ///
  /// This effectively adds all the non-change outputs to the “unspendable” list.
  TxBuilder onlySpendChange() {
    _changeSpendPolicy = ChangeSpendPolicy.OnlyChange;
    return this;
  }

  ///Finish building the transaction.
  ///
  /// Returns a [TxBuilderResult].

  Future<TxBuilderResult> finish(Wallet wallet) async {
    if (_recipients.isEmpty && _drainTo == null) {
      throw const BdkException.unExpected("No Recipients Added");
    }
    try {
      final res = await loaderApi.txBuilderFinishStaticMethodApi(
          wallet: wallet._wallet!,
          recipients: _recipients,
          utxos: _utxos,
          unspendable: _unSpendable,
          manuallySelectedOnly: _manuallySelectedOnly,
          drainWallet: _drainWallet,
          rbf: _rbfValue,
          drainTo: _drainTo,
          feeAbsolute: _feeAbsolute,
          feeRate: _feeRate,
          data: _data,
          changePolicy: _changeSpendPolicy);

      return TxBuilderResult(
          psbt: PartiallySignedTransaction(psbtBase64: res.field0),
          txDetails: res.field1);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }
}

///The value returned from calling the .finish() method on the [TxBuilder] or [BumpFeeTxBuilder].
class TxBuilderResult {
  final PartiallySignedTransaction psbt;

  ///The transaction details.
  ///
  final TransactionDetails txDetails;

  TxBuilderResult({required this.psbt, required this.txDetails});
}

/// A Bitcoin wallet.
///
/// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
///
///     1. Output descriptors from which it can derive addresses.
///
///     2. A Database where it tracks transactions and utxos related to the descriptors.
///
///     3. Signers that can contribute signatures to addresses instantiated from the descriptors.
///
class Wallet {
  WalletInstance? _wallet;
  Wallet._();
  Wallet _setWallet(WalletInstance? walletInstance) {
    _wallet = walletInstance;
    return this;
  }

  ///  [Wallet] constructor
  static Future<Wallet> create({
    required Descriptor descriptor,
    Descriptor? changeDescriptor,
    required Network network,
    required DatabaseConfig databaseConfig,
  }) async {
    try {
      final res = await loaderApi.createWalletStaticMethodApi(
        descriptor: descriptor._descriptorInstance!,
        changeDescriptor: changeDescriptor?._descriptorInstance,
        network: network,
        databaseConfig: databaseConfig,
      );
      return Wallet._()._setWallet(res);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return a derived address using the external descriptor, see [AddressIndex] for available address index selection strategies.
  /// If none of the keys in the descriptor are derivable (i.e. does not end with /*) then the same address will always be returned for any AddressIndex.
  Future<AddressInfo> getAddress({required AddressIndex addressIndex}) async {
    try {
      var res = await loaderApi.getAddressStaticMethodApi(
          wallet: _wallet!, addressIndex: addressIndex);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  /// Return a derived address using the internal (change) descriptor.
  ///
  /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
  ///
  /// see [AddressIndex] for available address index selection strategies. If none of the keys
  /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
  /// be returned for any [AddressIndex].
  Future<AddressInfo> getInternalAddress(
      {required AddressIndex addressIndex}) async {
    try {
      var res = await loaderApi.getInternalAddressStaticMethodApi(
          wallet: _wallet!, addressIndex: addressIndex);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return the [Balance], separated into available, trusted-pending, untrusted-pending and immature values.
  ///
  ///Note that this method only operates on the internal database, which first needs to be Wallet().sync manually.
  Future<Balance> getBalance() async {
    try {
      var res = await loaderApi.getBalanceStaticMethodApi(wallet: _wallet!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Get the Bitcoin network the wallet is using.
  Future<Network> network() async {
    try {
      var res = await loaderApi.walletNetworkStaticMethodApi(wallet: _wallet!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return the list of unspent outputs of this wallet
  ///
  /// Note that this method only operates on the internal database, which first needs to be Wallet().sync manually.
  Future<List<LocalUtxo>> listUnspent() async {
    try {
      var res =
          await loaderApi.listUnspentOutputsStaticMethodApi(wallet: _wallet!);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Sync the internal database with the [Blockchain]
  Future sync(Blockchain blockchain) async {
    try {
      await loaderApi.syncWalletStaticMethodApi(
          wallet: _wallet!, blockchain: blockchain._blockchain!);
      if (kDebugMode) {
        print("Sync complete");
      }
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Return an unsorted list of transactions made and received by the wallet
  Future<List<TransactionDetails>> listTransactions(bool includeRaw) async {
    try {
      final res = await loaderApi.getTransactionsStaticMethodApi(
          wallet: _wallet!, includeRaw: includeRaw);
      return res;
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }

  ///Sign a transaction with all the wallet’s signers, in the order specified by every signer’s SignerOrdering
  ///
  /// Note that it can’t be guaranteed that every signers will follow the options, but the “software signers” (WIF keys and xprv) defined in this library will.
  Future<PartiallySignedTransaction> sign(
      {required PartiallySignedTransaction psbt,
      SignOptions? signOptions}) async {
    try {
      final sbt = await loaderApi.signStaticMethodApi(
          signOptions: signOptions, psbtStr: psbt.psbtBase64, wallet: _wallet!);
      if (sbt == null) {
        throw const BdkException.unExpected("Unable to sign transaction");
      }
      return PartiallySignedTransaction(psbtBase64: sbt);
    } on FfiException catch (e) {
      throw configException(e.message);
    }
  }
}
