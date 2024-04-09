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
    Blockchain blockchain,
  ) async {
    final height = await blockchain.getHeight();
    final feeRate = await blockchain.estimateFee(target: height);
    return feeRate;
  }

  sendBitcoin(
      Blockchain blockchain, Wallet aliceWallet, String addressStr) async {
    try {
      final recipientScript = await (await Address.fromString(
              s: addressStr, network: Network.regtest))
          .scriptPubkey();
      final (psbt, _) = await TxBuilder()
          .addRecipient(recipientScript, 1000)
          .feeRate((await estimateFeeRate(blockchain)).satPerVb)
          .finish(aliceWallet);

      final isFinalized = await aliceWallet.sign(psbt: psbt);

      if (isFinalized) {
        final tx = await psbt.extractTx();
        final txid = await blockchain.broadcast(transaction: tx);
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
