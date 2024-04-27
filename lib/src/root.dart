import 'dart:typed_data';

import 'package:bdk_flutter/src/utils/utils.dart';

import 'generated/api/blockchain.dart';
import 'generated/api/descriptor.dart';
import 'generated/api/error.dart';
import 'generated/api/key.dart';
import 'generated/api/psbt.dart';
import 'generated/api/types.dart';
import 'generated/api/wallet.dart';

///A Bitcoin address.
class Address extends BdkAddress {
  Address._({required super.ptr});
  static Future<Address> fromScript(
      {required ScriptBuf script, required Network network}) async {
    try {
      await Api.initialize();
      final res = await BdkAddress.fromScript(script: script, network: network);
      return Address._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  static Future<Address> fromString(
      {required String s, required Network network}) async {
    try {
      await Api.initialize();
      final res = await BdkAddress.fromString(address: s, network: network);
      return Address._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Generates a script pubkey spending to this address
  Future<ScriptBuf> scriptPubkey() async {
    try {
      final res = await BdkAddress.script(ptr: this);
      return ScriptBuf(bytes: res.bytes);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

/// Blockchain backends  module provides the implementation of a few commonly-used backends like Electrum, and Esplora.
class Blockchain extends BdkBlockchain {
  Blockchain._({required super.ptr});

  ///  [Blockchain] constructor
  static Future<Blockchain> create({required BlockchainConfig config}) async {
    try {
      await Api.initialize();
      final res = await BdkBlockchain.newInstance(blockchainConfig: config);
      return Blockchain._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Estimate the fee rate required to confirm a transaction in a given target of blocks
  @override
  Future<FeeRate> estimateFee({required int target, hint}) async {
    try {
      return super.estimateFee(target: target);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///The function for broadcasting a transaction
  @override
  Future<String> broadcast({required BdkTransaction transaction, hint}) async {
    try {
      return super.broadcast(transaction: transaction);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///The function for getting block hash by block height
  @override
  Future<String> getBlockHash({required int height, hint}) async {
    try {
      return super.getBlockHash(height: height);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///The function for getting the current height of the blockchain.
  @override
  Future<int> getHeight({hint}) {
    try {
      return super.getHeight();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

/// The BumpFeeTxBuilder is used to bump the fee on a transaction that has been broadcast and has its RBF flag set to true.
class BumpFeeTxBuilder {
  int? _nSequence;
  Address? _allowShrinking;
  bool _enableRbf = false;
  final String txid;
  final double feeRate;

  BumpFeeTxBuilder({required this.txid, required this.feeRate});

  ///Explicitly tells the wallet that it is allowed to reduce the amount of the output matching this `address` in order to bump the transaction fee. Without specifying this the wallet will attempt to find a change output to shrink instead.
  ///
  /// Note that the output may shrink to below the dust limit and therefore be removed. If it is preserved then it is currently not guaranteed to be in the same position as it was originally.
  ///
  /// Throws and exception if address can’t be found among the recipients of the transaction we are bumping.
  BumpFeeTxBuilder allowShrinking(Address address) {
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

  /// Finish building the transaction. Returns the  [PartiallySignedTransaction]& [TransactionDetails].
  Future<(PartiallySignedTransaction, TransactionDetails)> finish(
      Wallet wallet) async {
    try {
      final res = await finishBumpFeeTxBuilder(
          txid: txid.toString(),
          enableRbf: _enableRbf,
          feeRate: feeRate,
          wallet: wallet,
          nSequence: _nSequence,
          allowShrinking: _allowShrinking);
      return (PartiallySignedTransaction._(ptr: res.$1.ptr), res.$2);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///A `BIP-32` derivation path
class DerivationPath extends BdkDerivationPath {
  DerivationPath._({required super.ptr});

  ///  [DerivationPath] constructor
  static Future<DerivationPath> create({required String path}) async {
    try {
      await Api.initialize();
      final res = await BdkDerivationPath.fromString(path: path);
      return DerivationPath._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///Script descriptor
class Descriptor extends BdkDescriptor {
  Descriptor._({required super.extendedDescriptor, required super.keyMap});

  ///  [Descriptor] constructor
  static Future<Descriptor> create(
      {required String descriptor, required Network network}) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptor.newInstance(
          descriptor: descriptor, network: network);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
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
      await Api.initialize();
      final res = await BdkDescriptor.newBip44(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
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
      await Api.initialize();
      final res = await BdkDescriptor.newBip44Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
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
      await Api.initialize();
      final res = await BdkDescriptor.newBip49(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
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
      await Api.initialize();
      final res = await BdkDescriptor.newBip49Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
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
      await Api.initialize();
      final res = await BdkDescriptor.newBip84(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///BIP84 public template. Expands to wpkh(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/84'/0'/0'.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip84Public(
      {required DescriptorPublicKey publicKey,
      required String fingerPrint,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptor.newBip84Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///BIP86 template. Expands to tr(key/86'/{0,1}'/0'/{0,1}/*)
  ///
  /// Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip86(
      {required DescriptorSecretKey secretKey,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptor.newBip86(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///BIP86 public template. Expands to tr(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/86'/0'/0' for Mainnet or m/86'/1'/0' for Testnet.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip86Public(
      {required DescriptorPublicKey publicKey,
      required String fingerPrint,
      required Network network,
      required KeychainKind keychain}) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptor.newBip86Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Return the public version of the output descriptor.
  @override
  Future<String> asString({hint}) async {
    try {
      return super.asString();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Return the private version of the output descriptor if available, otherwise return the public version.
  @override
  Future<String> asStringPrivate({hint}) async {
    try {
      return super.asStringPrivate();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Computes an upper bound on the difference between a non-satisfied TxIn's segwit_weight and a satisfied TxIn's segwit_weight
  @override
  Future<int> maxSatisfactionWeight({hint}) async {
    try {
      return super.maxSatisfactionWeight();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///An extended public key.
class DescriptorPublicKey extends BdkDescriptorPublicKey {
  DescriptorPublicKey._({required super.ptr});

  /// [DescriptorPublicKey] constructor
  static Future<DescriptorPublicKey> fromString(String publicKey) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptorPublicKey.fromString(publicKey: publicKey);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Get the public key as string.
  @override
  Future<String> asString({hint}) async {
    try {
      return super.asString();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Derive a public descriptor at a given path.
  Future<DescriptorPublicKey> derive(
      {required BdkDerivationPath path, hint}) async {
    try {
      final res = await BdkDescriptorPublicKey.derive(ptr: this, path: path);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Extend the public descriptor with a custom path.
  Future<DescriptorPublicKey> extend(
      {required BdkDerivationPath path, hint}) async {
    try {
      final res = await BdkDescriptorPublicKey.extend(ptr: this, path: path);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///Script descriptor
class DescriptorSecretKey extends BdkDescriptorSecretKey {
  DescriptorSecretKey._({required super.ptr});

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> fromString(String secretKey) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptorSecretKey.fromString(secretKey: secretKey);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> create(
      {required Network network,
      required Mnemonic mnemonic,
      String? password}) async {
    try {
      await Api.initialize();
      final res = await BdkDescriptorSecretKey.create(
          network: network, mnemonic: mnemonic, password: password);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Derived the XPrv using the derivation path
  Future<DescriptorSecretKey> derive(BdkDerivationPath path) async {
    try {
      final res = await BdkDescriptorSecretKey.derive(ptr: this, path: path);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Extends the XPrv using the derivation path
  Future<DescriptorSecretKey> extend(BdkDerivationPath path) async {
    try {
      final res = await BdkDescriptorSecretKey.extend(ptr: this, path: path);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Returns the public version of this key.
  Future<DescriptorPublicKey> asPublic() async {
    try {
      final res = await BdkDescriptorSecretKey.asPublic(ptr: this);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Get the private key as string.
  @override
  Future<String> asString({hint}) {
    try {
      return super.asString();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Get the private key as bytes.
  @override
  Future<Uint8List> secretBytes({hint}) async {
    try {
      return super.secretBytes();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///Mnemonic phrases are a human-readable version of the private keys. Supported number of words are 12, 18, and 24.
class Mnemonic extends BdkMnemonic {
  Mnemonic._({required super.ptr});

  /// Generates [Mnemonic] with given [WordCount]
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> create(WordCount wordCount) async {
    try {
      await Api.initialize();
      final res = await BdkMnemonic.newInstance(wordCount: wordCount);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Create a new [Mnemonic] in the specified language from the given entropy.
  /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromEntropy(List<int> entropy) async {
    try {
      await Api.initialize();
      final res = await BdkMnemonic.fromEntropy(entropy: entropy);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Parse a [Mnemonic] with given string
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromString(String mnemonic) async {
    try {
      await Api.initialize();
      final res = await BdkMnemonic.fromString(mnemonic: mnemonic);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Returns Mnemonic as string
  @override
  Future<String> asString({hint}) async {
    try {
      return super.asString();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///A Partially Signed Transaction
class PartiallySignedTransaction extends BdkPsbt {
  PartiallySignedTransaction._({required super.ptr});

  /// Parse a [PartiallySignedTransaction] with given Base64 string
  ///
  /// [PartiallySignedTransaction] constructor
  static Future<PartiallySignedTransaction> fromString(
      String psbtBase64) async {
    try {
      await Api.initialize();
      final res = await BdkPsbt.fromStr(psbtBase64: psbtBase64);
      return PartiallySignedTransaction._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Return fee amount
  @override
  Future<int?> feeAmount({hint}) {
    try {
      return super.feeAmount();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Return fee rate
  @override
  Future<FeeRate?> feeRate({hint}) {
    try {
      return super.feeRate();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  @override
  Future<String> jsonSerialize({hint}) {
    try {
      return super.jsonSerialize();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Return psbt as string
  @override
  Future<String> serialize({hint}) {
    try {
      return super.serialize();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Return the transaction as bytes.
  Future<Transaction> extractTx() async {
    try {
      final res = await BdkPsbt.extractTx(ptr: this);
      return Transaction._(inner: res.inner);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Combines this [PartiallySignedTransaction] with other PSBT as described by BIP 174.
  Future<PartiallySignedTransaction> combine(
      PartiallySignedTransaction other) async {
    try {
      final res = await BdkPsbt.combine(ptr: this, other: other);
      return PartiallySignedTransaction._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Returns the [PartiallySignedTransaction]'s transaction id
  @override
  Future<String> txid({hint}) {
    try {
      return super.txid();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///Bitcoin script.
class ScriptBuf extends BdkScriptBuf {
  /// [ScriptBuf] constructor
  ScriptBuf({required super.bytes});

  ///Creates a new empty script.
  static Future<ScriptBuf> empty() async {
    try {
      await Api.initialize();
      final res = await BdkScriptBuf.empty();
      return ScriptBuf(bytes: res.bytes);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Creates a new empty script with pre-allocated capacity.
  static Future<ScriptBuf> withCapacity(int capacity) async {
    try {
      await Api.initialize();
      final res = await BdkScriptBuf.withCapacity(capacity: capacity);
      return ScriptBuf(bytes: res.bytes);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Creates a ScriptBuf from a hex string.
  static Future<ScriptBuf> fromHex(String s) async {
    try {
      await Api.initialize();
      final res = await BdkScriptBuf.fromHex(s: s);
      return ScriptBuf(bytes: res.bytes);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///A bitcoin transaction.
class Transaction extends BdkTransaction {
  Transaction._({required super.inner});

  ///  [Transaction] constructor
  ///  Decode an object with a well-defined format.
  // This is the method that should be implemented for a typical, fixed sized type implementing this trait.
  static Future<Transaction> fromBytes({
    required List<int> transactionBytes,
  }) async {
    try {
      await Api.initialize();
      final res =
          await BdkTransaction.fromBytes(transactionBytes: transactionBytes);
      return Transaction._(inner: res.inner);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  @override
  String toString() {
    return inner;
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
  (OutPoint, Input, int)? _foreignUtxo;
  bool _manuallySelectedOnly = false;
  double? _feeRate;
  ChangeSpendPolicy _changeSpendPolicy = ChangeSpendPolicy.changeAllowed;
  int? _feeAbsolute;
  bool _drainWallet = false;
  ScriptBuf? _drainTo;
  RbfValue? _rbfValue;
  List<int> _data = [];

  ///Add data as an output, using OP_RETURN
  TxBuilder addData({required List<int> data}) {
    _data = data;
    return this;
  }

  ///Add a recipient to the internal list
  TxBuilder addRecipient(ScriptBuf script, int amount) {
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

  ///Add a foreign UTXO i.e. a UTXO not owned by this wallet.
  ///At a minimum to add a foreign UTXO we need:
  ///
  /// outpoint: To add it to the raw transaction.
  /// psbt_input: To know the value.
  /// satisfaction_weight: To know how much weight/vbytes the input will add to the transaction for fee calculation.
  /// There are several security concerns about adding foreign UTXOs that application developers should consider. First, how do you know the value of the input is correct? If a non_witness_utxo is provided in the psbt_input then this method implicitly verifies the value by checking it against the transaction. If only a witness_utxo is provided then this method doesn’t verify the value but just takes it as a given – it is up to you to check that whoever sent you the input_psbt was not lying!
  ///
  /// Secondly, you must somehow provide satisfaction_weight of the input. Depending on your application it may be important that this be known precisely.If not,
  /// a malicious counterparty may fool you into putting in a value that is too low, giving the transaction a lower than expected feerate. They could also fool
  /// you into putting a value that is too high causing you to pay a fee that is too high. The party who is broadcasting the transaction can of course check the
  /// real input weight matches the expected weight prior to broadcasting.
  TxBuilder addForeignUtxo(
      Input psbtInput, OutPoint outPoint, int satisfactionWeight) {
    _foreignUtxo = (outPoint, psbtInput, satisfactionWeight);
    return this;
  }

  ///Do not spend change outputs
  ///
  /// This effectively adds all the change outputs to the “unspendable” list. See TxBuilder().addUtxos
  TxBuilder doNotSpendChange() {
    _changeSpendPolicy = ChangeSpendPolicy.changeForbidden;
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
  TxBuilder drainTo(ScriptBuf script) {
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
    _changeSpendPolicy = ChangeSpendPolicy.onlyChange;
    return this;
  }

  ///Finish building the transaction.
  ///
  /// Returns a [PartiallySignedTransaction] & [TransactionDetails]

  Future<(PartiallySignedTransaction, TransactionDetails)> finish(
      Wallet wallet) async {
    if (_recipients.isEmpty && _drainTo == null) {
      throw NoRecipientsException();
    }
    try {
      final res = await txBuilderFinish(
          wallet: wallet,
          recipients: _recipients,
          utxos: _utxos,
          foreignUtxo: _foreignUtxo,
          unSpendable: _unSpendable,
          manuallySelectedOnly: _manuallySelectedOnly,
          drainWallet: _drainWallet,
          rbf: _rbfValue,
          drainTo: _drainTo,
          feeAbsolute: _feeAbsolute,
          feeRate: _feeRate,
          data: _data,
          changePolicy: _changeSpendPolicy);

      return (PartiallySignedTransaction._(ptr: res.$1.ptr), res.$2);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

/// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
///
///  1. Output descriptors from which it can derive addresses.
///  2. A Database where it tracks transactions and utxos related to the descriptors.
///  3. Signers that can contribute signatures to addresses instantiated from the descriptors.
class Wallet extends BdkWallet {
  Wallet._({required super.ptr});

  ///  [Wallet] constructor

  ///Create a wallet.
  // The only way this can fail is if the descriptors passed in do not match the checksums in database.
  static Future<Wallet> create({
    required Descriptor descriptor,
    Descriptor? changeDescriptor,
    required Network network,
    required DatabaseConfig databaseConfig,
  }) async {
    try {
      await Api.initialize();
      final res = await BdkWallet.newInstance(
        descriptor: descriptor,
        changeDescriptor: changeDescriptor,
        network: network,
        databaseConfig: databaseConfig,
      );
      return Wallet._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Return a derived address using the external descriptor, see AddressIndex for available address index selection
  /// strategies. If none of the keys in the descriptor are derivable (i.e. the descriptor does not end with a * character)
  /// then the same address will always be returned for any AddressIndex.
  Future<AddressInfo> getAddress(
      {required AddressIndex addressIndex, hint}) async {
    try {
      final res =
          await BdkWallet.getAddress(ptr: this, addressIndex: addressIndex);
      return AddressInfo(res.$2, Address._(ptr: res.$1.ptr));
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
  /// on the internal database, which first needs to be Wallet.sync manually.
  @override
  Future<Balance> getBalance({hint}) {
    try {
      return super.getBalance();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///Returns the descriptor used to create addresses for a particular keychain.
  Future<Descriptor> getDescriptorForKeychain(
      {required KeychainKind keychain, hint}) async {
    try {
      final res = await BdkWallet.getDescriptorForKeychain(
          ptr: this, keychain: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      throw mapToException(e);
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
      {required AddressIndex addressIndex, hint}) async {
    try {
      final res = await BdkWallet.getInternalAddress(
          ptr: this, addressIndex: addressIndex);
      return AddressInfo(res.$2, Address._(ptr: res.$1.ptr));
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  ///get the corresponding PSBT Input for a LocalUtxo
  @override
  Future<Input> getPsbtInput(
      {required LocalUtxo utxo,
      required bool onlyWitnessUtxo,
      PsbtSigHashType? sighashType,
      hint}) async {
    try {
      return super.getPsbtInput(
          utxo: utxo,
          onlyWitnessUtxo: onlyWitnessUtxo,
          sighashType: sighashType);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Return whether or not a script is part of this wallet (either internal or external).
  @override
  Future<bool> isMine({required BdkScriptBuf script, hint}) async {
    try {
      return super.isMine(script: script);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
  @override
  Future<List<TransactionDetails>> listTransactions(
      {required bool includeRaw, hint}) async {
    try {
      return super.listTransactions(includeRaw: includeRaw);
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
  /// which first needs to be Wallet.sync manually.
  /// TODO; Update; create custom LocalUtxo
  @override
  Future<List<LocalUtxo>> listUnspent({hint}) async {
    try {
      return super.listUnspent();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Get the Bitcoin network the wallet is using.
  @override
  Future<Network> network({hint}) async {
    try {
      return super.network();
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Sign a transaction with all the wallet's signers. This function returns an encapsulated bool that
  /// has the value true if the PSBT was finalized, or false otherwise.
  ///
  /// The [SignOptions] can be used to tweak the behavior of the software signers, and the way
  /// the transaction is finalized at the end. Note that it can't be guaranteed that *every*
  /// signers will follow the options, but the "software signers" (WIF keys and `xprv`) defined
  /// in this library will.
  Future<bool> sign(
      {required PartiallySignedTransaction psbt,
      SignOptions? signOptions,
      hint}) async {
    try {
      final res = await BdkWallet.sign(ptr: this, psbt: psbt);
      return res;
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }

  /// Sync the internal database with the blockchain.

  Future<void> sync({required Blockchain blockchain, hint}) async {
    try {
      final res = await BdkWallet.sync(ptr: this, blockchain: blockchain);
      return res;
    } on BdkError catch (e) {
      throw mapToException(e);
    }
  }
}

///A derived address and the index it was found at For convenience this automatically derefs to Address
class AddressInfo {
  ///Child index of this address
  final int index;

  /// Address
  final Address address;

  AddressInfo(this.index, this.address);
}
