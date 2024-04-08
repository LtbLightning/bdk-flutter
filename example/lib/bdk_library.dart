import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';

class BdkLibrary {
  Future<Mnemonic> createMnemonic() async {
    final res = await Mnemonic.create(WordCount.words12);
    return res;
  }

  Future<Descriptor> createDescriptor(Mnemonic mnemonic) async {
    final descriptorSecretKey = await DescriptorSecretKey.create(
      network: Network.regtest,
      mnemonic: mnemonic,
    );
    final descriptor = await Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: Network.regtest,
        keychain: KeychainKind.externalChain);
    return descriptor;
  }

  Future<Blockchain> initializeBlockchain(bool isElectrumBlockchain) async {
    if (isElectrumBlockchain) {
      final blockchain = await Blockchain.create(
          config: const BlockchainConfig.electrum(
              config: ElectrumConfig(
                  stopGap: 10,
                  timeout: 5,
                  retry: 5,
                  url: "ssl://electrum.blockstream.info:60002",
                  validateDomain: true)));
      return blockchain;
    } else {
      final blockchain = await Blockchain.create(
          config: const BlockchainConfig.esplora(
              config:
                  EsploraConfig(baseUrl: 'http://0.0.0.0:30000', stopGap: 10)));

      return blockchain;
    }
  }

  Future<Wallet> restoreWallet(Descriptor descriptor) async {
    final wallet = await Wallet.create(
        descriptor: descriptor,
        network: Network.regtest,
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

  Future<List<Address>> getAddresses() async {
    final a1 = await Address.fromString(
        s: "bcrt1qvym2hzrtfdnlnmkg7dk5rw0ykmdr6n7f0w4hu9",
        network: Network.regtest);
    final a2 = await Address.fromString(
        s: "bcrt1qc2thfuugj50e07pnegpdu5ztyvgymuz99t2t2n",
        network: Network.regtest);
    final c1 = await Address.fromString(
        s: "bcrt1q5v5c5kheq4mj8xwnqluhv27gxptvxrfqd948wv",
        network: Network.regtest);
    final c2 = await Address.fromString(
        s: "bcrt1qumf6alpht2veaarpr2xd5uc6l6g50pmwmgvyka",
        network: Network.regtest);
    return [a1, a2, c1, c2];
  }

  createPsbts(Blockchain blockchain, Wallet aliceWallet) async {
    try {
      final addresses = await getAddresses();
      final txBuilder = TxBuilder();
      final u1 = (await aliceWallet.listUnspent()).first;
      final feeRate = await estimateFeeRate(25, blockchain);
      final a1Script = (await addresses[0].scriptPubkey());
      final c2Script = (await addresses[3].scriptPubkey());
      final (psbt, _) = await txBuilder
          .addRecipient(a1Script, 1000)
          .addRecipient(c2Script, 10000)
          .manuallySelectedOnly()
          .addUtxo(u1.outpoint)
          .feeRate(feeRate.satPerVb)
          .finish(aliceWallet);

      return [psbt];
    } on Exception catch (_) {
      rethrow;
    }
  }

  sendBitcoin(
      Blockchain blockchain, Wallet aliceWallet, String addressStr) async {
    try {
      final List<PartiallySignedTransaction> psbts =
          await createPsbts(blockchain, aliceWallet);

      final isFinalized = await aliceWallet.sign(psbt: psbts[0]);

      if (isFinalized) {
        final tx = await psbts[0].extractTx();
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
