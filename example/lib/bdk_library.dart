import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/cupertino.dart';

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

  Future<void> sync(Blockchain blockchain, Wallet aliceWallet) async {
    try {
      await aliceWallet.sync(blockchain: blockchain);
    } on FormatException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<AddressInfo> getAddress(Wallet aliceWallet) async {
    final address = await aliceWallet.getAddress(
        addressIndex: const AddressIndex.increase());
    return address;
  }

  Future<Input> getPsbtInput(
      Wallet aliceWallet, LocalUtxo utxo, bool onlyWitnessUtxo) async {
    final input = await aliceWallet.getPsbtInput(
        utxo: utxo, onlyWitnessUtxo: onlyWitnessUtxo);
    return input;
  }

  Future<List<TransactionDetails>> getUnConfirmedTransactions(
      Wallet aliceWallet) async {
    List<TransactionDetails> unConfirmed = [];
    final res = await aliceWallet.listTransactions(includeRaw: true);
    for (var e in res) {
      if (e.confirmationTime == null) unConfirmed.add(e);
    }
    return unConfirmed;
  }

  Future<List<TransactionDetails>> getConfirmedTransactions(
      Wallet aliceWallet) async {
    List<TransactionDetails> confirmed = [];
    final res = await aliceWallet.listTransactions(includeRaw: true);

    for (var e in res) {
      if (e.confirmationTime != null) confirmed.add(e);
    }
    return confirmed;
  }

  Future<Balance> getBalance(Wallet aliceWallet) async {
    final res = await aliceWallet.getBalance();
    return res;
  }

  Future<List<LocalUtxo>> listUnspend(Wallet aliceWallet) async {
    final res = await aliceWallet.listUnspent();
    return res;
  }

  Future<FeeRate> estimateFeeRate(
    int blocks,
    Blockchain blockchain,
  ) async {
    final feeRate = await blockchain.estimateFee(target: blocks);
    return feeRate;
  }

  sendBitcoin(
    Blockchain blockchain,
    Wallet aliceWallet,
    String addressStr,
    int amountSat,
  ) async {
    try {
      final txBuilder = TxBuilder();
      final address = await Address.fromString(
          s: addressStr, network: (await aliceWallet.network()));

      final script = await address.scriptPubkey();
      final feeRate = await estimateFeeRate(25, blockchain);
      final (psbt, _) = await txBuilder
          .addRecipient(script, amountSat)
          .feeRate(feeRate.satPerVb)
          .finish(aliceWallet);
      final isFinalized = await aliceWallet.sign(psbt: psbt);
      if (isFinalized) {
        final tx = await psbt.extractTx();
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
