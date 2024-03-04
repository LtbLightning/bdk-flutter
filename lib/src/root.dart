import 'package:bdk_flutter/src/frb/generated/api/descriptor.dart';
import 'package:bdk_flutter/src/frb/generated/api/key.dart';
import 'package:bdk_flutter/src/frb/generated/api/types.dart';
import 'package:bdk_flutter/src/frb/generated/util/error.dart';
import 'package:bdk_flutter/src/utils/utils.dart';

class Mnemonic extends MnemonicBase {
  Mnemonic._({required super.ptr});

  /// Generates [Mnemonic] with given [WordCount]
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> create(WordCount wordCount) async {
    try {
      await Frb.verifyInit();
      final res = await MnemonicBase.newMnemonicBase(wordCount: wordCount);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      rethrow;
    }
  }

  /// Create a new [Mnemonic] in the specified language from the given entropy.
  /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromEntropy(List<int> entropy) async {
    try {
      await Frb.verifyInit();
      final res = await MnemonicBase.fromEntropy(entropy: entropy);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      rethrow;
    }
  }

  /// Parse a [Mnemonic] with given string
  ///
  /// [Mnemonic] constructor
  static Future<Mnemonic> fromString(String mnemonic) async {
    try {
      await Frb.verifyInit();
      final res = await MnemonicBase.fromString(mnemonic: mnemonic);
      return Mnemonic._(ptr: res.ptr);
    } on BdkError catch (e) {
      rethrow;
    }
  }
}

///A Bitcoin address.
class Address extends AddressBase {
  Address._({required super.field0});
  static Future<Address> fromScript(
      {required ScriptBuf script, required Network network}) async {
    await Frb.verifyInit();
    final res = await AddressBase.fromScript(script: script, network: network);
    return Address._(field0: res.field0);
  }

  static Future<Address> fromString(
      {required String s, required Network network}) async {
    await Frb.verifyInit();
    final res = await AddressBase.fromString(address: s, network: network);
    return Address._(field0: res.field0);
  }
}

class ScriptBuf extends ScriptBufBase {
  ScriptBuf({required super.bytes});

  ///Creates a new empty script.
  static Future<ScriptBuf> empty() async {
    await Frb.verifyInit();
    final res = await ScriptBufBase.empty();
    return ScriptBuf(bytes: res.bytes);
  }

  ///Creates a new empty script with pre-allocated capacity.
  static Future<ScriptBuf> withCapacity(int capacity) async {
    await Frb.verifyInit();
    final res = await ScriptBufBase.withCapacity(capacity: capacity);
    return ScriptBuf(bytes: res.bytes);
  }

  ///Creates a ScriptBuf from a hex string.
  static Future<ScriptBuf> fromHex(String s) async {
    await Frb.verifyInit();
    final res = await ScriptBufBase.fromHex(s: s);
    return ScriptBuf(bytes: res.bytes);
  }
}

///A bitcoin transaction.
class Transaction extends TransactionBase {
  Transaction._({required super.inner});

  ///  [Transaction] constructor
  static Future<Transaction> create({
    required List<int> transactionBytes,
  }) async {
    try {
      await Frb.verifyInit();
      final res = await TransactionBase.newTransactionBase(
          transactionBytes: transactionBytes);
      return Transaction._(inner: res.inner);
    } on BdkError catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    return inner;
  }
}

///A `BIP-32` derivation path
class DerivationPath extends DerivationPathBase {
  DerivationPath._({required super.ptr});

  ///  [DerivationPath] constructor
  static Future<DerivationPath> create({required String path}) async {
    try {
      await Frb.verifyInit();
      final res = await DerivationPathBase.fromString(path: path);
      return DerivationPath._(ptr: res.ptr);
    } on BdkError catch (e) {
      rethrow;
    }
  }
}

///Script descriptor
class Descriptor extends DescriptorBase {
  Descriptor._({required super.extendedDescriptor, required super.keyMap});

