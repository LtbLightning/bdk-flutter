import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';

class BdkLibrary {
  Future<Mnemonic> createMnemonic() async {
    final res = await Mnemonic.create(WordCount.words12);
    return res;
  }

  Future<Descriptor> createDescriptor(Mnemonic mnemonic) async {
    final descriptorSecretKey = await DescriptorSecretKey.create(
      network: Network.signet,
      mnemonic: mnemonic,
    );
    if (kDebugMode) {
      print(descriptorSecretKey.toPublic());
      print(descriptorSecretKey.secretBytes());
      print(descriptorSecretKey);
    }

    final descriptor = await Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: Network.signet,
        keychain: KeychainKind.externalChain);
    return descriptor;
  }

  Future<Blockchain> initializeBlockchain() async {
    return Blockchain.createMutinynet();
  }

  Future<Wallet> restoreWallet(Descriptor descriptor) async {
    final wallet = await Wallet.create(
        descriptor: descriptor,
        network: Network.testnet,
        databaseConfig: const DatabaseConfig.memory());
    return wallet;
  }

  Future<void> sync(Blockchain blockchain, Wallet wallet) async {
    try {
      await wallet.sync(blockchain: blockchain);
    } on FormatException catch (e) {
      debugPrint(e.message);
    }
  }

  AddressInfo getAddressInfo(Wallet wallet) {
    return wallet.getAddress(addressIndex: const AddressIndex.increase());
  }

  Future<Input> getPsbtInput(
      Wallet wallet, LocalUtxo utxo, bool onlyWitnessUtxo) async {
    final input =
        wallet.getPsbtInput(utxo: utxo, onlyWitnessUtxo: onlyWitnessUtxo);
    return input;
  }

  List<TransactionDetails> getUnConfirmedTransactions(Wallet wallet) {
    List<TransactionDetails> unConfirmed = [];
    final res = wallet.listTransactions(includeRaw: true);
    for (var e in res) {
      if (e.confirmationTime == null) unConfirmed.add(e);
    }
    return unConfirmed;
  }

  List<TransactionDetails> getConfirmedTransactions(Wallet wallet) {
    List<TransactionDetails> confirmed = [];
    final res = wallet.listTransactions(includeRaw: true);
    for (var e in res) {
      if (e.confirmationTime != null) confirmed.add(e);
    }
    return confirmed;
  }

  Future<Balance> getBalance(Wallet wallet) async {
    return wallet.getBalance();
  }

  List<LocalUtxo> listUnspent(Wallet wallet) {
    return wallet.listUnspent();
  }

  Future<FeeRate> estimateFeeRate(
    int blocks,
    Blockchain blockchain,
  ) async {
    final feeRate = await blockchain.estimateFee(target: BigInt.from(blocks));
    return feeRate;
  }

  sendBitcoin(Blockchain blockchain, Wallet wallet, String receiverAddress,
      int amountSat) async {
    try {
      final txBuilder = TxBuilder();
      final address = await Address.fromString(
          s: receiverAddress, network: wallet.network());
      final script = address.scriptPubkey();
      final feeRate = await estimateFeeRate(25, blockchain);
      final (psbt, _) = await txBuilder
          .addRecipient(script, BigInt.from(amountSat))
          .feeRate(feeRate.satPerVb)
          .finish(wallet);
      final isFinalized = wallet.sign(psbt: psbt);
      if (isFinalized) {
        final tx = psbt.extractTx();
        final res = await blockchain.broadcast(transaction: tx);
        debugPrint(res);
      } else {
        debugPrint("psbt not finalized!");
      }
      // Isolate.run(() async => {});
    } on Exception catch (_) {
      rethrow;
    }
  }
}
