import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/utils/exceptions/broadcast_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/key_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exceptions.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

class BdkFlutter {
  Future<ResponseWallet> createWallet({
    String? mnemonic,
    String? password,
    String? descriptor,
    String? changeDescriptor,
    Network? network,
    BlockchainConfig? blockchainConfig,
    DatabaseConfig databaseConfig = const DatabaseConfig.memory(),
  }) async {
    try {
      if ((mnemonic == null || mnemonic.isEmpty) &&
          (descriptor == null || descriptor.isEmpty)) {
        throw const WalletException.insufficientCoreArguments(
            "Requires a mnemonic or a descriptor");
      }
      if ((mnemonic != null) && (descriptor != null)) {
        throw const WalletException.repetitiousArguments(
            "Provided both mnemonic and descriptor.");
      }
      if (descriptor != null) {
        await loaderApi.walletInit(
            descriptor: descriptor.toString(),
            changeDescriptor: changeDescriptor,
            network: network ?? DEFAULT_NETWORK,
            databaseConfig: databaseConfig,
            blockchainConfig: blockchainConfig??DEFAUTL_CONFIG);
      } else {
        var key = await createDescriptors(
            network: network??DEFAULT_NETWORK,
            mnemonic: mnemonic.toString(),
            password: password,
            type: Descriptor.P2PK,
            descriptorPath: DEFAUTLT_DESCRIPTOR_PATH,
            changeDescriptorPath: DEFAUTLT_CHANGE_DESCRIPTOR_PATH
        );
        await loaderApi.walletInit(
            descriptor: key.descriptor,
            changeDescriptor: key.changeDescriptor,
            network: network??DEFAULT_NETWORK,
            databaseConfig: databaseConfig,
            blockchainConfig: blockchainConfig??DEFAUTL_CONFIG);
      }
      final res = await loaderApi.getWallet();
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<ResponseWallet> getWallet() async {
    try {
      return await loaderApi.getWallet();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<String> getNewAddress() async {
    try {
      var res = await loaderApi.getNewAddress();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Return a derived address using the internal (change) descriptor.
  /// If the wallet doesn’t have an internal descriptor it will use the external descriptor.
  Future<String> getNewInternalAddress() async {
    try {
      var res = await loaderApi.getNewInternalAddress();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<Balance> getBalance() async {
    try {
      var res = await loaderApi.getBalance();
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<String> getLastUnusedAddress() async {
    try {
      var res = await loaderApi.getLastUnusedAddress();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  /// Return the “public” version of the wallet’s descriptor, meaning a new descriptor that has the same structure but with every secret key removed
  Future<String> getPublicDescriptor() async {
    try {
      var res = await loaderApi.getPublicDescriptor();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  /// Return the checksum of the public descriptor associated to keychain Internally calls
  Future<String> getDescriptorCheckSum(
      {required KeyChainKind keyChainKind}) async {
    try {
      var res =
          await loaderApi.getDescriptorChecksum(keychainKindStr: keyChainKind);
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  ///Returns the descriptor used to create addresses for a particular keychain.
  Future<String> getDescriptorForKeyChainKind(
      {required KeyChainKind keyChainKind}) async {
    try {
      var res =
          await loaderApi.getDescriptorChecksum(keychainKindStr: keyChainKind);
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<int> getBlockchainHeight() async {
    try {
      var res = await loaderApi.getBlockchainHeight();
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<String> getBlockchainHash(int blockChainHeight) async {
    try {
      var res =
          await loaderApi.getBlockchainHash(blockchainHeight: blockChainHeight);
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  syncWallet() async {
    try {
      print("Syncing Wallet");
      await loaderApi.syncWallet();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      final res = await loaderApi.getTransactions();
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<List<Transaction>> getPendingTransactions() async {
    try {
      List<Transaction> unConfirmed = [];
      final res = await getTransactions();
      for (var e in res) {
        e.maybeMap(
            orElse: () {},
            unconfirmed: (e) {
              unConfirmed.add(e);
            });
      }
      return unConfirmed;
    } on WalletException {
      rethrow;
    }
  }

  Future<List<Transaction>> getConfirmedTransactions() async {
    try {
      List<Transaction> confirmed = [];
      final res = await getTransactions();
      for (var e in res) {
        e.maybeMap(
            orElse: () {},
            confirmed: (e) {
              confirmed.add(e);
            });
      }
      return confirmed;
    } on WalletException {
      rethrow;
    }
  }

  Future<String> createTx(
      {required String recipient,
      required int amount,
      required double feeRate}) async {
    try {
      if (amount < 100) {
        throw const BroadcastException.insufficientBroadcastAmount("The minimum amount should be greater 100");
      }
      final psbt = await loaderApi.createTransaction(
          recipient: recipient, amount: amount, feeRate: feeRate);
      return psbt;
    } on FfiException catch (e) {
      if (e.message.contains("InsufficientFunds")) {
        final message = e.message.split("InsufficientFunds").last;
        throw BroadcastException.insufficientFunds(message);
      }
      throw BroadcastException.unexpected(e.message);
    }
  }

  Future<String> signTx({required String psbt}) async {
    try {
      final sbt = await loaderApi.sign(psbtStr: psbt);
      if (sbt == null) throw const BroadcastException.unexpected("Unable to sign transaction");
      return sbt.toString();
    } on FfiException catch (e) {
      throw BroadcastException.unexpected(e.message);
    }
  }

  Future<String> broadcastTx({required String sbt}) async {
    try {
      final txid = await loaderApi.broadcast(psbtStr: sbt);
      return txid;
    } on FfiException catch (e) {
      throw BroadcastException.unexpected(e.message);
    }
  }

  Future<String> signAndBroadcastTx({required String psbt}) async {
    try {
      final txid = await loaderApi.signAndBroadcast(psbtStr: psbt);
      return txid;
    } on FfiException catch (e) {
      throw BroadcastException.unexpected(e.message);
    }
  }

  Future<String> quickSend(
      {required String recipient,
      required int amount,
      required double feeRate}) async {
    try {
      if (amount < 100) {
        throw const BroadcastException.insufficientBroadcastAmount(
            "The minimum amount should be greater 100 sats");
      }
      final psbt = await createTx(
          recipient: recipient, amount: amount, feeRate: feeRate);
      final txid = await signAndBroadcastTx(psbt: psbt);
      return txid;
    } on FfiException catch (e) {
      if (e.message.contains("InsufficientFunds")) {
        final message = e.message.split("InsufficientFunds").last;
        throw BroadcastException.insufficientFunds(message);
      }
      throw BroadcastException.unexpected(e.message);
    } on BroadcastException {
      rethrow;
    }
  }
}

Future<String> generateMnemonic(
    {WordCount? wordCount, Entropy? entropy}) async {
  try {
    if ((wordCount != null) && (entropy != null)) {
      var res = await loaderApi.generateSeedFromEntropy(entropy: entropy);
      return res;
    } else if (wordCount != null) {
      var res = await loaderApi.generateSeedFromWordCount(wordCount: wordCount);
      return res;
    } else if (entropy != null) {
      var res = await loaderApi.generateSeedFromEntropy(entropy: entropy);
      return res;
    } else {
      var res =
          await loaderApi.generateSeedFromEntropy(entropy: Entropy.ENTROPY128);
      return res;
    }
  } on FfiException catch (e) {
    throw KeyException.unexpected(e.message);
  }
}

Future<String> createXprv(
    {required Network network,
    required String mnemonic,
    String? password = ''}) async {
  try {
    var res = await createExtendedKey(
        network: network, mnemonic: mnemonic, password: password.toString());
    return res.xprv.toString();
  } on KeyException {
    rethrow;
  }
}

Future<String> createXpub(
    {required Network network,
    required String mnemonic,
    String? password = ''}) async {
  try {
    var res = await createExtendedKey(
        network: network, mnemonic: mnemonic, password: password.toString());
    return res.xpub.toString();
  } on KeyException {
    rethrow;
  }
}

Future<ExtendedKeyInfo> createExtendedKey(
    {required Network network,
    required String mnemonic,
    String? password = ''}) async {
  try {
    if (!isValidMnemonic(mnemonic.toString())) {
      throw const KeyException.badWordCount(
          "The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24");
    }
    var res = await loaderApi.createKey(
      nodeNetwork: network,
      mnemonic: mnemonic,
      password: password,
    );
    return res;
  } on FfiException catch (e) {
    if (e.message.contains("UnknownWord")) {
      final message = e.message.split("value:").last;
      throw KeyException.invalidMnemonic(message);
    }
    throw KeyException.unexpected(e.message);
  }
}

Future<DerivedKeyInfo> createDerivedKey(
    {required Network network,
    required String mnemonic,
    String? path,
    String? password = ''}) async {
  try {
    if (!isValidMnemonic(mnemonic.toString())) {
      throw const KeyException.badWordCount(
          "The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24");
    }
    var res = await loaderApi.createDescriptorSecretKeys(
        nodeNetwork: network, mnemonic: mnemonic, path: path ?? DEFAUTLT_DESCRIPTOR_PATH);
    return res;
  } on FfiException catch (e) {
    if (e.message.contains("UnknownWord")) {
      final message = e.message.split("value:").last;
      throw KeyException.invalidMnemonic(message);
    }
    throw KeyException.unexpected(e.message);
  }
}

Future<WalletDescriptor> createDescriptors(
    {String? descriptorPath,
    String? changeDescriptorPath,
    String? xprv,
    required Descriptor type,
    String? mnemonic,
    Network? network,
    String? password,
    List<String>? publicKeys,
    int? threshold = 4}) async {
  if ((mnemonic == null) && (xprv == null)) {
    throw const KeyException.insufficientCoreVariables(
        "Require a mnemonic or xprv.");
  }
  if ((mnemonic != null) && (xprv != null)) {
    throw const KeyException.repetitiousArguments(
        "Provided both mnemonic and xprv.");
  }
  if (xprv == null || xprv == "") {
    if (network == null) throw const KeyException.invalidNetwork();
    final descriptorKey = await createDerivedKey(
        network: network,
        password: password,
        mnemonic: mnemonic.toString(),
        path: descriptorPath ?? DEFAUTLT_DESCRIPTOR_PATH);
    final changeDescriptorKey = await createDerivedKey(
        network: network,
        password: password,
        mnemonic: mnemonic.toString(),
        path: changeDescriptorPath ?? DEFAUTLT_CHANGE_DESCRIPTOR_PATH);
    final res = _createDescriptor(
        threshold: threshold,
        publicKeys: publicKeys,
        descriptorKey: descriptorKey.xprv,
        changeDescriptorKey: changeDescriptorKey.xprv,
        type: type);
    return res;
  } else {
    final res = _createDescriptor(
        threshold: threshold,
        publicKeys: publicKeys,
        descriptorKey: xprv,
        changeDescriptorKey: xprv,
        type: type);
    return res;
  }
}

WalletDescriptor _createMultiSigDescriptor(
    {List<String>? publicKeys,
    int threshold = 2,
    required String descriptorKey,
    String? changeDescriptorKey}) {
  if (publicKeys == null) {
    throw const KeyException.invalidPublicKey("Public keys must not be null");
  }
  if (threshold == 0 || threshold > publicKeys.length + 1) {
    throw const KeyException.invalidThresholdValue();
  }
  return WalletDescriptor(
      descriptor:
          "wsh(multi($threshold,$descriptorKey,${publicKeys.reduce((value, element) => '$value,$element')}))",
      changeDescriptor:
          "wsh(multi($threshold,$changeDescriptorKey,${publicKeys.reduce((value, element) => '$value,$element')}))");
}

WalletDescriptor _createDescriptor(
    {required String descriptorKey,
    String? changeDescriptorKey,
    required Descriptor type,
    List<String>? publicKeys,
    int? threshold = 4}) {
  switch (type) {
    case Descriptor.P2PKH:
      return WalletDescriptor(
          descriptor: "pkh($descriptorKey)",
          changeDescriptor: "pkh($changeDescriptorKey)");
    case Descriptor.P2WPKH:
      return WalletDescriptor(
          descriptor: "wpkh($descriptorKey)",
          changeDescriptor: "wpkh($changeDescriptorKey)");
    case Descriptor.P2SHP2WPKH:
      return WalletDescriptor(
          descriptor: "sh(wpkh($descriptorKey))",
          changeDescriptor: "sh(wpkh($changeDescriptorKey))");
    case Descriptor.P2SHP2WSHP2PKH:
      return WalletDescriptor(
          descriptor: "sh(wsh(pkh($descriptorKey)))",
          changeDescriptor: "sh(wsh(pkh($changeDescriptorKey)))");
    case Descriptor.MULTI:
      return _createMultiSigDescriptor(
          publicKeys: publicKeys,
          threshold: threshold!.toInt(),
          descriptorKey: descriptorKey,
          changeDescriptorKey: changeDescriptorKey);
    default:
      return WalletDescriptor(
          descriptor: "wpkh($descriptorKey)",
          changeDescriptor: "wpkh($changeDescriptorKey)");
  }
}