  ///  [Descriptor] constructor
  static Future<Descriptor> create(
      {required String descriptor, required Network network}) async {
    try {
      await Frb.verifyInit();
      final res = await DescriptorBase.newDescriptorBase(
          descriptor: descriptor, network: network);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip44(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip44Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip49(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip44Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip84(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip44Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip86(
          secretKey: secretKey, network: network, keychainKind: keychain);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
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
      await Frb.verifyInit();
      final res = await DescriptorBase.newBip44Public(
          network: network,
          keychainKind: keychain,
          publicKey: publicKey,
          fingerprint: fingerPrint);
      return Descriptor._(
          extendedDescriptor: res.extendedDescriptor, keyMap: res.keyMap);
    } on BdkError catch (e) {
      rethrow;
    }
  }
}

///An extended public key.
class DescriptorPublicKey extends DescriptorPublicKeyBase {
  DescriptorPublicKey._({required super.ptr});

  /// [DescriptorPublicKey] constructor
  static Future<DescriptorPublicKey> fromString(String publicKey) async {
    try {
      await Frb.verifyInit();
      final res =
          await DescriptorPublicKeyBase.fromString(publicKey: publicKey);
      return DescriptorPublicKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      rethrow;
    }
  }
}

class DescriptorSecretKey extends DescriptorSecretKeyBase {
  DescriptorSecretKey._({required super.ptr});

  /// [DescriptorSecretKey] constructor
  static Future<DescriptorSecretKey> create(
      {required Network network,
      required Mnemonic mnemonic,
      String? password}) async {
    try {
      await Frb.verifyInit();
      final res = await DescriptorSecretKeyBase.create(
          network: network, mnemonic: mnemonic, password: password);
      return DescriptorSecretKey._(ptr: res.ptr);
    } on BdkError catch (e) {
      rethrow;
    }
  }
}

// /// Blockchain backends  module provides the implementation of a few commonly-used backends like Electrum, and Esplora.
// class Blockchain {
//   final String _blockchain;
//   Blockchain._(this._blockchain);
//
//   ///  [Blockchain] constructor
//   static Future<Blockchain> create(
//       {required bridge.BlockchainConfig config}) async {
//     try {
//       final res = await bdkFfi.createBlockchainStaticMethodApi(config: config);
//       return Blockchain._(res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// The function for getting block hash by block height
//   Future<String> getBlockHash(int height) async {
//     try {
//       var res = await bdkFfi.getBlockchainHashStaticMethodApi(
//           blockchainHeight: height, blockchainId: _blockchain);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// The function for getting the current height of the blockchain.
//   Future<int> getHeight() async {
//     try {
//       var res =
//           await bdkFfi.getHeightStaticMethodApi(blockchainId: _blockchain);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Estimate the fee rate required to confirm a transaction in a given target of blocks
//   Future<FeeRate> estimateFee(int target) async {
//     try {
//       var res = await bdkFfi.estimateFeeStaticMethodApi(
//           blockchainId: _blockchain, target: target);
//       return FeeRate._(res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// The function for broadcasting a transaction
//   Future<void> broadcast(Transaction tx) async {
//     try {
//       final txid = await bdkFfi.broadcastStaticMethodApi(
//           blockchainId: _blockchain, tx: tx._tx!);
//       if (kDebugMode) {
//         print(txid);
//       }
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
// }
//
// /// The BumpFeeTxBuilder is used to bump the fee on a transaction that has been broadcast and has its RBF flag set to true.
// class BumpFeeTxBuilder {
//   int? _nSequence;
//   String? _allowShrinking;
//   bool _enableRbf = false;
//   final String txid;
//   final double feeRate;
//
//   BumpFeeTxBuilder({required this.txid, required this.feeRate});
//
//   ///Explicitly tells the wallet that it is allowed to reduce the amount of the output matching this `address` in order to bump the transaction fee. Without specifying this the wallet will attempt to find a change output to shrink instead.
//   ///
//   /// Note that the output may shrink to below the dust limit and therefore be removed. If it is preserved then it is currently not guaranteed to be in the same position as it was originally.
//   ///
//   /// Throws and exception if address can’t be found among the recipients of the transaction we are bumping.
//   BumpFeeTxBuilder allowShrinking(String address) {
//     _allowShrinking = address;
//     return this;
//   }
//
//   ///Enable signaling RBF
//   ///
//   /// This will use the default nSequence value of `0xFFFFFFFD`
//   BumpFeeTxBuilder enableRbf() {
//     _enableRbf = true;
//     return this;
//   }
//
//   ///Enable signaling RBF with a specific nSequence value
//   ///
//   /// This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.
//   ///
//   /// If the nsequence is higher than `0xFFFFFFFD` an error will be thrown, since it would not be a valid nSequence to signal RBF.
//
//   BumpFeeTxBuilder enableRbfWithSequence(int nSequence) {
//     _nSequence = nSequence;
//     return this;
//   }
//
//   /// Finish building the transaction. Returns the  [TxBuilderResult].
//   Future<TxBuilderResult> finish(Wallet wallet) async {
//     try {
//       final res = await bdkFfi.bumpFeeTxBuilderFinishStaticMethodApi(
//           txid: txid.toString(),
//           enableRbf: _enableRbf,
//           feeRate: feeRate,
//           walletId: wallet._wallet,
//           nSequence: _nSequence,
//           allowShrinking: _allowShrinking);
//       return TxBuilderResult(
//           psbt: PartiallySignedTransaction(psbtBase64: res.$1),
//           txDetails: res.$2);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
// }
//

// class FeeRate {
//   final double _feeRate;
//   FeeRate._(this._feeRate);
//
//   double asSatPerVb() {
//     return _feeRate;
//   }
// }
//
// /// A key-value map for an input of the corresponding index in the unsigned
// /// transaction.
// class Input {
//   final String _input;
//   Input._(this._input);
//   @override
//   String toString() {
//     return _input.toString();
//   }
//
//   static Input create(String internal) {
//     return Input._(internal);
//   }
// }
//
// /// Mnemonic phrases are a human-readable version of the private keys.
// /// Supported number of words are 12, 18, and 24.

// ///A Partially Signed Transaction
// class PartiallySignedTransaction {
//   final String psbtBase64;
//
//   PartiallySignedTransaction({required this.psbtBase64});
//
//   /// Combines this [PartiallySignedTransaction] with other PSBT as described by BIP 174.
//   ///
//   /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
//   Future<PartiallySignedTransaction> combine(
//       PartiallySignedTransaction other) async {
//     try {
//       final res = await bdkFfi.combinePsbtStaticMethodApi(
//           psbtStr: psbtBase64, other: other.psbtBase64);
//       return PartiallySignedTransaction(psbtBase64: res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Return the transaction as bytes.
//   Future<Transaction> extractTx() async {
//     try {
//       final res = await bdkFfi.extractTxStaticMethodApi(psbtStr: psbtBase64);
//       return Transaction._(res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Return feeAmount
//   Future<int?> feeAmount() async {
//     try {
//       final res =
//           await bdkFfi.psbtFeeAmountStaticMethodApi(psbtStr: psbtBase64);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Return Fee Rate
//   Future<FeeRate?> feeRate() async {
//     try {
//       final res = await bdkFfi.psbtFeeRateStaticMethodApi(psbtStr: psbtBase64);
//       if (res == null) return null;
//       return FeeRate._(res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Return txid as string
//   Future<String> serialize() async {
//     try {
//       final res =
//           await bdkFfi.serializePsbtStaticMethodApi(psbtStr: psbtBase64);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   Future<String> jsonSerialize() async {
//     try {
//       final res =
//           await bdkFfi.jsonSerializeStaticMethodApi(psbtStr: psbtBase64);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   @override
//   String toString() {
//     return psbtBase64;
//   }
//
//   /// Returns the [PartiallySignedTransaction] transaction id
//   Future<String> txId() async {
//     try {
//       final res = await bdkFfi.psbtTxidStaticMethodApi(psbtStr: psbtBase64);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
// }
//
// ///Bitcoin script.
// ///
// /// A list of instructions in a simple, Forth-like, stack-based programming language that Bitcoin uses.
// ///
// /// See [Bitcoin Wiki: Script](https://en.bitcoin.it/wiki/Script) for more information.
// class Script extends bridge.Script {
//   Script._({required super.inner});
//
//   /// [Script] constructor
//   static Future<bridge.Script> create(
//       typed_data.Uint8List rawOutputScript) async {
//     try {
//       final res = await bdkFfi.createScriptStaticMethodApi(
//           rawOutputScript: rawOutputScript);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   typed_data.Uint8List toBytes() {
//     return inner;
//   }
// }
//

// ///A transaction builder
// ///
// /// A TxBuilder is created by calling TxBuilder or BumpFeeTxBuilder on a wallet.
// /// After assigning it, you set options on it until finally calling finish to consume the builder and generate the transaction.
// class TxBuilder {
//   final List<bridge.ScriptAmount> _recipients = [];
//   final List<bridge.OutPoint> _utxos = [];
//   final List<bridge.OutPoint> _unSpendable = [];
//   (bridge.OutPoint, String, int)? _foreignUtxo;
//   bool _manuallySelectedOnly = false;
//   double? _feeRate;
//   bridge.ChangeSpendPolicy _changeSpendPolicy =
//       bridge.ChangeSpendPolicy.ChangeAllowed;
//   int? _feeAbsolute;
//   bool _drainWallet = false;
//   bridge.Script? _drainTo;
//   bridge.RbfValue? _rbfValue;
//   typed_data.Uint8List _data = typed_data.Uint8List.fromList([]);
//
//   ///Add data as an output, using OP_RETURN
//   TxBuilder addData({required List<int> data}) {
//     if (data.isEmpty) {
//       throw InvalidByteException(message: "List must not be empty");
//     }
//     _data = typed_data.Uint8List.fromList(data);
//     return this;
//   }
//
//   ///Add a recipient to the internal list
//   TxBuilder addRecipient(bridge.Script script, int amount) {
//     _recipients.add(bridge.ScriptAmount(script: script, amount: amount));
//     return this;
//   }
//
//   ///Add a utxo to the internal list of unspendable utxos
//   ///
//   /// It’s important to note that the “must-be-spent” utxos added with TxBuilder().addUtxo have priority over this.
//   /// See the docs of the two linked methods for more details.
//   TxBuilder unSpendable(List<bridge.OutPoint> outpoints) {
//     for (var e in outpoints) {
//       _unSpendable.add(e);
//     }
//     return this;
//   }
//
//   ///Add a utxo to the internal list of utxos that must be spent
//   ///
//   /// These have priority over the “unspendable” utxos, meaning that if a utxo is present both in the “utxos” and the “unspendable” list, it will be spent.
//   TxBuilder addUtxo(bridge.OutPoint outpoint) {
//     _utxos.add(outpoint);
//     return this;
//   }
//
//   ///Add the list of outpoints to the internal list of UTXOs that must be spent.
//   ///
//   ///If an error occurs while adding any of the UTXOs then none of them are added and the error is returned.
//   ///
//   /// These have priority over the “unspendable” utxos, meaning that if a utxo is present both in the “utxos” and the “unspendable” list, it will be spent.
//   TxBuilder addUtxos(List<bridge.OutPoint> outpoints) {
//     for (var e in outpoints) {
//       _utxos.add(e);
//     }
//     return this;
//   }
//
//   ///Add a foreign UTXO i.e. a UTXO not owned by this wallet.
//   ///At a minimum to add a foreign UTXO we need:
//   ///
//   /// outpoint: To add it to the raw transaction.
//   /// psbt_input: To know the value.
//   /// satisfaction_weight: To know how much weight/vbytes the input will add to the transaction for fee calculation.
//   /// There are several security concerns about adding foreign UTXOs that application developers should consider. First, how do you know the value of the input is correct? If a non_witness_utxo is provided in the psbt_input then this method implicitly verifies the value by checking it against the transaction. If only a witness_utxo is provided then this method doesn’t verify the value but just takes it as a given – it is up to you to check that whoever sent you the input_psbt was not lying!
//   ///
//   /// Secondly, you must somehow provide satisfaction_weight of the input. Depending on your application it may be important that this be known precisely.If not,
//   /// a malicious counterparty may fool you into putting in a value that is too low, giving the transaction a lower than expected feerate. They could also fool
//   /// you into putting a value that is too high causing you to pay a fee that is too high. The party who is broadcasting the transaction can of course check the
//   /// real input weight matches the expected weight prior to broadcasting.
//   TxBuilder addForeignUtxo(
//       Input psbtInput, bridge.OutPoint outPoint, int satisfactionWeight) {
//     _foreignUtxo = (outPoint, psbtInput._input, satisfactionWeight);
//     return this;
//   }
//
//   ///Do not spend change outputs
//   ///
//   /// This effectively adds all the change outputs to the “unspendable” list. See TxBuilder().addUtxos
//   TxBuilder doNotSpendChange() {
//     _changeSpendPolicy = bridge.ChangeSpendPolicy.ChangeForbidden;
//     return this;
//   }
//
//   ///Spend all the available inputs. This respects filters like TxBuilder().unSpendable and the change policy.
//   TxBuilder drainWallet() {
//     _drainWallet = true;
//     return this;
//   }
//
//   ///Sets the address to drain excess coins to.
//   ///
//   /// Usually, when there are excess coins they are sent to a change address generated by the wallet.
//   /// This option replaces the usual change address with an arbitrary scriptPubkey of your choosing.
//   /// Just as with a change output, if the drain output is not needed (the excess coins are too small) it will not be included in the resulting transaction. T
//   /// he only difference is that it is valid to use drainTo without setting any ordinary recipients with add_recipient (but it is perfectly fine to add recipients as well).
//   ///
//   /// If you choose not to set any recipients, you should either provide the utxos that the transaction should spend via add_utxos, or set drainWallet to spend all of them.
//   ///
//   /// When bumping the fees of a transaction made with this option, you probably want to use allowShrinking to allow this output to be reduced to pay for the extra fees.
//   TxBuilder drainTo(bridge.Script script) {
//     _drainTo = script;
//     return this;
//   }
//
//   ///Enable signaling RBF with a specific nSequence value
//   ///
//   /// This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.
//   ///
//   ///If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.
//   TxBuilder enableRbfWithSequence(int nSequence) {
//     _rbfValue = bridge.RbfValue.value(nSequence);
//     return this;
//   }
//
//   ///Enable signaling RBF
//   ///
//   /// This will use the default nSequence value of 0xFFFFFFFD.
//   TxBuilder enableRbf() {
//     _rbfValue = bridge.RbfValue.rbfDefault();
//     return this;
//   }
//
//   ///Set an absolute fee
//   TxBuilder feeAbsolute(int feeAmount) {
//     _feeAbsolute = feeAmount;
//     return this;
//   }
//
//   ///Set a custom fee rate
//   TxBuilder feeRate(double satPerVbyte) {
//     _feeRate = satPerVbyte;
//     return this;
//   }
//
//   ///Replace the recipients already added with a new list
//   TxBuilder setRecipients(List<bridge.ScriptAmount> recipients) {
//     for (var e in _recipients) {
//       _recipients.add(e);
//     }
//     return this;
//   }
//
//   ///Only spend utxos added by add_utxo.
//   ///
//   /// The wallet will not add additional utxos to the transaction even if they are needed to make the transaction valid.
//   TxBuilder manuallySelectedOnly() {
//     _manuallySelectedOnly = true;
//     return this;
//   }
//
//   ///Add a utxo to the internal list of unspendable utxos
//   ///
//   /// It’s important to note that the “must-be-spent” utxos added with TxBuilder().addUtxo
//   /// have priority over this. See the docs of the two linked methods for more details.
//   TxBuilder addUnSpendable(bridge.OutPoint unSpendable) {
//     _unSpendable.add(unSpendable);
//     return this;
//   }
//
//   ///Only spend change outputs
//   ///
//   /// This effectively adds all the non-change outputs to the “unspendable” list.
//   TxBuilder onlySpendChange() {
//     _changeSpendPolicy = bridge.ChangeSpendPolicy.OnlyChange;
//     return this;
//   }
//
//   ///Finish building the transaction.
//   ///
//   /// Returns a [TxBuilderResult].
//
//   Future<TxBuilderResult> finish(Wallet wallet) async {
//     if (_recipients.isEmpty && _drainTo == null) {
//       throw NoRecipientsException();
//     }
//     try {
//       final res = await bdkFfi.txBuilderFinishStaticMethodApi(
//           walletId: wallet._wallet,
//           recipients: _recipients,
//           utxos: _utxos,
//           foreignUtxo: _foreignUtxo,
//           unspendable: _unSpendable,
//           manuallySelectedOnly: _manuallySelectedOnly,
//           drainWallet: _drainWallet,
//           rbf: _rbfValue,
//           drainTo: _drainTo,
//           feeAbsolute: _feeAbsolute,
//           feeRate: _feeRate,
//           data: _data,
//           changePolicy: _changeSpendPolicy);
//
//       return TxBuilderResult(
//           psbt: PartiallySignedTransaction(psbtBase64: res.$1),
//           txDetails: res.$2);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
// }
//
// ///The value returned from calling the .finish() method on the [TxBuilder] or [BumpFeeTxBuilder].
// class TxBuilderResult {
//   final PartiallySignedTransaction psbt;
//
//   ///The transaction details.
//   ///
//   final bridge.TransactionDetails txDetails;
//
//   TxBuilderResult({required this.psbt, required this.txDetails});
// }
//
// /// A Bitcoin wallet.
// ///
// /// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
// ///
// ///     1. Output descriptors from which it can derive addresses.
// ///
// ///     2. A Database where it tracks transactions and utxos related to the descriptors.
// ///
// ///     3. Signers that can contribute signatures to addresses instantiated from the descriptors.
// ///
// class Wallet {
//   final String _wallet;
//   Wallet._(this._wallet);
//
//   ///  [Wallet] constructor
//   static Future<Wallet> create({
//     required Descriptor descriptor,
//     Descriptor? changeDescriptor,
//     required bridge.Network network,
//     required bridge.DatabaseConfig databaseConfig,
//   }) async {
//     try {
//       final res = await bdkFfi.createWalletStaticMethodApi(
//         descriptor: descriptor._descriptorInstance,
//         changeDescriptor: changeDescriptor?._descriptorInstance,
//         network: network,
//         databaseConfig: databaseConfig,
//       );
//       return Wallet._(res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Return a derived address using the external descriptor, see [AddressIndex] for available address index selection strategies.
//   /// If none of the keys in the descriptor are derivable (i.e. does not end with /*) then the same address will always be returned for any AddressIndex.
//   Future<bridge.AddressInfo> getAddress(
//       {required bridge.AddressIndex addressIndex}) async {
//     try {
//       var res = await bdkFfi.getAddressStaticMethodApi(
//           walletId: _wallet, addressIndex: addressIndex);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Return a derived address using the internal (change) descriptor.
//   ///
//   /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
//   ///
//   /// see [AddressIndex] for available address index selection strategies. If none of the keys
//   /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
//   /// be returned for any [AddressIndex].
//   Future<bridge.AddressInfo> getInternalAddress(
//       {required bridge.AddressIndex addressIndex}) async {
//     try {
//       var res = await bdkFfi.getInternalAddressStaticMethodApi(
//           walletId: _wallet, addressIndex: addressIndex);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Return the [Balance], separated into available, trusted-pending, untrusted-pending and immature values.
//   ///
//   ///Note that this method only operates on the internal database, which first needs to be Wallet().sync manually.
//   Future<bridge.Balance> getBalance() async {
//     try {
//       var res = await bdkFfi.getBalanceStaticMethodApi(walletId: _wallet);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Return whether or not a script is part of this wallet (either internal or external).
//   Future<bool> isMine(bridge.Script script) async {
//     try {
//       var res =
//           await bdkFfi.isMineStaticMethodApi(script: script, walletId: _wallet);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Get the Bitcoin network the wallet is using.
//   Future<bridge.Network> network() async {
//     try {
//       var res = await bdkFfi.walletNetworkStaticMethodApi(walletId: _wallet);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Return the list of unspent outputs of this wallet
//   ///
//   /// Note that this method only operates on the internal database, which first needs to be Wallet().sync manually.
//   Future<List<bridge.LocalUtxo>> listUnspent() async {
//     try {
//       var res =
//           await bdkFfi.listUnspentOutputsStaticMethodApi(walletId: _wallet);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Sync the internal database with the [Blockchain]
//   Future sync(Blockchain blockchain) async {
//     try {
//       await bdkFfi.syncWalletStaticMethodApi(
//           walletId: _wallet, blockchainId: blockchain._blockchain);
//       debugPrint('sync complete');
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Return an unsorted list of transactions made and received by the wallet
//   Future<List<bridge.TransactionDetails>> listTransactions(
//       bool includeRaw) async {
//     try {
//       final res = await bdkFfi.getTransactionsStaticMethodApi(
//           walletId: _wallet, includeRaw: includeRaw);
//       return res;
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   ///Sign a transaction with all the wallet’s signers, in the order specified by every signer’s SignerOrdering
//   ///
//   /// Note that it can’t be guaranteed that every signers will follow the options, but the “software signers” (WIF keys and xprv) defined in this library will.
//   Future<PartiallySignedTransaction> sign(
//       {required PartiallySignedTransaction psbt,
//       bridge.SignOptions? signOptions}) async {
//     try {
//       final sbt = await bdkFfi.signStaticMethodApi(
//           signOptions: signOptions,
//           psbtStr: psbt.psbtBase64,
//           walletId: _wallet);
//       if (sbt == null) {
//         throw SignerException(message: "Unable to sign transaction");
//       }
//       return PartiallySignedTransaction(psbtBase64: sbt);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   Future<Input> getPsbtInput({
//     required bridge.LocalUtxo utxo,
//     required bool onlyWitnessUtxo,
//     bridge.PsbtSigHashType? psbtSighashType,
//   }) async {
//     try {
//       final res = await bdkFfi.getPsbtInputStaticMethodApi(
//           walletId: _wallet,
//           utxo: utxo,
//           onlyWitnessUtxo: onlyWitnessUtxo,
//           psbtSighashType: psbtSighashType);
//       return Input._(res);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
//
//   /// Returns the descriptor used to create addresses for a particular `keychain`.
//   Future<Descriptor> getDescriptorForKeyChain(
//       bridge.KeychainKind keychainKind) async {
//     try {
//       final res = await bdkFfi.getDescriptorForKeychainStaticMethodApi(
//           walletId: _wallet, keychain: keychainKind);
//       return Descriptor._(res.$1, res.$2);
//     } on bridge.Error catch (e) {
//       throw handleBdkException(e);
//     }
//   }
// }
//
// extension Tx on bridge.TransactionDetails {
//   Transaction? get transaction =>
//       serializedTx == null ? null : Transaction._(serializedTx);
// }
