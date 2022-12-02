import 'dart:typed_data' as typed_data;
import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/utils/exceptions/blockchain_exception.dart';
import 'package:bdk_flutter/src/utils/exceptions/key_exception.dart';
import 'package:bdk_flutter/src/utils/exceptions/path_exception.dart';
import 'package:bdk_flutter/src/utils/exceptions/tx_builder_exception.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exception.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'generated/bindings.dart';
import 'utils/utils.dart';

/// [Blockchain] backends  module provides the implementation of a few commonly-used backends like [Electrum], and [Esplora].
class Blockchain {
  BlockchainInstance? blockchain;
  Blockchain._();

  ///  [Blockchain] constructor
  static Future<Blockchain> create({required BlockchainConfig config}) async {
    final blockChain = Blockchain._();
    final res = await blockChain._create(config: config);
    return res;
  }

  Future<Blockchain> _create({required BlockchainConfig config}) async {
    final res = await loaderApi.blockchainInit(config: config);
    blockchain = res;
    return this;
  }

  /// The function for getting block hash by block height
  Future<String> getBlockHash(int height) async {
    try {
      var res = await loaderApi.getBlockchainHash(
          blockchainHeight: height, blockchain: blockchain!);
      return res;
    } on FfiException catch (e) {
      throw BlockchainException.unexpected(e.message);
    }
  }

  /// The function for getting the current height of the blockchain.
  Future<int> getHeight() async {
    try {
      var res =
          await loaderApi.getBlockchainHeight(blockchain: blockchain!);
      return res;
    } on FfiException catch (e) {
      throw BlockchainException.unexpected(e.message);
    }
  }

  /// The function for broadcasting a transaction
  Future<void> broadcast(PartiallySignedTransaction psbt) async {
    try {
      final txid = await loaderApi.broadcast(
          psbtStr: psbt.psbtBase64, blockchain: blockchain!);
      print(txid);
    } on FfiException catch (e) {
      throw BlockchainException.unexpected(e.message);
    }
  }
}

/// A [Bitcoin] wallet.
///
/// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
///     1. Output descriptors from which it can derive addresses.
///     2. A Database where it tracks transactions and utxos related to the descriptors.
///     3. Signers that can contribute signatures to addresses instantiated from the descriptors.
class Wallet {
  WalletInstance? wallet;
  Wallet._();

