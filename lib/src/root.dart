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

class Blockchain {
  String? _id;

  Future<String> getBlockHash(int height) async {
    try {
      _blockchainInitializationCheck(_id);
      var res = await loaderApi.getBlockchainHash(
          blockchainHeight: height, id: _id.toString());
      return res;
    } on FfiException catch (e) {
      throw BlockchainException.unexpected(e.message);
    }
  }

  Future<int> getHeight() async {
    try {
      _blockchainInitializationCheck(_id);
      var res =
      await loaderApi.getBlockchainHeight(blockchainId: _id.toString());
      return res;
    } on FfiException catch (e) {
      throw BlockchainException.unexpected(e.message);
    }
  }

  Future<Blockchain> create({required BlockchainConfig config}) async {
    final res = await loaderApi.blockchainInit(config: config);
    _id = res;
    return this;
  }

  Future<void> broadcast(PartiallySignedBitcoinTransaction psbt) async {
    try {
      _blockchainInitializationCheck(_id);
      final txid = await loaderApi.broadcast(
          psbtStr: psbt.psbtBase64, blockchainId: _id.toString());
      print(txid);
    } on FfiException catch (e) {
      throw BlockchainException.unexpected(e.message);
    }
  }
}

class Wallet {
  String? _id;

  Future<Wallet> create({
    required String descriptor,
    String? changeDescriptor,
    required Network network,
    required DatabaseConfig databaseConfig,
  }) async {
    try {
      final res = await loaderApi.walletInit(
        descriptor: descriptor,
        changeDescriptor: changeDescriptor,
        network: network,
        databaseConfig: databaseConfig,
      );
      _id = res;
      return this;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<AddressInfo> getAddress({required AddressIndex addressIndex}) async {
    try {
      _walletInitializationCheck(_id);
      var res = await loaderApi.getAddress(
          walletId: _id.toString(), addressIndex: addressIndex);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<Balance> getBalance() async {
    try {
      _walletInitializationCheck(_id);
      var res = await loaderApi.getBalance(walletId: _id.toString());
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<Network> network() async {
    try {
      _walletInitializationCheck(_id);
      var res = await loaderApi.getNetwork(walletId: _id.toString());
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<List<LocalUtxo>> listUnspent() async {
    try {
      _walletInitializationCheck(_id);
      var res = await loaderApi.listUnspentOutputs(walletId: _id.toString());
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future sync(Blockchain blockchain) async {
    try {
      _walletInitializationCheck(_id);
      print("Syncing wallet");
      await loaderApi.syncWallet(
          walletId: _id.toString(), blockchainId: blockchain._id.toString());
      print("Sync complete");
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<List<TransactionDetails>> listTransactions() async {
    try {
      _walletInitializationCheck(_id);
      final res = await loaderApi.getTransactions(walletId: _id.toString());
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<PartiallySignedBitcoinTransaction> sign(
      PartiallySignedBitcoinTransaction psbt) async {
    try {
      _walletInitializationCheck(_id);
      final sbt = await loaderApi.sign(
          psbtStr: psbt.psbtBase64,
          walletId: _id.toString(),
          isMultiSig: false);
      if (sbt == null)
        throw const TxBuilderException.unexpected("Unable to sign transaction");
      return PartiallySignedBitcoinTransaction(psbtBase64: sbt);
    } on FfiException catch (e) {
      throw TxBuilderException.unexpected(e.message);
    }
  }
}

class PartiallySignedBitcoinTransaction {
  final String psbtBase64;
  TransactionDetails? txDetails;

  PartiallySignedBitcoinTransaction({required this.psbtBase64});

  Future<String> txId() async {
    final res = await loaderApi.psbtToTxid(psbtStr: psbtBase64);
    return res;
  }

  Future<List<int>> extractTx() async {
    final res = await loaderApi.extractTx(psbtStr: psbtBase64);
    return res;
  }

  Future<PartiallySignedBitcoinTransaction> combine(
      PartiallySignedBitcoinTransaction other) async {
    final res = await loaderApi.combinePsbt(
        psbtStr: psbtBase64, other: other.psbtBase64);
    return PartiallySignedBitcoinTransaction(psbtBase64: res);
  }

  Future<String> serialize() async {
    final res = await loaderApi.psbtToTxid(psbtStr: psbtBase64);
    return res;
  }
}

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

  TxBuilder addData({required List<int> data}) {
    if (data.isEmpty)
      throw const TxBuilderException.unexpected("List must not be empty");
    _data = typed_data.Uint8List.fromList(data);
    return this;
  }

  TxBuilder addRecipient(Script script, int amount) {
    if (script._scriptHex == null || script._scriptHex == "")
      throw const KeyException.unexpected("Script key not initialized yet");
    _recipients.add(ScriptAmount(script: script.toString(), amount: amount));
    return this;
  }

  TxBuilder unSpendable(List<OutPoint> outpoints) {
    for (var e in outpoints) {
      _unSpendable.add(e);
    }
    return this;
  }

  TxBuilder addUtxo(OutPoint outpoint) {
    _utxos.add(outpoint);
    return this;
  }

  TxBuilder addUtxos(List<OutPoint> outpoints) {
    for (var e in outpoints) {
      _utxos.add(e);
    }
    return this;
  }

  TxBuilder doNotSpendChange() {
    _doNotSpendChange = true;
    return this;
  }

  TxBuilder drainWallet() {
    _drainWallet = true;
    return this;
  }

  TxBuilder drainTo(String address) {
    _drainTo = address;
    return this;
  }

  TxBuilder enableRbfWithSequence(int nSequence) {
    _nSequence = nSequence;
    return this;
  }

  TxBuilder enableRbf() {
    _enableRbf = true;
    return this;
  }

  TxBuilder feeAbsolute(int feeAmount) {
    _feeAbsolute = feeAmount;
    return this;
  }

  TxBuilder feeRate(double satPerVbyte) {
    _feeRate = satPerVbyte;
    return this;
  }

  TxBuilder setRecipients(List<ScriptAmount> recipients) {
    for (var e in _recipients) {
      _recipients.add(e);
    }
    return this;
  }

  TxBuilder manuallySelectedOnly() {
    _manuallySelectedOnly = true;
    return this;
  }

  TxBuilder addUnSpendable(OutPoint unSpendable) {
    _unSpendable.add(unSpendable);
    return this;
  }

  TxBuilder onlySpendChange() {
    _onlySpendChange = true;
    return this;
  }

  Future<PartiallySignedBitcoinTransaction> finish(Wallet wallet) async {
    if (_recipients.isEmpty)
      throw const TxBuilderException.unexpected("No Recipients Added");
    try {
      final res = await loaderApi.txBuilderFinish(
          walletId: wallet._id.toString(),
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
      final psbt = PartiallySignedBitcoinTransaction(psbtBase64: res.psbt);
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

class BumpFeeTxBuilder {
  int? _nSequence;
  String? _allowShrinking;
  bool _enableRbf = false;
  final String txid;
  final double feeRate;

  BumpFeeTxBuilder({required this.txid, required this.feeRate});

  BumpFeeTxBuilder allowShrinking(String address) {
    _allowShrinking = address;
    return this;
  }

  BumpFeeTxBuilder enableRbfWithSequence(int nSequence) {
    _nSequence = nSequence;
    return this;
  }

  BumpFeeTxBuilder enableRbf() {
    _enableRbf = true;
    return this;
  }

  Future<PartiallySignedBitcoinTransaction> finish(Wallet wallet) async {
    try {
      final res = await loaderApi.bumpFeeTxBuilderFinish(
          txid: txid.toString(),
          enableRbf: _enableRbf,
          feeRate: feeRate,
          walletId: wallet._id.toString(),
          nSequence: _nSequence,
          allowShrinking: _allowShrinking);
      final psbt = PartiallySignedBitcoinTransaction(psbtBase64: res);
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

class Script {
  String? _scriptHex;

  Script _setScriptHex(String hex) {
    _scriptHex = hex;
    return this;
  }

  Future<Script> create(typed_data.Uint8List rawOutputScript) async {
    final res = await loaderApi.initScript(rawOutputScript: rawOutputScript);
    _scriptHex = res;
    return this;
  }

  @override
  String toString() {
    return _scriptHex.toString();
  }
}

class Address {
  String? _address;

  /// Creates an instance of [Address] from address given.
  ///
  /// Throws a [WalletException] if the address is not valid
  Future<Address> create({required String address}) async {
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
    final script = Script()._setScriptHex(res);
    return script;
  }

  @override
  String toString() {
    return _address.toString();
  }
}

class DerivationPath {
  String? _path;

  Future<DerivationPath> create({required String path}) async {
    try {
      final res = await loaderApi.createDerivationPath(path: path);
      _path = res;
      return this;
    } on FfiException catch (e) {
      throw PathException.invalidPath(e.message);
    }
  }
}

class Mnemonic{
  String? _mnemonic;
  Future<Mnemonic> create(WordCount wordCount) async{
    _mnemonic = await loaderApi.generateSeedFromWordCount(wordCount: wordCount);
    return this;
  }

  Future<Mnemonic> fromString(String mnemonic) async{
    _mnemonic = await loaderApi.generateSeedFromString(mnemonic: mnemonic);
    return this;
  }
  Future<Mnemonic> fromEntropy(typed_data.Uint8List entropy) async{
    _mnemonic = await loaderApi.generateSeedFromEntropy(entropy: entropy);
    return this;
  }
  String asString(){
    return  _mnemonic.toString();
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

  String asString() {
    return _descriptorPublicKey.toString();
  }
}

class DescriptorSecretKey {
  final Network network;
  final Mnemonic mnemonic;
  String? password;
  String? _descriptorSecretKey;
  String? _xprv;

  DescriptorSecretKey({required this.network, required this.mnemonic, this.password});

  Future<DescriptorSecretKey> derive(DerivationPath derivationPath) async {
    try {
      if (_xprv == null) {
        _xprv = await loaderApi.createDescriptorSecret(
            network: network, mnemonic: mnemonic.asString());
        _descriptorSecretKey = await loaderApi.descriptorSecretDerive(
            xprv: _xprv.toString(), path: derivationPath._path.toString());
      } else {
        _descriptorSecretKey = await loaderApi.descriptorSecretDerive(
            xprv: _xprv.toString(), path: derivationPath._path.toString());
      }
      return this;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  Future<DescriptorSecretKey> extend(DerivationPath derivationPath) async {
    try {
      if (_xprv == null) {
        _xprv = await loaderApi.createDescriptorSecret(
            network: network, mnemonic: mnemonic.asString());
        _descriptorSecretKey = await loaderApi.descriptorSecretExtend(
            xprv: _xprv.toString(), path: derivationPath._path.toString());
      } else {
        _descriptorSecretKey = await loaderApi.descriptorSecretExtend(
            xprv: _xprv.toString(), path: derivationPath._path.toString());
      }
      return this;
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  Future<DescriptorPublicKey> asPublic() async {
    try {
      if (_xprv == null) {
        _xprv = await loaderApi.createDescriptorSecret(
            network: network, mnemonic: mnemonic.asString());
        final xpub = await loaderApi.descriptorSecretAsPublic(
            xprv: _xprv, descriptorSecret: _descriptorSecretKey);
        return DescriptorPublicKey._()._setDescriptorPublicKey(xpub);
      } else {
        final xpub = await loaderApi.descriptorSecretAsPublic(
            xprv: _xprv, descriptorSecret: _descriptorSecretKey);
        return DescriptorPublicKey._()._setDescriptorPublicKey(xpub);
      }
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  Future<List<int>> secretBytes() async {
    try {
      if (_xprv == null) {
        _xprv = await loaderApi.createDescriptorSecret(
            network: network, mnemonic: mnemonic.asString());
        final res = await loaderApi.descriptorSecretAsSecretBytes(
            xprv: _xprv, descriptorSecret: _descriptorSecretKey);
        return res;
      } else {
        final res = await loaderApi.descriptorSecretAsSecretBytes(
            xprv: _xprv, descriptorSecret: _descriptorSecretKey);
        return res;
      }
    } on FfiException catch (e) {
      throw KeyException.unexpected(e.toString());
    }
  }

  Future<String> asString() async {
    if (_descriptorSecretKey != null) {
      return _descriptorSecretKey.toString();
    } else {
      final res = await loaderApi.createDescriptorSecret(
          network: network, mnemonic: mnemonic.asString());
      _xprv = res;
      return res;
    }
  }
}


bool _isValidMnemonic(String mnemonic) {
  var strLen = mnemonic.split(' ').length;
  return ((strLen >= 12) && (strLen <= 24) && strLen % 6 == 0);
}

_walletInitializationCheck(String? id) {
  if (id == null)
    throw const WalletException.unexpected("Wallet not initialized");
}

_blockchainInitializationCheck(String? id) {
  if (id == null)
    throw const BlockchainException.unexpected("Blockchain not initialized");
}
