import 'dart:typed_data';
import 'package:bdk_flutter/src/utils/utils.dart';

import 'generated/api/blockchain.dart';
import 'generated/api/descriptor.dart';
import 'generated/api/error.dart';
import 'generated/api/key.dart';
import 'generated/api/psbt.dart';
import 'generated/api/types.dart' as types;
import 'generated/api/wallet.dart';

///A Bitcoin address.
class Address extends types.BdkAddress {
  Address._({required super.ptr});

  ///  [Address] constructor
  static Future<Address> fromScript({
    required ScriptBuf script,
    required types.Network network,
  }) async {
    try {
      await Api.initialize();
      return Address._(
        ptr: types.BdkAddress.fromScript(script: script, network: network).ptr,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///  [Address] constructor
  static Future<Address> fromString({
    required String s,
    required types.Network network,
  }) async {
    try {
      await Api.initialize();
      return Address._(
        ptr: types.BdkAddress.fromString(address: s, network: network).ptr,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Generates a script pubkey spending to this address
  ScriptBuf scriptPubkey() {
    try {
      return ScriptBuf(bytes: types.BdkAddress.script(ptr: this).bytes);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  //Creates a URI string bitcoin:address optimized to be encoded in QR codes.
  /// If the address is bech32, both the schema and the address become uppercase. If the address is base58, the schema is lowercase and the address is left mixed case.
  /// Quoting BIP 173 "inside QR codes uppercase SHOULD be used, as those permit the use of alphanumeric mode, which is 45% more compact than the normal byte mode."
  /// Note however that despite BIP21 explicitly stating that the bitcoin: prefix should be parsed as case-insensitive many wallets got this wrong and don't parse correctly. See compatibility table.
  /// If you want to avoid allocation you can use alternate display instead:
  @override
  String toQrUri() {
    try {
      return super.toQrUri();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Parsed addresses do not always have one network. The problem is that legacy testnet, regtest and signet addresses use the same prefix instead of multiple different ones.
  ///When parsing, such addresses are always assumed to be testnet addresses (the same is true for bech32 signet addresses).
  ///So if one wants to check if an address belongs to a certain network a simple comparison is not enough anymore. Instead this function can be used.
  @override
  bool isValidForNetwork({required types.Network network}) {
    try {
      return super.isValidForNetwork(network: network);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///The network on which this address is usable.
  @override
  types.Network network() {
    try {
      return super.network();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///The type of the address.
  @override
  types.Payload payload() {
    try {
      return super.payload();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  @override
  String toString() {
    return super.asString();
  }
}

/// Blockchain backends  module provides the implementation of a few commonly-used backends like Electrum, and Esplora.
class Blockchain extends BdkBlockchain {
  Blockchain._({required super.ptr});

  ///  [Blockchain] constructor

  static Future<Blockchain> create({required BlockchainConfig config}) async {
    try {
      await Api.initialize();
      final res = await BdkBlockchain.create(blockchainConfig: config);
      return Blockchain._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///  [Blockchain] constructor for creating `Esplora` blockchain in `Mutinynet`
  ///  Esplora url: https://mutinynet.com/api/
  static Future<Blockchain> createMutinynet({int stopGap = 20}) async {
    final config = BlockchainConfig.esplora(
      config: EsploraConfig(
        baseUrl: 'https://mutinynet.com/api/',
        stopGap: BigInt.from(stopGap),
      ),
    );
    return create(config: config);
  }

  ///  [Blockchain] constructor for creating `Esplora` blockchain in `Testnet`
  ///  Esplora url: https://testnet.ltbl.io/api
  static Future<Blockchain> createTestnet({int stopGap = 20}) async {
    final config = BlockchainConfig.esplora(
      config: EsploraConfig(
        baseUrl: 'https://testnet.ltbl.io/api',
        stopGap: BigInt.from(stopGap),
      ),
    );
    return create(config: config);
  }

  ///Estimate the fee rate required to confirm a transaction in a given target of blocks
  @override
  Future<types.FeeRate> estimateFee({required BigInt target, hint}) async {
    try {
      return await super.estimateFee(target: target);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///The function for broadcasting a transaction
  Future<String> broadcast({required Transaction transaction, hint}) async {
    try {
      return await BdkBlockchain.broadcast(ptr: this, transaction: transaction);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///The function for getting block hash by block height
  @override
  Future<String> getBlockHash({required int height, hint}) async {
    try {
      return await super.getBlockHash(height: height);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///The function for getting the current height of the blockchain.
  @override
  Future<int> getHeight({hint}) async {
    try {
      return await super.getHeight();
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
    Wallet wallet,
  ) async {
    try {
      final res = await finishBumpFeeTxBuilder(
        txid: txid.toString(),
        enableRbf: _enableRbf,
        feeRate: feeRate,
        wallet: wallet,
        nSequence: _nSequence,
        allowShrinking: _allowShrinking,
      );
      return (
        PartiallySignedTransaction._(ptr: res.$1.ptr),
        TransactionDetails._(
          transaction: res.$2.transaction,
          txid: res.$2.txid,
          received: res.$2.received,
          sent: res.$2.sent,
          fee: res.$2.fee,
          confirmationTime: res.$2.confirmationTime,
        ),
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
      return DerivationPath._(
        ptr: BdkDerivationPath.fromString(path: path).ptr,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  @override
  String toString() {
    return super.asString();
  }
}

///Script descriptor
class Descriptor extends BdkDescriptor {
  Descriptor._({required super.extendedDescriptor, required super.keyMap});

  ///  [Descriptor] constructor
  static Future<Descriptor> create({
    required String descriptor,
    required types.Network network,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.create(
        descriptor: descriptor,
        network: network,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP44 template. Expands to pkh(key/44'/{0,1}'/0'/{0,1}/*)
  ///
  /// Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip44({
    required DescriptorSecretKey secretKey,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip44(
        secretKey: secretKey,
        network: network,
        keychainKind: keychain,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP44 public template. Expands to pkh(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/44'/0'/0' for Mainnet or m/44'/1'/0' for Testnet.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip44Public({
    required DescriptorPublicKey publicKey,
    required String fingerPrint,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip44Public(
        network: network,
        keychainKind: keychain,
        publicKey: publicKey,
        fingerprint: fingerPrint,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP49 template. Expands to sh(wpkh(key/49'/{0,1}'/0'/{0,1}/*))
  ///
  ///Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip49({
    required DescriptorSecretKey secretKey,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip49(
        secretKey: secretKey,
        network: network,
        keychainKind: keychain,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP49 public template. Expands to sh(wpkh(key/{0,1}/*))
  ///
  /// This assumes that the key used has already been derived with m/49'/0'/0'.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip49Public({
    required DescriptorPublicKey publicKey,
    required String fingerPrint,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip49Public(
        network: network,
        keychainKind: keychain,
        publicKey: publicKey,
        fingerprint: fingerPrint,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP84 template. Expands to wpkh(key/84'/{0,1}'/0'/{0,1}/*)
  ///
  ///Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip84({
    required DescriptorSecretKey secretKey,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip84(
        secretKey: secretKey,
        network: network,
        keychainKind: keychain,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP84 public template. Expands to wpkh(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/84'/0'/0'.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip84Public({
    required DescriptorPublicKey publicKey,
    required String fingerPrint,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip84Public(
        network: network,
        keychainKind: keychain,
        publicKey: publicKey,
        fingerprint: fingerPrint,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP86 template. Expands to tr(key/86'/{0,1}'/0'/{0,1}/*)
  ///
  /// Since there are hardened derivation steps, this template requires a private derivable key (generally a xprv/tprv).
  static Future<Descriptor> newBip86({
    required DescriptorSecretKey secretKey,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip86(
        secretKey: secretKey,
        network: network,
        keychainKind: keychain,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///BIP86 public template. Expands to tr(key/{0,1}/*)
  ///
  /// This assumes that the key used has already been derived with m/86'/0'/0' for Mainnet or m/86'/1'/0' for Testnet.
  ///
  /// This template requires the parent fingerprint to populate correctly the metadata of PSBTs.
  static Future<Descriptor> newBip86Public({
    required DescriptorPublicKey publicKey,
    required String fingerPrint,
    required types.Network network,
    required types.KeychainKind keychain,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptor.newBip86Public(
        network: network,
        keychainKind: keychain,
        publicKey: publicKey,
        fingerprint: fingerPrint,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Return the public version of the output descriptor.
  @override
  String toString() {
    return super.asString();
  }

  ///Return the private version of the output descriptor if available, otherwise return the public version.
  @override
  String toStringPrivate({hint}) {
    try {
      return super.toStringPrivate();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Computes an upper bound on the difference between a non-satisfied TxIn's segwit_weight and a satisfied TxIn's segwit_weight
  @override
  BigInt maxSatisfactionWeight({hint}) {
    try {
      return super.maxSatisfactionWeight();
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
      final res = BdkDescriptorPublicKey.fromString(publicKey: publicKey);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
      final res = BdkDescriptorPublicKey.derive(ptr: this, path: path);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Extend the public descriptor with a custom path.
  DescriptorPublicKey extend({required DerivationPath path, hint}) {
    try {
      final res = BdkDescriptorPublicKey.extend(ptr: this, path: path);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
      throw mapBdkError(e);
    }
  }

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> create({
    required types.Network network,
    required Mnemonic mnemonic,
    String? password,
  }) async {
    try {
      await Api.initialize();
      final res = BdkDescriptorSecretKey.create(
        network: network,
        mnemonic: mnemonic,
        password: password,
      );
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Derived the XPrv using the derivation path
  DescriptorSecretKey derive(DerivationPath path) {
    try {
      final res = BdkDescriptorSecretKey.derive(ptr: this, path: path);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Extends the XPrv using the derivation path
  DescriptorSecretKey extend(DerivationPath path) {
    try {
      final res = BdkDescriptorSecretKey.extend(ptr: this, path: path);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Returns the public version of this key.
  DescriptorPublicKey toPublic() {
    try {
      final res = BdkDescriptorSecretKey.asPublic(ptr: this);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }
}

///Mnemonic phrases are a human-readable version of the private keys. Supported number of words are 12, 18, and 24.
class Mnemonic extends BdkMnemonic {
  Mnemonic._({required super.ptr});

  /// Generates [Mnemonic] with given [WordCount]
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> create(types.WordCount wordCount) async {
    try {
      await Api.initialize();
      final res = BdkMnemonic.create(wordCount: wordCount);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Create a new [Mnemonic] in the specified language from the given entropy.
  /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromEntropy(List<int> entropy) async {
    try {
      await Api.initialize();
      final res = BdkMnemonic.fromEntropy(entropy: entropy);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Parse a [Mnemonic] with given string
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromString(String mnemonic) async {
    try {
      await Api.initialize();
      final res = BdkMnemonic.fromString(mnemonic: mnemonic);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Returns Mnemonic as string
  @override
  String toString() {
    return super.asString();
  }
}

///A Partially Signed Transaction
class PartiallySignedTransaction extends BdkPsbt {
  PartiallySignedTransaction._({required super.ptr});

  /// Parse a [PartiallySignedTransaction] with given Base64 string
  ///
  /// [PartiallySignedTransaction] constructor
  static Future<PartiallySignedTransaction> fromString(
    String psbtBase64,
  ) async {
    try {
      await Api.initialize();
      final res = BdkPsbt.fromStr(psbtBase64: psbtBase64);
      return PartiallySignedTransaction._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Return fee amount
  @override
  BigInt? feeAmount({hint}) {
    try {
      return super.feeAmount();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Return fee rate
  @override
  types.FeeRate? feeRate({hint}) {
    try {
      return super.feeRate();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  @override
  String jsonSerialize({hint}) {
    try {
      return super.jsonSerialize();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  @override
  String toString() {
    return super.asString();
  }

  ///Serialize as raw binary data
  @override
  Uint8List serialize({hint}) {
    try {
      return super.serialize();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Return the transaction as bytes.
  Transaction extractTx() {
    try {
      final res = BdkPsbt.extractTx(ptr: this);
      return Transaction._(s: res.s);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Combines this [PartiallySignedTransaction] with other PSBT as described by BIP 174.
  PartiallySignedTransaction combine(PartiallySignedTransaction other) {
    try {
      final res = BdkPsbt.combine(ptr: this, other: other);
      return PartiallySignedTransaction._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Returns the [PartiallySignedTransaction]'s transaction id
  @override
  String txid({hint}) {
    try {
      return super.txid();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }
}

class Policy extends types.BdkPolicy {
  Policy._({required super.ptr});

  ///Identifier for this policy node
  @override
  String id() {
    return super.id();
  }

  @override
  String toString() {
    try {
      return super.asString();
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
    final item = super.item();
    if (item is types.SatisfiableItem_EcdsaSignature) {
      return types.SatisfiableItem.ecdsaSignature(key: item.key);
    } else if (item is types.SatisfiableItem_SchnorrSignature) {
      return types.SatisfiableItem.schnorrSignature(key: item.key);
    } else if (item is types.SatisfiableItem_Sha256Preimage) {
      return types.SatisfiableItem.sha256Preimage(hash: item.hash);
    } else if (item is types.SatisfiableItem_Hash256Preimage) {
      return types.SatisfiableItem.hash256Preimage(hash: item.hash);
    } else if (item is types.SatisfiableItem_Ripemd160Preimage) {
      return types.SatisfiableItem.ripemd160Preimage(hash: item.hash);
    } else if (item is types.SatisfiableItem_Hash160Preimage) {
      return types.SatisfiableItem.hash160Preimage(hash: item.hash);
    } else if (item is types.SatisfiableItem_AbsoluteTimelock) {
      return types.SatisfiableItem.absoluteTimelock(value: item.value);
    } else if (item is types.SatisfiableItem_RelativeTimelock) {
      return types.SatisfiableItem.relativeTimelock(value: item.value);
    } else if (item is types.SatisfiableItem_Multisig) {
      return types.SatisfiableItem.multisig(
        keys: item.keys,
        threshold: item.threshold,
      );
    } else if (item is types.SatisfiableItem_Thresh) {
      return types.SatisfiableItem.thresh(
        items: item.items.map((e) => Policy._(ptr: e.ptr)).toList(),
        threshold: item.threshold,
      );
    }

    // Should never reach here if all types are properly handled
    throw UnsupportedError(
      'Unsupported SatisfiableItem type: ${item.runtimeType}',
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
class ScriptBuf extends types.BdkScriptBuf {
  /// [ScriptBuf] constructor
  ScriptBuf({required super.bytes});

  ///Creates a new empty script.
  static Future<ScriptBuf> empty() async {
    try {
      await Api.initialize();
      return ScriptBuf(bytes: types.BdkScriptBuf.empty().bytes);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Creates a new empty script with pre-allocated capacity.
  static Future<ScriptBuf> withCapacity(BigInt capacity) async {
    try {
      await Api.initialize();
      return ScriptBuf(
        bytes: types.BdkScriptBuf.withCapacity(capacity: capacity).bytes,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Creates a ScriptBuf from a hex string.
  static Future<ScriptBuf> fromHex(String s) async {
    try {
      await Api.initialize();
      return ScriptBuf(bytes: types.BdkScriptBuf.fromHex(s: s).bytes);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  @override
  String toString() {
    return super.asString();
  }
}

///A bitcoin transaction.
class Transaction extends types.BdkTransaction {
  Transaction._({required super.s});

  ///  [Transaction] constructor
  ///  Decode an object with a well-defined format.
  // This is the method that should be implemented for a typical, fixed sized type implementing this trait.
  static Future<Transaction> fromBytes({
    required List<int> transactionBytes,
  }) async {
    try {
      await Api.initialize();
      final res = types.BdkTransaction.fromBytes(
        transactionBytes: transactionBytes,
      );
      return Transaction._(s: res.s);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  @override
  String toString() {
    return s;
  }

  ///List of transaction inputs.
  @override
  List<TxIn> input({hint}) {
    try {
      final res = super.input();
      return res
          .map(
            (e) => TxIn._(
              previousOutput: e.previousOutput,
              scriptSig: e.scriptSig,
              sequence: e.sequence,
              witness: e.witness,
            ),
          )
          .toList();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///List of transaction outputs.
  @override
  List<TxOut> output({hint}) {
    try {
      return super
          .output()
          .map((e) => TxOut._(scriptPubkey: e.scriptPubkey, value: e.value))
          .toList();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }
}

///A transaction builder
///
/// A TxBuilder is created by calling TxBuilder or BumpFeeTxBuilder on a wallet.
/// After assigning it, you set options on it until finally calling finish to consume the builder and generate the transaction.
class TxBuilder {
  final List<types.ScriptAmount> _recipients = [];
  final List<types.OutPoint> _utxos = [];
  final List<types.OutPoint> _unSpendable = [];
  (types.OutPoint, types.Input, BigInt)? _foreignUtxo;
  bool _manuallySelectedOnly = false;
  double? _feeRate;
  types.ChangeSpendPolicy _changeSpendPolicy =
      types.ChangeSpendPolicy.changeAllowed;
  BigInt? _feeAbsolute;
  bool _drainWallet = false;
  ScriptBuf? _drainTo;
  types.RbfValue? _rbfValue;
  List<int> _data = [];
  Map<String, Uint32List>? _internalPolicyPath;
  Map<String, Uint32List>? _externalPolicyPath;

  ///Add data as an output, using OP_RETURN
  TxBuilder addData({required List<int> data}) {
    _data = data;
    return this;
  }

  ///Add a recipient to the internal list
  TxBuilder addRecipient(ScriptBuf script, BigInt amount) {
    _recipients.add(types.ScriptAmount(script: script, amount: amount));
    return this;
  }

  ///Add a utxo to the internal list of unspendable utxos
  ///
  /// It's important to note that the "must-be-spent" utxos added with TxBuilder().addUtxo have priority over this.
  /// See the docs of the two linked methods for more details.
  TxBuilder unSpendable(List<types.OutPoint> outpoints) {
    for (var e in outpoints) {
      _unSpendable.add(e);
    }
    return this;
  }

  ///Add a utxo to the internal list of utxos that must be spent
  ///
  /// These have priority over the "unspendable" utxos, meaning that if a utxo is present both in the "utxos" and the "unspendable" list, it will be spent.
  TxBuilder addUtxo(types.OutPoint outpoint) {
    _utxos.add(outpoint);
    return this;
  }

  ///Add the list of outpoints to the internal list of UTXOs that must be spent.
  ///
  ///If an error occurs while adding any of the UTXOs then none of them are added and the error is returned.
  ///
  /// These have priority over the "unspendable" utxos, meaning that if a utxo is present both in the "utxos" and the "unspendable" list, it will be spent.
  TxBuilder addUtxos(List<types.OutPoint> outpoints) {
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
  /// There are several security concerns about adding foreign UTXOs that application developers should consider. First, how do you know the value of the input is correct? If a non_witness_utxo is provided in the psbt_input then this method implicitly verifies the value by checking it against the transaction. If only a witness_utxo is provided then this method doesn't verify the value but just takes it as a given – it is up to you to check that whoever sent you the input_psbt was not lying!
  ///
  /// Secondly, you must somehow provide satisfaction_weight of the input. Depending on your application it may be important that this be known precisely.If not,
  /// a malicious counterparty may fool you into putting in a value that is too low, giving the transaction a lower than expected feerate. They could also fool
  /// you into putting a value that is too high causing you to pay a fee that is too high. The party who is broadcasting the transaction can of course check the
  /// real input weight matches the expected weight prior to broadcasting.
  TxBuilder addForeignUtxo(
    types.Input psbtInput,
    types.OutPoint outPoint,
    BigInt satisfactionWeight,
  ) {
    _foreignUtxo = (outPoint, psbtInput, satisfactionWeight);
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
  TxBuilder feeRate(double satPerVbyte) {
    _feeRate = satPerVbyte;
    return this;
  }

  ///Replace the recipients already added with a new list
  TxBuilder setRecipients(List<(ScriptBuf script, BigInt amount)> recipients) {
    for (var (s, a) in recipients) {
      _recipients.add(types.ScriptAmount(amount: a, script: s));
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
  /// It's important to note that the "must-be-spent" utxos added with TxBuilder().addUtxo
  /// have priority over this. See the docs of the two linked methods for more details.
  TxBuilder addUnSpendable(types.OutPoint unSpendable) {
    _unSpendable.add(unSpendable);
    return this;
  }

  ///Set the policy path to use while creating the transaction for a given keychain.
  ///This method accepts a map where the key is the policy node id (see policy.id()) and the value is the list of the indexes of the items that are intended to be satisfied from the policy node (see SatisfiableItem.Thresh.items).
  TxBuilder policyPath(
    types.KeychainKind keychain,
    Map<String, Uint32List> path,
  ) {
    switch (keychain) {
      case types.KeychainKind.externalChain:
        _externalPolicyPath = path;
        break;
      case types.KeychainKind.internalChain:
        _internalPolicyPath = path;
        break;
    }
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
  /// Returns a [PartiallySignedTransaction] & [TransactionDetails]

  Future<(PartiallySignedTransaction, TransactionDetails)> finish(
    Wallet wallet,
  ) async {
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
        externalPolicyPath: _externalPolicyPath,
        internalPolicyPath: _internalPolicyPath,
        rbf: _rbfValue,
        drainTo: _drainTo,
        feeAbsolute: _feeAbsolute,
        feeRate: _feeRate,
        data: _data,
        changePolicy: _changeSpendPolicy,
      );

      return (
        PartiallySignedTransaction._(ptr: res.$1.ptr),
        TransactionDetails._(
          transaction: res.$2.transaction,
          txid: res.$2.txid,
          received: res.$2.received,
          sent: res.$2.sent,
          fee: res.$2.fee,
          confirmationTime: res.$2.confirmationTime,
        ),
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
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
    required types.Network network,
    required types.DatabaseConfig databaseConfig,
  }) async {
    try {
      await Api.initialize();
      final res = await BdkWallet.create(
        descriptor: descriptor,
        changeDescriptor: changeDescriptor,
        network: network,
        databaseConfig: databaseConfig,
      );
      return Wallet._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Return a derived address using the external descriptor, see AddressIndex for available address index selection
  /// strategies. If none of the keys in the descriptor are derivable (i.e. the descriptor does not end with a * character)
  /// then the same address will always be returned for any AddressIndex.
  AddressInfo getAddress({required types.AddressIndex addressIndex, hint}) {
    try {
      final res = BdkWallet.getAddress(ptr: this, addressIndex: addressIndex);
      return AddressInfo(res.$2, Address._(ptr: res.$1.ptr));
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
  /// on the internal database, which first needs to be Wallet.sync manually.
  @override
  types.Balance getBalance({hint}) {
    try {
      return super.getBalance();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Returns the descriptor used to create addresses for a particular keychain.
  Future<Descriptor> getDescriptorForKeychain({
    required types.KeychainKind keychain,
    hint,
  }) async {
    try {
      final res = BdkWallet.getDescriptorForKeychain(
        ptr: this,
        keychain: keychain,
      );
      return Descriptor._(
        extendedDescriptor: res.extendedDescriptor,
        keyMap: res.keyMap,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Return a derived address using the internal (change) descriptor.
  ///
  /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
  ///
  /// see [AddressIndex] for available address index selection strategies. If none of the keys
  /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
  /// be returned for any [AddressIndex].

  AddressInfo getInternalAddress({
    required types.AddressIndex addressIndex,
    hint,
  }) {
    try {
      final res = BdkWallet.getInternalAddress(
        ptr: this,
        addressIndex: addressIndex,
      );
      return AddressInfo(res.$2, Address._(ptr: res.$1.ptr));
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///get the corresponding PSBT Input for a LocalUtxo
  @override
  types.Input getPsbtInput({
    required types.LocalUtxo utxo,
    required bool onlyWitnessUtxo,
    types.PsbtSigHashType? sighashType,
    hint,
  }) {
    try {
      return super.getPsbtInput(
        utxo: utxo,
        onlyWitnessUtxo: onlyWitnessUtxo,
        sighashType: sighashType,
      );
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Return whether or not a script is part of this wallet (either internal or external).
  bool isMine({required ScriptBuf script}) {
    try {
      return BdkWallet.isMine(ptr: this, script: script);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
  @override
  List<TransactionDetails> listTransactions({required bool includeRaw, hint}) {
    try {
      return super
          .listTransactions(includeRaw: includeRaw)
          .map(
            (e) => TransactionDetails._(
              transaction: e.transaction,
              txid: e.txid,
              received: e.received,
              sent: e.sent,
              fee: e.fee,
              confirmationTime: e.confirmationTime,
            ),
          )
          .toList();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
  /// which first needs to be Wallet.sync manually.
  ///
  @override
  List<LocalUtxo> listUnspent({hint}) {
    try {
      return super
          .listUnspent()
          .map(
            (e) => LocalUtxo(
              outpoint: e.outpoint,
              txout: TxOut(
                value: e.txout.value,
                scriptPubkey: ScriptBuf(bytes: e.txout.scriptPubkey.bytes),
              ),
              keychain: e.keychain,
              isSpent: e.isSpent,
            ),
          )
          .toList();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Get the Bitcoin network the wallet is using.
  @override
  types.Network network({hint}) {
    try {
      return super.network();
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Sign a transaction with all the wallet's signers. This function returns an encapsulated bool that
  /// has the value true if the PSBT was finalized, or false otherwise.
  ///
  /// The [SignOptions] can be used to tweak the behavior of the software signers, and the way
  /// the transaction is finalized at the end. Note that it can't be guaranteed that *every*
  /// signers will follow the options, but the "software signers" (WIF keys and `xprv`) defined
  /// in this library will.
  bool sign({
    required PartiallySignedTransaction psbt,
    types.SignOptions? signOptions,
    hint,
  }) {
    try {
      final res = BdkWallet.sign(
        ptr: this,
        psbt: psbt,
        signOptions: signOptions,
      );
      return res;
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Sync the internal database with the blockchain.

  Future<void> sync({required Blockchain blockchain, hint}) async {
    try {
      return await BdkWallet.sync_(ptr: this, blockchain: blockchain);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  ///Return the spending policies for the wallet's descriptor
  Policy? policies(types.KeychainKind keychain) {
    try {
      final res = BdkWallet.policies(ptr: this, keychain: keychain);
      if (res == null) return null;
      return Policy._(ptr: res.ptr);
    } on BdkError catch (e) {
      throw mapBdkError(e);
    }
  }

  /// Verify a transaction against the consensus rules
  ///
  /// This function uses `bitcoinconsensus` to verify transactions by fetching the required data
  ///  from the Wallet Database or using the [`Blockchain`].
  ///
  /// Depending on the capabilities of the
  /// [Blockchain] backend, the method could fail when called with old "historical" transactions or
  /// with unconfirmed transactions that have been evicted from the backend's memory.
  /// Make sure you sync the wallet to get the optimal results.
  // Future<void> verifyTx({required Transaction tx}) async {
  //   try {
  //     await BdkWallet.verifyTx(ptr: this, tx: tx);
  //   } on BdkError catch (e) {
  //     throw mapBdkError(e);
  //   }
  // }
}

///A derived address and the index it was found at For convenience this automatically derefs to Address
class AddressInfo {
  ///Child index of this address
  final int index;

  /// Address
  final Address address;

  AddressInfo(this.index, this.address);
}

class TxIn extends types.BdkTxIn {
  TxIn({
    required super.previousOutput,
    ScriptBuf? scriptSig,
    required super.sequence,
    required super.witness,
  }) : super(scriptSig: scriptSig);
  TxIn._({
    required super.previousOutput,
    required super.scriptSig,
    required super.sequence,
    required super.witness,
  });
  @override
  ScriptBuf? get scriptSig =>
      super.scriptSig != null ? ScriptBuf(bytes: super.scriptSig!.bytes) : null;
}

///A transaction output, which defines new coins to be created from old ones.
class TxOut extends types.BdkTxOut {
  TxOut({required super.value, required ScriptBuf scriptPubkey})
    : super(scriptPubkey: scriptPubkey);

  TxOut._({required super.value, required super.scriptPubkey});
  @override
  ScriptBuf get scriptPubkey => ScriptBuf(bytes: super.scriptPubkey.bytes);
}

class TransactionDetails extends types.BdkTransactionDetails {
  TransactionDetails({
    Transaction? transaction,
    required super.txid,
    required super.received,
    required super.sent,
    super.confirmationTime,
    super.fee,
  }) : super(transaction: transaction);

  TransactionDetails._({
    required super.txid,
    required super.received,
    required super.sent,
    super.confirmationTime,
    super.fee,
    super.transaction,
  });
  @override
  Transaction? get transaction =>
      super.transaction != null ? Transaction._(s: super.transaction!.s) : null;
}

class LocalUtxo extends types.LocalUtxo {
  LocalUtxo({
    required super.outpoint,
    required TxOut txout,
    required super.keychain,
    required super.isSpent,
  }) : super(txout: txout);
  @override
  TxOut get txout =>
      TxOut._(value: super.txout.value, scriptPubkey: super.txout.scriptPubkey);
}
