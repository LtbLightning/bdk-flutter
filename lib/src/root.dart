import 'dart:async';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/generated/api/bitcoin.dart' as bitcoin;
import 'package:bdk_flutter/src/generated/api/descriptor.dart';
import 'package:bdk_flutter/src/generated/api/electrum.dart';
import 'package:bdk_flutter/src/generated/api/error.dart';
import 'package:bdk_flutter/src/generated/api/esplora.dart';
import 'package:bdk_flutter/src/generated/api/key.dart';
import 'package:bdk_flutter/src/generated/api/store.dart';
import 'package:bdk_flutter/src/generated/api/tx_builder.dart';
import 'package:bdk_flutter/src/generated/api/types.dart';
import 'package:bdk_flutter/src/generated/api/wallet.dart';
import 'package:bdk_flutter/src/utils/utils.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

///A Bitcoin address.
class Address extends bitcoin.FfiAddress {
  Address._({required super.field0});

  ///  [Address] constructor
  static Future<Address> fromScript(
      {required ScriptBuf script, required types.Network network}) async {
    try {
      await Api.initialize();
      final res =
          await bitcoin.FfiAddress.fromScript(script: script, network: network);
      return Address._(field0: res.field0);
    } on FromScriptError catch (e) {
      throw mapFromScriptError(e);
    } on PanicException catch (e) {
      throw FromScriptException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///  [Address] constructor
  static Future<Address> fromString(
      {required String s, required types.Network network}) async {
    try {
      await Api.initialize();
      final res =
          await bitcoin.FfiAddress.fromString(address: s, network: network);
      return Address._(field0: res.field0);
    } on AddressParseError catch (e) {
      throw mapAddressParseError(e);
    } on PanicException catch (e) {
      throw AddressParseException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Generates a script pubkey spending to this address
  ScriptBuf script() {
    return ScriptBuf(bytes: bitcoin.FfiAddress.script(opaque: this).bytes);
  }

  //Creates a URI string bitcoin:address optimized to be encoded in QR codes.
  /// If the address is bech32, both the schema and the address become uppercase. If the address is base58, the schema is lowercase and the address is left mixed case.
  /// Quoting BIP 173 "inside QR codes uppercase SHOULD be used, as those permit the use of alphanumeric mode, which is 45% more compact than the normal byte mode."
  /// Note however that despite BIP21 explicitly stating that the bitcoin: prefix should be parsed as case-insensitive many wallets got this wrong and don't parse correctly. See compatibility table.
  /// If you want to avoid allocation you can use alternate display instead:
  @override
  String toQrUri() {
    return super.toQrUri();
  }

  ///Parsed addresses do not always have one network. The problem is that legacy testnet, regtest and signet addresses use the same prefix instead of multiple different ones.
  ///When parsing, such addresses are always assumed to be testnet addresses (the same is true for bech32 signet addresses).
  ///So if one wants to check if an address belongs to a certain network a simple comparison is not enough anymore. Instead this function can be used.
  @override
  bool isValidForNetwork({required Network network}) {
    return super.isValidForNetwork(network: network);
  }

  @override
  String toString() {
    return super.asString();
  }
}

/// The BumpFeeTxBuilder is used to bump the fee on a transaction that has been broadcast and has its RBF flag set to true.
class BumpFeeTxBuilder {
  int? _nSequence;
  bool _enableRbf = false;
  final String txid;
  final FeeRate feeRate;

  BumpFeeTxBuilder({required this.txid, required this.feeRate});

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

  /// Finish building the transaction. Returns the  [PSBT].
  Future<PSBT> finish(Wallet wallet) async {
    try {
      final res = await finishBumpFeeTxBuilder(
          txid: txid.toString(),
          enableRbf: _enableRbf,
          feeRate: feeRate,
          wallet: wallet,
          nSequence: _nSequence);
      return PSBT._(opaque: res.opaque);
    } on CreateTxError catch (e) {
      throw mapCreateTxError(e);
    } on PanicException catch (e) {
      throw CreateTxException(code: "Unknown", errorMessage: e.message);
    }
  }
}

///A `BIP-32` derivation path
class DerivationPath extends FfiDerivationPath {
  DerivationPath._({required super.opaque});

  ///  [DerivationPath] constructor
  static Future<DerivationPath> create({required String path}) async {
    try {
      await Api.initialize();
      final res = await FfiDerivationPath.fromString(path: path);
      return DerivationPath._(opaque: res.opaque);
    } on Bip32Error catch (e) {
      throw mapBip32Error(e);
    } on PanicException catch (e) {
      throw Bip32Exception(code: "Unknown", errorMessage: e.message);
    }
  }

  @override
  String toString() {
    return super.asString();
  }
}

///Script descriptor
class Descriptor extends FfiDescriptor {
  Descriptor._({required super.extendedDescriptor, required super.keyMap});

  ///  [Descriptor] constructor
  static Future<Descriptor> create(
      {required String descriptor, required types.Network network}) async {
    try {
      await Api.initialize();
      final res = await FfiDescriptor.newInstance(
          descriptor: descriptor, network: network);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///BIP44 template. Expands to pkh(key/44'/{0,1}'/0'/{0,1}/*)
  ///
  /// Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip44(
      {required DescriptorSecretKey secretKey,
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip44(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
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
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip44Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///BIP49 template. Expands to sh(wpkh(key/49'/{0,1}'/0'/{0,1}/*))
  ///
  ///Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip49(
      {required DescriptorSecretKey secretKey,
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip49(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
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
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip49Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///BIP84 template. Expands to wpkh(key/84'/{0,1}'/0'/{0,1}/*)
  ///
  ///Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip84(
      {required DescriptorSecretKey secretKey,
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip84(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
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
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip84Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///BIP86 template. Expands to tr(key/86'/{0,1}'/0'/{0,1}/*)
  ///
  /// Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip86(
      {required DescriptorSecretKey secretKey,
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip86(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
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
      required types.Network network,
      required types.KeychainKind keychain}) async {
    try {
      await LibBdk.initialize();
      final res = FfiDescriptor.newBip86Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Return the public version of the output descriptor.
  @override
  String toString() {
    return super.asString();
  }

  ///Return the private version of the output descriptor if available, otherwise return the public version.
  @override
  String toStringWithSecret({hint}) {
    try {
      return super.toStringWithSecret();
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    }
  }

  ///Computes an upper bound on the difference between a non-satisfied TxIn's segwit_weight and a satisfied TxIn's segwit_weight
  @override
  BigInt maxSatisfactionWeight({hint}) {
    try {
      return super.maxSatisfactionWeight();
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorException(code: "Unknown", errorMessage: e.message);
    }
  }
}

///An extended public key.
class DescriptorPublicKey extends FfiDescriptorPublicKey {
  DescriptorPublicKey._({required super.opaque});

  /// [DescriptorPublicKey] constructor
  static Future<DescriptorPublicKey> fromString(String publicKey) async {
    try {
      await LibBdk.initialize();
      final res = await FfiDescriptorPublicKey.fromString(publicKey: publicKey);
      return DescriptorPublicKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Get the public key as string.
  @override
  String toString() {
    return super.asString();
  }

  ///Derive a public descriptor at a given path.
  DescriptorPublicKey derive({required DerivationPath path, hint}) {
    try {
      final res = FfiDescriptorPublicKey.derive(opaque: this, path: path);
      return DescriptorPublicKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Extend the public descriptor with a custom path.
  DescriptorPublicKey extend({required DerivationPath path, hint}) {
    try {
      final res = FfiDescriptorPublicKey.extend(opaque: this, path: path);
      return DescriptorPublicKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }
}

///Script descriptor
class DescriptorSecretKey extends FfiDescriptorSecretKey {
  DescriptorSecretKey._({required super.opaque});

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> fromString(String secretKey) async {
    try {
      await LibBdk.initialize();
      final res = await FfiDescriptorSecretKey.fromString(secretKey: secretKey);
      return DescriptorSecretKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> create(
      {required types.Network network,
      required Mnemonic mnemonic,
      String? password}) async {
    try {
      await LibBdk.initialize();
      final res = await FfiDescriptorSecretKey.create(
          network: network, mnemonic: mnemonic, password: password);
      return DescriptorSecretKey._(opaque: res.opaque);
    } on DescriptorError catch (e) {
      throw mapDescriptorError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Derived the XPrv using the derivation path
  DescriptorSecretKey derive(DerivationPath path) {
    try {
      final res = FfiDescriptorSecretKey.derive(opaque: this, path: path);
      return DescriptorSecretKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Extends the XPrv using the derivation path
  DescriptorSecretKey extend(DerivationPath path) {
    try {
      final res = FfiDescriptorSecretKey.extend(opaque: this, path: path);
      return DescriptorSecretKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Returns the public version of this key.
  DescriptorPublicKey toPublic() {
    try {
      final res = FfiDescriptorSecretKey.asPublic(opaque: this);
      return DescriptorPublicKey._(opaque: res.opaque);
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Get the private key as string.
  @override
  String toString() {
    return super.asString();
  }

  ///Get the private key as bytes.
  @override
  Uint8List secretBytes({hint}) {
    try {
      return super.secretBytes();
    } on DescriptorKeyError catch (e) {
      throw mapDescriptorKeyError(e);
    } on PanicException catch (e) {
      throw DescriptorKeyException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class EsploraClient extends FfiEsploraClient {
  EsploraClient._({required super.opaque});

  static Future<EsploraClient> create(String url) async {
    try {
      await LibBdk.initialize();
      final res = await FfiEsploraClient.newInstance(url: url);
      return EsploraClient._(opaque: res.opaque);
    } on EsploraError catch (e) {
      throw mapEsploraError(e);
    } on PanicException catch (e) {
      throw EsploraException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///  [EsploraClient] constructor for creating `Esplora` blockchain in `Mutinynet`
  ///  Esplora url: https://mutinynet.ltbl.io/api
  static Future<EsploraClient> createMutinynet() async {
    final client = await EsploraClient.create('https://mutinynet.ltbl.io/api');
    return client;
  }

  ///  [EsploraClient] constructor for creating `Esplora` blockchain in `Testnet`
  ///  Esplora url: https://testnet.ltbl.io/api
  static Future<EsploraClient> createTestnet() async {
    final client = await EsploraClient.create('https://testnet.ltbl.io/api');
    return client;
  }

  Future<void> broadcast({required Transaction transaction}) async {
    try {
      await FfiEsploraClient.broadcast(opaque: this, transaction: transaction);
      return;
    } on EsploraError catch (e) {
      throw mapEsploraError(e);
    } on PanicException catch (e) {
      throw EsploraException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<Update> fullScan({
    required FullScanRequest request,
    required BigInt stopGap,
    required BigInt parallelRequests,
  }) async {
    try {
      final res = await FfiEsploraClient.fullScan(
          opaque: this,
          request: request,
          stopGap: stopGap,
          parallelRequests: parallelRequests);
      return Update._(field0: res.field0);
    } on EsploraError catch (e) {
      throw mapEsploraError(e);
    } on PanicException catch (e) {
      throw EsploraException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<Update> sync(
      {required SyncRequest request, required BigInt parallelRequests}) async {
    try {
      final res = await FfiEsploraClient.sync_(
          opaque: this, request: request, parallelRequests: parallelRequests);
      return Update._(field0: res.field0);
    } on EsploraError catch (e) {
      throw mapEsploraError(e);
    } on PanicException catch (e) {
      throw EsploraException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class ElectrumClient extends FfiElectrumClient {
  ElectrumClient._({required super.opaque});
  static Future<ElectrumClient> create(String url) async {
    try {
      await LibBdk.initialize();
      final res = await FfiElectrumClient.newInstance(url: url);
      return ElectrumClient._(opaque: res.opaque);
    } on ElectrumError catch (e) {
      throw mapElectrumError(e);
    } on PanicException catch (e) {
      throw ElectrumException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<String> broadcast({required Transaction transaction}) async {
    try {
      return await FfiElectrumClient.broadcast(
          opaque: this, transaction: transaction);
    } on ElectrumError catch (e) {
      throw mapElectrumError(e);
    } on PanicException catch (e) {
      throw ElectrumException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<Update> fullScan({
    required FfiFullScanRequest request,
    required BigInt stopGap,
    required BigInt batchSize,
    required bool fetchPrevTxouts,
  }) async {
    try {
      final res = await FfiElectrumClient.fullScan(
        opaque: this,
        request: request,
        stopGap: stopGap,
        batchSize: batchSize,
        fetchPrevTxouts: fetchPrevTxouts,
      );
      return Update._(field0: res.field0);
    } on ElectrumError catch (e) {
      throw mapElectrumError(e);
    } on PanicException catch (e) {
      throw ElectrumException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<Update> sync({
    required SyncRequest request,
    required BigInt batchSize,
    required bool fetchPrevTxouts,
  }) async {
    try {
      final res = await FfiElectrumClient.sync_(
        opaque: this,
        request: request,
        batchSize: batchSize,
        fetchPrevTxouts: fetchPrevTxouts,
      );
      return Update._(field0: res.field0);
    } on ElectrumError catch (e) {
      throw mapElectrumError(e);
    } on PanicException catch (e) {
      throw ElectrumException(code: "Unknown", errorMessage: e.message);
    }
  }
}

///Mnemonic phrases are a human-readable version of the private keys. Supported number of words are 12, 18, and 24.
class Mnemonic extends FfiMnemonic {
  Mnemonic._({required super.opaque});

  /// Generates [Mnemonic] with given [WordCount]
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> create(types.WordCount wordCount) async {
    try {
      await LibBdk.initialize();
      final res = await FfiMnemonic.newInstance(wordCount: wordCount);
      return Mnemonic._(opaque: res.opaque);
    } on Bip39Error catch (e) {
      throw mapBip39Error(e);
    } on PanicException catch (e) {
      throw Bip39Exception(code: "Unknown", errorMessage: e.message);
    }
  }

  /// Create a new [Mnemonic] in the specified language from the given entropy.
  /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromEntropy(List<int> entropy) async {
    try {
      await LibBdk.initialize();
      final res = FfiMnemonic.fromEntropy(entropy: entropy);
      return Mnemonic._(opaque: res.opaque);
    } on Bip39Error catch (e) {
      throw mapBip39Error(e);
    } on PanicException catch (e) {
      throw Bip39Exception(code: "Unknown", errorMessage: e.message);
    }
  }

  /// Parse a [Mnemonic] with given string
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromString(String mnemonic) async {
    try {
      await LibBdk.initialize();
      final res = FfiMnemonic.fromString(mnemonic: mnemonic);
      return Mnemonic._(opaque: res.opaque);
    } on Bip39Error catch (e) {
      throw mapBip39Error(e);
    } on PanicException catch (e) {
      throw Bip39Exception(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Returns Mnemonic as string
  @override
  String toString() {
    return super.asString();
  }
}

///A Partially Signed Transaction
class PSBT extends bitcoin.FfiPsbt {
  PSBT._({required super.opaque});

  /// Parse a [PSBT] with given Base64 string
  ///
  /// [PSBT] constructor
  static Future<PSBT> fromString(String psbtBase64) async {
    try {
      await LibBdk.initialize();
      final res = await bitcoin.FfiPsbt.fromStr(psbtBase64: psbtBase64);
      return PSBT._(opaque: res.opaque);
    } on PsbtParseError catch (e) {
      throw mapPsbtParseError(e);
    } on PanicException catch (e) {
      throw PsbtException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Return fee amount
  @override
  BigInt? feeAmount({hint}) {
    return super.feeAmount();
  }

  @override
  String jsonSerialize({hint}) {
    try {
      return super.jsonSerialize();
    } on PsbtError catch (e) {
      throw mapPsbtError(e);
    } on PanicException catch (e) {
      throw PsbtException(code: "Unknown", errorMessage: e.message);
    }
  }

  @override
  String toString() {
    return super.asString();
  }

  ///Serialize as raw binary data
  @override
  Uint8List serialize({hint}) {
    return super.serialize();
  }

  ///Return the transaction as bytes.
  Transaction extractTx() {
    try {
      final res = bitcoin.FfiPsbt.extractTx(opaque: this);
      return Transaction._(opaque: res.opaque);
    } on ExtractTxError catch (e) {
      throw mapExtractTxError(e);
    } on PanicException catch (e) {
      throw ExtractTxException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///Combines this [PSBT] with other PSBT as described by BIP 174.
  Future<PSBT> combine(PSBT other) async {
    try {
      final res = await bitcoin.FfiPsbt.combine(opaque: this, other: other);
      return PSBT._(opaque: res.opaque);
    } on PsbtError catch (e) {
      throw mapPsbtError(e);
    } on PanicException catch (e) {
      throw PsbtException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class Policy extends types.FfiPolicy {
  Policy._({required super.opaque});

  ///Identifier for this policy node
  @override
  String id() {
    return super.id();
  }

  @override
  String toString() {
    try {
      return super.asString();
    } on StringParseError catch (e) {
      //TODO; Create a string parse exception
      throw Exception(e.errorMessage);
    }
  }

  ///Return whether or not a specific path in the policy tree is required to unambiguously create a transaction

  ///What this means is that for some spending policies the user should select which paths in the tree it intends to satisfy while signing, because the transaction must be created differently based on that.
  @override
  bool requiresPath() {
    return super.requiresPath();
  }

  ///Type of this policy node
  @override
  types.SatisfiableItem item() {
    return super.item().when(
          ecdsaSignature: (e) => types.SatisfiableItem.ecdsaSignature(key: e),
          schnorrSignature: (e) => types.SatisfiableItem.ecdsaSignature(key: e),
          sha256Preimage: (e) => types.SatisfiableItem.sha256Preimage(hash: e),
          hash256Preimage: (e) =>
              types.SatisfiableItem.hash256Preimage(hash: e),
          ripemd160Preimage: (e) =>
              types.SatisfiableItem.ripemd160Preimage(hash: e),
          hash160Preimage: (e) =>
              types.SatisfiableItem.hash160Preimage(hash: e),
          absoluteTimelock: (e) =>
              types.SatisfiableItem.absoluteTimelock(value: e),
          relativeTimelock: (e) =>
              types.SatisfiableItem.relativeTimelock(value: e),
          multisig: (e, f) =>
              types.SatisfiableItem.multisig(keys: e, threshold: f),
          thresh: (e, f) => types.SatisfiableItem.thresh(
              items: e.map((e) => Policy._(opaque: e.opaque)).toList(),
              threshold: f),
        );
  }

  ///How much a given PSBT already satisfies this policy node in terms of signatures
  @override
  types.Satisfaction satisfaction() {
    return super.satisfaction();
  }

  ///How the wallet's descriptor can satisfy this policy node
  @override
  types.Satisfaction contribution() {
    return super.contribution();
  }
}

///Bitcoin script.
class ScriptBuf extends bitcoin.FfiScriptBuf {
  /// [ScriptBuf] constructor
  ScriptBuf({required super.bytes});

  ///Creates a new empty script with pre-allocated capacity.
  static Future<ScriptBuf> withCapacity(BigInt capacity) async {
    await LibBdk.initialize();
    final res = await bitcoin.FfiScriptBuf.withCapacity(capacity: capacity);
    return ScriptBuf(bytes: res.bytes);
  }

  @override
  String toString() {
    return super.asString();
  }
}

///A bitcoin transaction.
class Transaction extends bitcoin.FfiTransaction {
  Transaction._({required super.opaque});

  ///  [Transaction] constructor
  ///  Decode an object with a well-defined format.
  static Future<Transaction> create({
    required int version,
    required LockTime lockTime,
    required List<TxIn> input,
    required List<TxOut> output,
  }) async {
    try {
      await LibBdk.initialize();
      final res = await bitcoin.FfiTransaction.newInstance(
          version: version, lockTime: lockTime, input: input, output: output);
      return Transaction._(opaque: res.opaque);
    } on TransactionError catch (e) {
      throw mapTransactionError(e);
    } on PanicException catch (e) {
      throw TransactionException(code: "Unknown", errorMessage: e.message);
    }
  }

  static Future<Transaction> fromBytes(List<int> transactionByte) async {
    try {
      await LibBdk.initialize();
      final res = await bitcoin.FfiTransaction.fromBytes(
          transactionBytes: transactionByte);
      return Transaction._(opaque: res.opaque);
    } on TransactionError catch (e) {
      throw mapTransactionError(e);
    } on PanicException catch (e) {
      throw TransactionException(code: "Unknown", errorMessage: e.message);
    }
  }

  ///List of transaction inputs.
  @override
  List<TxIn> input({hint}) {
    try {
      final res = super.input();
      return res
          .map((e) => TxIn(
              previousOutput: e.previousOutput,
              scriptSig: e.scriptSig,
              sequence: e.sequence,
              witness: e.witness))
          .toList();
    } on TransactionError catch (e) {
      throw mapTransactionError(e);
    }
  }

  ///List of transaction outputs.
  @override
  List<TxOut> output({hint}) {
    try {
      return super
          .output()
          .map((e) => TxOut(
              scriptPubkey: ScriptBuf(bytes: e.scriptPubkey.bytes),
              value: e.value))
          .toList();
    } on TransactionError catch (e) {
      throw mapTransactionError(e);
    }
  }
}

///A transaction builder
///
/// A TxBuilder is created by calling TxBuilder or BumpFeeTxBuilder on a wallet.
/// After assigning it, you set options on it until finally calling finish to consume the builder and generate the transaction.
class TxBuilder {
  final List<(ScriptBuf, BigInt)> _recipients = [];
  final List<OutPoint> _utxos = [];
  final List<OutPoint> _unSpendable = [];
  bool _manuallySelectedOnly = false;
  FeeRate? _feeRate;
  ChangeSpendPolicy _changeSpendPolicy = ChangeSpendPolicy.changeAllowed;
  BigInt? _feeAbsolute;
  bool _drainWallet = false;
  ScriptBuf? _drainTo;
  types.RbfValue? _rbfValue;
  List<int> _data = [];
  (Map<String, Uint64List>, KeychainKind)? _policyPath;

  ///Add data as an output, using OP_RETURN
  TxBuilder addData({required List<int> data}) {
    _data = data;
    return this;
  }

  ///Add a recipient to the internal list
  TxBuilder addRecipient(ScriptBuf script, BigInt amount) {
    _recipients.add((script, amount));
    return this;
  }

  ///Add a utxo to the internal list of unspendable utxos
  ///
  /// It's important to note that the "must-be-spent" utxos added with TxBuilder().addUtxo have priority over this.
  /// See the docs of the two linked methods for more details.
  TxBuilder unSpendable(List<bitcoin.OutPoint> outpoints) {
    for (var e in outpoints) {
      _unSpendable.add(e);
    }
    return this;
  }

  ///Add a utxo to the internal list of utxos that must be spent
  ///
  /// These have priority over the "unspendable" utxos, meaning that if a utxo is present both in the "utxos" and the "unspendable" list, it will be spent.
  TxBuilder addUtxo(bitcoin.OutPoint outpoint) {
    _utxos.add(outpoint);
    return this;
  }

  ///Add the list of outpoints to the internal list of UTXOs that must be spent.
  ///
  ///If an error occurs while adding any of the UTXOs then none of them are added and the error is returned.
  ///
  /// These have priority over the "unspendable" utxos, meaning that if a utxo is present both in the "utxos" and the "unspendable" list, it will be spent.
  TxBuilder addUtxos(List<bitcoin.OutPoint> outpoints) {
    for (var e in outpoints) {
      _utxos.add(e);
    }
    return this;
  }

  ///Do not spend change outputs
  ///
  /// This effectively adds all the change outputs to the "unspendable" list. See TxBuilder().addUtxos
  TxBuilder doNotSpendChange() {
    _changeSpendPolicy = types.ChangeSpendPolicy.changeForbidden;
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
  /// This can cause conflicts if the wallet's descriptors contain an "older" (OP_CSV) operator and the given nsequence is lower than the CSV value.
  ///
  ///If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.
  TxBuilder enableRbfWithSequence(int nSequence) {
    _rbfValue = types.RbfValue.value(nSequence);
    return this;
  }

  ///Enable signaling RBF
  ///
  /// This will use the default nSequence value of 0xFFFFFFFD.
  TxBuilder enableRbf() {
    _rbfValue = types.RbfValue.rbfDefault();
    return this;
  }

  ///Set an absolute fee
  TxBuilder feeAbsolute(BigInt feeAmount) {
    _feeAbsolute = feeAmount;
    return this;
  }

  ///Set a custom fee rate
  TxBuilder feeRate(FeeRate satPerVbyte) {
    _feeRate = satPerVbyte;
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
  /// It's important to note that the "must-be-spent" utxos added with TxBuilder().addUtxo
  /// have priority over this. See the docs of the two linked methods for more details.
  TxBuilder addUnSpendable(bitcoin.OutPoint unSpendable) {
    _unSpendable.add(unSpendable);
    return this;
  }

  /// Set the policy path to use while creating the transaction for a given keychain.
  ///
  /// This method accepts a map where the key is the policy node id (see
  /// policy.id()) and the value is the list of the indexes of
  /// the items that are intended to be satisfied from the policy node
  /// ## Example
  ///
  /// An example of when the policy path is needed is the following descriptor:
  /// `wsh(thresh(2,pk(A),sj:and_v(v:pk(B),n:older(6)),snj:and_v(v:pk(C),after(630000))))`,
  /// derived from the miniscript policy `thresh(2,pk(A),and(pk(B),older(6)),and(pk(C),after(630000)))`.
  /// It declares three descriptor fragments, and at the top level it uses `thresh()` to
  /// ensure that at least two of them are satisfied. The individual fragments are:
  ///
  /// 1. `pk(A)`
  /// 2. `and(pk(B),older(6))`
  /// 3. `and(pk(C),after(630000))`
  ///
  /// When those conditions are combined in pairs, it's clear that the transaction needs to be created
  /// differently depending on how the user intends to satisfy the policy afterwards:
  ///
  /// * If fragments `1` and `2` are used, the transaction will need to use a specific
  ///   `n_sequence` in order to spend an `OP_CSV` branch.
  /// * If fragments `1` and `3` are used, the transaction will need to use a specific `locktime`
  ///   in order to spend an `OP_CLTV` branch.
  /// * If fragments `2` and `3` are used, the transaction will need both.
  ///
  /// When the spending policy is represented as a tree every node
  /// is assigned a unique identifier that can be used in the policy path to specify which of
  /// the node's children the user intends to satisfy: for instance, assuming the `thresh()`
  /// root node of this example has an id of `aabbccdd`, the policy path map would look like:
  ///
  /// `{ "aabbccdd" => [0, 1] }`
  ///
  /// where the key is the node's id, and the value is a list of the children that should be
  /// used, in no particular order.
  ///
  /// If a particularly complex descriptor has multiple ambiguous thresholds in its structure,
  /// multiple entries can be added to the map, one for each node that requires an explicit path.
  TxBuilder policyPath(
      KeychainKind keychain, Map<String, List<BigInt>> policies) {
    _policyPath = (
      policies.map((key, value) =>
          MapEntry(key, Uint64List.fromList(value.cast<int>()))),
      keychain
    );
    return this;
  }

  ///Only spend change outputs
  ///
  /// This effectively adds all the non-change outputs to the "unspendable" list.
  TxBuilder onlySpendChange() {
    _changeSpendPolicy = types.ChangeSpendPolicy.onlyChange;
    return this;
  }

  ///Finish building the transaction.
  ///
  /// Returns a [PSBT] & [TransactionDetails]

  Future<PSBT> finish(Wallet wallet) async {
    try {
      final res = await txBuilderFinish(
          wallet: wallet,
          policyPath: _policyPath,
          recipients: _recipients,
          utxos: _utxos,
          unSpendable: _unSpendable,
          manuallySelectedOnly: _manuallySelectedOnly,
          drainWallet: _drainWallet,
          rbf: _rbfValue,
          drainTo: _drainTo,
          feeAbsolute: _feeAbsolute,
          feeRate: _feeRate,
          data: _data,
          changePolicy: _changeSpendPolicy);

      return PSBT._(opaque: res.opaque);
    } on CreateTxError catch (e) {
      throw mapCreateTxError(e);
    } on PanicException catch (e) {
      throw CreateTxException(code: "Unknown", errorMessage: e.message);
    }
  }
}

/// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
///
///  1. Output descriptors from which it can derive addresses.
///  2. A Database where it tracks transactions and utxos related to the descriptors.
///  3. Signers that can contribute signatures to addresses instantiated from the descriptors.
class Wallet extends FfiWallet {
  Wallet._({required super.opaque});

  ///  [Wallet] constructor

  ///Create a wallet.
  // If you have previously created a wallet, use [Wallet.load] instead.
  static Future<Wallet> create({
    required Descriptor descriptor,
    required Descriptor changeDescriptor,
    required Network network,
    required Connection connection,
  }) async {
    try {
      await LibBdk.initialize();
      final res = await FfiWallet.newInstance(
        descriptor: descriptor,
        changeDescriptor: changeDescriptor,
        network: network,
        connection: connection,
      );
      return Wallet._(opaque: res.opaque);
    } on CreateWithPersistError catch (e) {
      throw mapCreateWithPersistError(e);
    } on PanicException catch (e) {
      throw CreateWithPersistException(
          code: "Unknown", errorMessage: e.message);
    }
  }

  static Future<Wallet> load({
    required Descriptor descriptor,
    required Descriptor changeDescriptor,
    required Connection connection,
  }) async {
    try {
      await LibBdk.initialize();
      final res = await FfiWallet.load(
        descriptor: descriptor,
        changeDescriptor: changeDescriptor,
        connection: connection,
      );
      return Wallet._(opaque: res.opaque);
    } on CreateWithPersistError catch (e) {
      throw mapCreateWithPersistError(e);
    } on PanicException catch (e) {
      throw CreateWithPersistException(
          code: "Unknown", errorMessage: e.message);
    }
  }

  /// Attempt to reveal the next address of the given `keychain`.
  ///
  /// This will increment the keychain's derivation index. If the keychain's descriptor doesn't
  /// contain a wildcard or every address is already revealed up to the maximum derivation
  /// index defined in [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki),
  /// then the last revealed address will be returned.
  AddressInfo revealNextAddress({required KeychainKind keychainKind}) {
    final res =
        FfiWallet.revealNextAddress(opaque: this, keychainKind: keychainKind);
    return AddressInfo(res.index, Address._(field0: res.address.field0));
  }

  /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
  /// on the internal database, which first needs to be Wallet.sync manually.
  @override
  Balance getBalance({hint}) {
    return super.getBalance();
  }

  /// Iterate over the transactions in the wallet.
  @override
  List<CanonicalTx> transactions() {
    final res = super.transactions();
    return res
        .map((e) => CanonicalTx._(
            transaction: e.transaction, chainPosition: e.chainPosition))
        .toList();
  }

  @override
  CanonicalTx? getTx({required String txid}) {
    final res = super.getTx(txid: txid);
    if (res == null) return null;
    return CanonicalTx._(
        transaction: res.transaction, chainPosition: res.chainPosition);
  }

  /// Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
  /// which first needs to be Wallet.sync manually.
  @override
  List<LocalOutput> listUnspent({hint}) {
    return super.listUnspent();
  }

  ///List all relevant outputs (includes both spent and unspent, confirmed and unconfirmed).
  @override
  List<LocalOutput> listOutput() {
    return super.listOutput();
  }

  ///Return the spending policies for the wallet's descriptor
  Policy? policies(KeychainKind keychainKind) {
    final res = FfiWallet.policies(opaque: this, keychainKind: keychainKind);
    if (res == null) return null;
    return Policy._(opaque: res.opaque);
  }

  /// Sign a transaction with all the wallet's signers. This function returns an encapsulated bool that
  /// has the value true if the PSBT was finalized, or false otherwise.
  ///
  /// The [SignOptions] can be used to tweak the behavior of the software signers, and the way
  /// the transaction is finalized at the end. Note that it can't be guaranteed that *every*
  /// signers will follow the options, but the "software signers" (WIF keys and `xprv`) defined
  /// in this library will.

  bool sign({required PSBT psbt, SignOptions? signOptions}) {
    try {
      final res = FfiWallet.sign(
          opaque: this,
          psbt: psbt,
          signOptions: signOptions ??
              SignOptions(
                  trustWitnessUtxo: false,
                  allowAllSighashes: false,
                  tryFinalize: true,
                  signWithTapInternalKey: true,
                  allowGrinding: true));
      return res;
    } on SignerError catch (e) {
      throw mapSignerError(e);
    } on PanicException catch (e) {
      throw SignerException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<BigInt> calculateFee({required Transaction tx}) async {
    try {
      final res = await FfiWallet.calculateFee(opaque: this, tx: tx);
      return res;
    } on CalculateFeeError catch (e) {
      throw mapCalculateFeeError(e);
    } on PanicException catch (e) {
      throw CalculateFeeException(code: "Unknown", errorMessage: e.message);
    }
  }

  Future<FeeRate> calculateFeeRate({required Transaction tx}) async {
    try {
      final res = await FfiWallet.calculateFeeRate(opaque: this, tx: tx);
      return res;
    } on CalculateFeeError catch (e) {
      throw mapCalculateFeeError(e);
    } on PanicException catch (e) {
      throw CalculateFeeException(code: "Unknown", errorMessage: e.message);
    }
  }

  @override
  Future<FullScanRequestBuilder> startFullScan() async {
    final res = await super.startFullScan();
    return FullScanRequestBuilder._(field0: res.field0);
  }

  @override
  Future<SyncRequestBuilder> startSyncWithRevealedSpks() async {
    final res = await super.startSyncWithRevealedSpks();
    return SyncRequestBuilder._(field0: res.field0);
  }

  Future<bool> persist({required Connection connection}) async {
    try {
      final res = await FfiWallet.persist(opaque: this, connection: connection);
      return res;
    } on SqliteError catch (e) {
      throw mapSqliteError(e);
    } on PanicException catch (e) {
      throw SqliteException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class SyncRequestBuilder extends FfiSyncRequestBuilder {
  SyncRequestBuilder._({required super.field0});
  @override
  Future<SyncRequestBuilder> inspectSpks(
      {required FutureOr<void> Function(ScriptBuf script, SyncProgress progress)
          inspector}) async {
    try {
      final res = await super.inspectSpks(
          inspector: (script, progress) =>
              inspector(ScriptBuf(bytes: script.bytes), progress));
      return SyncRequestBuilder._(field0: res.field0);
    } on RequestBuilderError catch (e) {
      throw mapRequestBuilderError(e);
    } on PanicException catch (e) {
      throw RequestBuilderException(code: "Unknown", errorMessage: e.message);
    }
  }

  @override
  Future<SyncRequest> build() async {
    try {
      final res = await super.build();
      return SyncRequest._(field0: res.field0);
    } on RequestBuilderError catch (e) {
      throw mapRequestBuilderError(e);
    } on PanicException catch (e) {
      throw RequestBuilderException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class SyncRequest extends FfiSyncRequest {
  SyncRequest._({required super.field0});
}

class FullScanRequestBuilder extends FfiFullScanRequestBuilder {
  FullScanRequestBuilder._({required super.field0});
  @override
  Future<FullScanRequestBuilder> inspectSpksForAllKeychains(
      {required FutureOr<void> Function(
              KeychainKind keychain, int index, ScriptBuf script)
          inspector}) async {
    try {
      await LibBdk.initialize();
      final res = await super.inspectSpksForAllKeychains(
          inspector: (keychain, index, script) =>
              inspector(keychain, index, ScriptBuf(bytes: script.bytes)));
      return FullScanRequestBuilder._(field0: res.field0);
    } on RequestBuilderError catch (e) {
      throw mapRequestBuilderError(e);
    } on PanicException catch (e) {
      throw RequestBuilderException(code: "Unknown", errorMessage: e.message);
    }
  }

  @override
  Future<FullScanRequest> build() async {
    try {
      final res = await super.build();
      return FullScanRequest._(field0: res.field0);
    } on RequestBuilderError catch (e) {
      throw mapRequestBuilderError(e);
    } on PanicException catch (e) {
      throw RequestBuilderException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class FullScanRequest extends FfiFullScanRequest {
  FullScanRequest._({required super.field0});
}

class Connection extends FfiConnection {
  Connection._({required super.field0});

  static Future<Connection> createInMemory() async {
    try {
      await LibBdk.initialize();
      final res = await FfiConnection.newInMemory();
      return Connection._(field0: res.field0);
    } on SqliteError catch (e) {
      throw mapSqliteError(e);
    } on PanicException catch (e) {
      throw SqliteException(code: "Unknown", errorMessage: e.message);
    }
  }

  static Future<Connection> create(String path) async {
    try {
      await LibBdk.initialize();
      final res = await FfiConnection.newInstance(path: path);
      return Connection._(field0: res.field0);
    } on SqliteError catch (e) {
      throw mapSqliteError(e);
    } on PanicException catch (e) {
      throw SqliteException(code: "Unknown", errorMessage: e.message);
    }
  }
}

class CanonicalTx extends FfiCanonicalTx {
  CanonicalTx._({required super.transaction, required super.chainPosition});
  @override
  Transaction get transaction {
    return Transaction._(opaque: super.transaction.opaque);
  }
}

class Update extends FfiUpdate {
  Update._({required super.opaque});
}

///A derived address and the index it was found at For convenience this automatically derefs to Address
class AddressInfo {
  ///Child index of this address
  final int index;

  /// Address
  final Address address;

  AddressInfo(this.index, this.address);
}

class TxIn extends bitcoin.TxIn {
  TxIn(
      {required super.previousOutput,
      required super.scriptSig,
      required super.sequence,
      required super.witness});
}

///A transaction output, which defines new coins to be created from old ones.
class TxOut extends bitcoin.TxOut {
  TxOut({required super.value, required ScriptBuf scriptPubkey})
      : super(scriptPubkey: scriptPubkey);
}