  ///  [Wallet] constructor
  static Future<Wallet> create({
    required String descriptor,
    String? changeDescriptor,
    required Network network,
    required DatabaseConfig databaseConfig,
  }) async {
    try {
      var wallet = Wallet._();
      final res = await wallet._create(
          descriptor: descriptor,
          changeDescriptor: changeDescriptor,
          network: network,
          databaseConfig: databaseConfig);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<Wallet> _create(
      {required String descriptor,
      String? changeDescriptor,
      required Network network,
      required DatabaseConfig databaseConfig}) async {
    final res = await loaderApi.walletInit(
      descriptor: descriptor,
      changeDescriptor: changeDescriptor,
      network: network,
      databaseConfig: databaseConfig,
    );
    wallet = res;
    return this;
  }

  ///Return a derived address using the external descriptor, see [AddressIndex] for available address index selection strategies.
  /// If none of the keys in the descriptor are derivable (i.e. does not end with /*) then the same address will always be returned for any AddressIndex.
  Future<AddressInfo> getAddress({required AddressIndex addressIndex}) async {
    try {
      var res = await loaderApi.getAddress(
          wallet: wallet!, addressIndex: addressIndex);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Return the balance, separated into available, trusted-pending, untrusted-pending and immature values.
  ///
  ///Note that this method only operates on the internal database, which first needs to be Wallet().sync manually.
  Future<Balance> getBalance() async {
    try {
      var res = await loaderApi.getBalance(wallet: wallet!);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Get the Bitcoin network the wallet is using.
  Future<Network> network() async {
    try {
      var res = await loaderApi.getNetwork(wallet: wallet!);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Return the list of unspent outputs of this wallet
  ///
  /// Note that this method only operates on the internal database, which first needs to be Wallet().sync manually.
  Future<List<LocalUtxo>> listUnspent() async {
    try {
      var res = await loaderApi.listUnspentOutputs(wallet: wallet!);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Sync the internal database with the blockchain
  Future sync(Blockchain blockchain) async {
    try {
      print("Syncing wallet");
      await loaderApi.syncWallet(
          wallet: wallet!, blockchain: blockchain.blockchain!);
      print("Sync complete");
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Return an unsorted list of transactions made and received by the wallet
  Future<List<TransactionDetails>> listTransactions() async {
    try {
      final res = await loaderApi.getTransactions(wallet: wallet!);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Sign a transaction with all the wallet’s signers, in the order specified by every signer’s SignerOrdering
  ///
  /// Note that it can’t be guaranteed that every signers will follow the options, but the “software signers” (WIF keys and xprv) defined in this library will.
  Future<PartiallySignedTransaction> sign(
      PartiallySignedTransaction psbt) async {
    try {
      final sbt = await loaderApi.sign(
          psbtStr: psbt.psbtBase64, wallet: wallet!, isMultiSig: false);
      if (sbt == null)
        throw const TxBuilderException.unexpected("Unable to sign transaction");
      return PartiallySignedTransaction(psbtBase64: sbt);
    } on FfiException catch (e) {
      throw TxBuilderException.unexpected(e.message);
    }
  }
}

///A Partially Signed Transaction
class PartiallySignedTransaction {
  final String psbtBase64;
  TransactionDetails? txDetails;

  PartiallySignedTransaction({required this.psbtBase64});

  /// Returns the psbt Transaction id
  Future<String> txId() async {
    final res = await loaderApi.psbtToTxid(psbtStr: psbtBase64);
    return res;
  }

  /// Return the transaction as bytes.
  Future<List<int>> extractTx() async {
    final res = await loaderApi.extractTx(psbtStr: psbtBase64);
    return res;
  }

  /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
  ///
  /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
  Future<PartiallySignedTransaction> combine(
      PartiallySignedTransaction other) async {
    final res = await loaderApi.combinePsbt(
        psbtStr: psbtBase64, other: other.psbtBase64);
    return PartiallySignedTransaction(psbtBase64: res);
  }

  /// Return txid as string
  Future<String> serialize() async {
    final res = await loaderApi.psbtToTxid(psbtStr: psbtBase64);
    return res;
  }
}

///A transaction builder
///
/// A TxBuilder is created by calling TxBuilder or BumpFeeTxBuilder on a wallet.
/// After assigning it, you set options on it until finally calling finish to consume the builder and generate the transaction.
class TxBuilder {
  List<ScriptAmount> _recipients = [];
  List<OutPoint> _utxos = [];
  bool _doNotSpendChange = false;
  List<OutPoint> _unSpendable = [];
  bool _manuallySelectedOnly = false;
  bool _onlySpendChange = false;
  double? _feeRate;
  int? _feeAbsolute;
  bool _enableRbf = false;
  bool _drainWallet = false;
  String? _drainTo;
  int? _nSequence;
  typed_data.Uint8List _data = typed_data.Uint8List.fromList([]);

  ///Add data as an output, using OP_RETURN
  TxBuilder addData({required List<int> data}) {
    if (data.isEmpty)
      throw const TxBuilderException.unexpected("List must not be empty");
    _data = typed_data.Uint8List.fromList(data);
    return this;
  }

  ///Add a recipient to the internal list
  TxBuilder addRecipient(Script script, int amount) {
    _recipients.add(ScriptAmount(script: script.toString(), amount: amount));
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
  /// This effectively adds all the change outputs to the “unspendable” list. See [TxBuilder().addUtxos]
  TxBuilder doNotSpendChange() {
    _doNotSpendChange = true;
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
  TxBuilder drainTo(String address) {
    _drainTo = address;
    return this;
  }

  ///Enable signaling RBF with a specific nSequence value
  ///
  /// This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.
  ///
  ///If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.
  TxBuilder enableRbfWithSequence(int nSequence) {
    _nSequence = nSequence;
    return this;
  }

  ///Enable signaling RBF
  ///
  /// This will use the default nSequence value of 0xFFFFFFFD.
  TxBuilder enableRbf() {
    _enableRbf = true;
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
    _onlySpendChange = true;
    return this;
  }

  ///Finish building the transaction.
  ///
  /// Returns the BIP174 “PSBT”.
  Future<PartiallySignedTransaction> finish(Wallet wallet) async {
    if (_recipients.isEmpty)
      throw const TxBuilderException.unexpected("No Recipients Added");
    try {
      final res = await loaderApi.txBuilderFinish(
          wallet: wallet.wallet!,
          recipients: _recipients,
          utxos: _utxos,
          unspendable: _unSpendable,
          manuallySelectedOnly: _manuallySelectedOnly,
          onlySpendChange: _onlySpendChange,
          doNotSpendChange: _doNotSpendChange,
          drainWallet: _drainWallet,
          nSequence: _nSequence,
          enableRbf: _enableRbf,
          drainTo: _drainTo,
          feeAbsolute: _feeAbsolute,
          feeRate: _feeRate,
          data: _data);
      final psbt = PartiallySignedTransaction(psbtBase64: res.psbt);
      return psbt;
    } on FfiException catch (e) {
      if (e.message.contains("InsufficientFunds")) {
        final msg = e.message.split("value:");
        throw TxBuilderException.insufficientBroadcastAmount(msg.last);
      } else {
        throw TxBuilderException.unexpected(e.message);
      }
    }
  }
}

/// The [BumpFeeTxBuilder] is used to bump the fee on a transaction that has been broadcast and has its RBF flag set to true.
class BumpFeeTxBuilder {
  int? _nSequence;
  String? _allowShrinking;
  bool _enableRbf = false;
  final String txid;
  final double feeRate;

  BumpFeeTxBuilder({required this.txid, required this.feeRate});

  ///Explicitly tells the wallet that it is allowed to reduce the amount of the output matching this [address] in order to bump the transaction fee. Without specifying this the wallet will attempt to find a change output to shrink instead.
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
  /// This will use the default nSequence value of 0xFFFFFFFD
  BumpFeeTxBuilder enableRbf() {
    _enableRbf = true;
    return this;
  }

  ///Enable signaling RBF with a specific nSequence value
  ///
  /// This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.
  ///
  /// If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.

  BumpFeeTxBuilder enableRbfWithSequence(int nSequence) {
    _nSequence = nSequence;
    return this;
  }

  /// Finish building the transaction. Returns the BIP174 PSBT.
  Future<PartiallySignedTransaction> finish(Wallet wallet) async {
    try {
      final res = await loaderApi.bumpFeeTxBuilderFinish(
          txid: txid.toString(),
          enableRbf: _enableRbf,
          feeRate: feeRate,
          wallet: wallet.wallet!,
          nSequence: _nSequence,
          allowShrinking: _allowShrinking);
      final psbt = PartiallySignedTransaction(psbtBase64: res);
      return psbt;
    } on FfiException catch (e) {
      if (e.message.contains("Txid")) {
        final msg = e.message.split("value:");
        throw TxBuilderException.invalidTxid(msg.last);
      } else {
        throw TxBuilderException.unexpected(e.message);
      }
    }
  }
}

///Bitcoin script.
///
/// A list of instructions in a simple, Forth-like, stack-based programming language that Bitcoin uses.
///
/// See [Bitcoin Wiki: Script](https://en.bitcoin.it/wiki/Script) for more information.
class Script {
  String? _scriptHex;
  Script._();

  Script _setScriptHex(String hex) {
    _scriptHex = hex;
    return this;
  }

  /// [Script] constructor
  static Future<Script> create(typed_data.Uint8List rawOutputScript) async {
    final script = Script._();
    final res = await script._create(rawOutputScript);
    return res;
  }

  Future<Script> _create(typed_data.Uint8List rawOutputScript) async {
    final res = await loaderApi.initScript(rawOutputScript: rawOutputScript);
    _scriptHex = res;
    return this;
  }

  @override
  String toString() {
    return _scriptHex.toString();
  }
}

///A Bitcoin address.
class Address {
  String? _address;
  Address._();

  /// Creates an instance of [Address] from address given.
  ///
  /// Throws a [WalletException] if the address is not valid
  static Future<Address> create({required String address}) async {
    final addressObj = Address._();
    final res = await addressObj._create(address: address);
    return res;
  }

  Future<Address> _create({required String address}) async {
    try {
      final res = await loaderApi.initAddress(address: address);
      _address = res;
      return this;
    } on FfiException catch (e) {
      throw WalletException.invalidAddress(e.message);
    }
  }

  /// Returns the script pub key of the [Address] object
  Future<Script> scriptPubKey() async {
    final res =
        await loaderApi.addressToScriptPubkeyHex(address: _address.toString());
    final script = Script._()._setScriptHex(res);
    return script;
  }

  @override
  String toString() {
    return _address.toString();
  }
}

///A BIP-32 derivation path
class DerivationPath {
  String? _path;
  DerivationPath._();

  ///  [DerivationPath] constructor
  static Future<DerivationPath> create({required String path}) async {
    final derivationPath = DerivationPath._();
    final res = await derivationPath._create(path: path);
    return res;
  }

  Future<DerivationPath> _create({required String path}) async {
    try {
      final res = await loaderApi.createDerivationPath(path: path);
      _path = res;
      return this;
    } on FfiException catch (e) {
      throw PathException.invalidPath(e.message);
    }
  }
}

/// Mnemonic phrases are a human-readable version of the private keys.
/// Supported number of words are 12, 18, and 24.
class Mnemonic {
  String? _mnemonic;
  Mnemonic._();

  /// Generates [Mnemonic] with given [WordCount]
  static Future<Mnemonic> create(WordCount wordCount) async {
    final mnemonic = Mnemonic._();
    final res = await mnemonic._create(wordCount);
    return res;
  }

  Future<Mnemonic> _create(WordCount wordCount) async {
    _mnemonic = await loaderApi.generateSeedFromWordCount(wordCount: wordCount);
    return this;
  }

  /// Parse a Mnemonic with given string
  static Future<Mnemonic> fromString(String mnemonic) async {
    final mnemonicObj = Mnemonic._();
    final res = await mnemonicObj._fromString(mnemonic);
    return res;
  }

  Future<Mnemonic> _fromString(String mnemonic) async {
    _mnemonic = await loaderApi.generateSeedFromString(mnemonic: mnemonic);
    return this;
  }

  /// Create a new [Mnemonic] in the specified language from the given entropy.
  /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
  static Future<Mnemonic> fromEntropy(typed_data.Uint8List entropy) async {
    final mnemonicObj = Mnemonic._();
    final res = await mnemonicObj._fromEntropy(entropy);
    return res;
  }

  Future<Mnemonic> _fromEntropy(typed_data.Uint8List entropy) async {
    _mnemonic = await loaderApi.generateSeedFromEntropy(entropy: entropy);
    return this;
  }

  /// Returns [Mnemonic] as string
  String asString() {
    return _mnemonic.toString();
  }
}

class DescriptorPublicKey {
  String? _descriptorPublicKey;

  DescriptorPublicKey._();

  DescriptorPublicKey _setDescriptorPublicKey(String descriptorPublicKey) {
    _descriptorPublicKey = descriptorPublicKey;
    return this;
  }

  Future<DescriptorPublicKey> derive(DerivationPath derivationPath) async {
    try {
      final res = await loaderApi.createDescriptorPublic(
          xpub: _descriptorPublicKey,
          path: derivationPath._path.toString(),
          derive: true);
      _descriptorPublicKey = res;
      return this;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.message);
    }
  }

  Future<DescriptorPublicKey> extend(DerivationPath derivationPath) async {
    try {
      final res = await loaderApi.createDescriptorPublic(
          xpub: _descriptorPublicKey,
          path: derivationPath._path.toString(),
          derive: false);
      _descriptorPublicKey = res;
      return this;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.message);
    }
  }

  /// Get the public key as string.
  String asString() {
    return _descriptorPublicKey.toString();
  }
}

class DescriptorSecretKey {
  String? _descriptorSecretKey;
  String? _xprv;
  DescriptorSecretKey._();

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> create(
      {required Network network,
      required Mnemonic mnemonic,
      String? password}) async {
    final descriptorSecretKey = DescriptorSecretKey._();
    final res = await descriptorSecretKey._create(
        network: network, mnemonic: mnemonic, password: password);
    return res;
  }

  Future<DescriptorSecretKey> _create(
      {required Network network,
      required Mnemonic mnemonic,
      String? password}) async {
    _xprv = await loaderApi.createDescriptorSecret(
        network: network, mnemonic: mnemonic.asString(), password: password);
    return this;
  }

  /// Derived the “XPrv” using the derivation path
  Future<DescriptorSecretKey> derive(DerivationPath derivationPath) async {
    try {
      _descriptorSecretKey = await loaderApi.descriptorSecretDerive(
          xprv: _xprv.toString(), path: derivationPath._path.toString());
      return this;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  /// Extends the “XPrv” using the derivation path
  Future<DescriptorSecretKey> extend(DerivationPath derivationPath) async {
    try {
      _descriptorSecretKey = await loaderApi.descriptorSecretExtend(
          xprv: _xprv.toString(), path: derivationPath._path.toString());
      return this;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  ///Returns the public version of this key.
  ///
  /// If the key is an “XPrv”, the hardened derivation steps will be applied before converting it to a public key.
  Future<DescriptorPublicKey> asPublic() async {
    try {
      final xpub = await loaderApi.descriptorSecretAsPublic(
          xprv: _xprv, descriptorSecret: _descriptorSecretKey);
      return DescriptorPublicKey._()._setDescriptorPublicKey(xpub);
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  /// Get the private key as bytes.
  Future<List<int>> secretBytes() async {
    try {
      final res = await loaderApi.descriptorSecretAsSecretBytes(
          xprv: _xprv, descriptorSecret: _descriptorSecretKey);
      return res;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  /// Get the private key as string.
  Future<String> asString() async {
    return _descriptorSecretKey ?? _xprv.toString();
  }
}



