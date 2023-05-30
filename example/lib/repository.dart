import 'dart:convert';
import 'dart:isolate';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/cupertino.dart';

class BdkRepository {
  Future<Mnemonic> createMnemonic() async {
    final res = await Mnemonic.create(WordCount.Words12);
    return res;
  }

  Future<List<Descriptor>> init2Of3Descriptors(List<Mnemonic> mnemonics) async {
    final List<DescriptorInfo> descriptorInfos = [];
    for (var e in mnemonics) {
      final secret = await DescriptorSecretKey.create(
          network: Network.Testnet, mnemonic: e);
      final public = await secret.asPublic();
      descriptorInfos.add(DescriptorInfo(secret, public));
    }
    final alice =
        "wsh(sortedmulti(2,${descriptorInfos[0].xprv},${descriptorInfos[1].xpub},${descriptorInfos[2].xpub}))";
    final bob =
        "wsh(sortedmulti(2,${descriptorInfos[1].xprv},${descriptorInfos[2].xpub},${descriptorInfos[0].xpub}))";
    final dave =
        "wsh(sortedmulti(2,${descriptorInfos[2].xprv},${descriptorInfos[0].xpub},${descriptorInfos[1].xpub}))";
    final List<Descriptor> descriptors = [];
    final parsedDes = [alice, bob, dave];
    for (var e in parsedDes) {
      final res =
          await Descriptor.create(descriptor: e, network: Network.Testnet);
      descriptors.add(res);
    }
    return descriptors;
  }

  Future<Descriptor> createDescriptor(Mnemonic mnemonic) async {
    final descriptorSecretKey = await DescriptorSecretKey.create(
      network: Network.Testnet,
      mnemonic: mnemonic,
    );
    final descriptor = await Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: Network.Testnet,
        keychain: KeychainKind.External);
    return descriptor;
  }

  Future<Blockchain> initializeBlockchain(bool isElectrumBlockchain) async {
    if (isElectrumBlockchain) {
      final blockchain = await Blockchain.create(
          config: const BlockchainConfig.esplora(
              config: EsploraConfig(
                  baseUrl: 'https://blockstream.info/testnet/api',
                  stopGap: 10)));
      return blockchain;
    } else {
      final blockchain = await Blockchain.create(
          config: const BlockchainConfig.electrum(
              config: ElectrumConfig(
                  stopGap: 10,
                  timeout: 5,
                  retry: 5,
                  url: "ssl://electrum.blockstream.info:60002",
                  validateDomain: true)));
      return blockchain;
    }
  }

  Future<Wallet> restoreWallet(Descriptor descriptor) async {
    final wallet = await Wallet.create(
        descriptor: descriptor,
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
    return wallet;
  }

  Future<void> sync(Blockchain blockchain, Wallet aliceWallet) async {
    try {
      Isolate.run(() async => {await aliceWallet.sync(blockchain)});
    } on FormatException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<AddressInfo> getAddress(Wallet aliceWallet) async {
    final address =
        await aliceWallet.getAddress(addressIndex: const AddressIndex());
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
    final res = await aliceWallet.listTransactions(true);
    for (var e in res) {
      if (e.confirmationTime == null) unConfirmed.add(e);
    }
    return unConfirmed;
  }

  Future<List<TransactionDetails>> getConfirmedTransactions(
      Wallet aliceWallet) async {
    List<TransactionDetails> confirmed = [];
    final res = await aliceWallet.listTransactions(true);

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
    final feeRate = await blockchain.estimateFee(blocks);
    return feeRate;
  }

  getInputOutPuts(
    TxBuilderResult txBuilderResult,
    Blockchain blockchain,
  ) async {
    final serializedPsbtTx = await txBuilderResult.psbt.jsonSerialize();
    final jsonObj = json.decode(serializedPsbtTx);
    final outputs = jsonObj["unsigned_tx"]["output"] as List;
    final inputs = jsonObj["inputs"][0]["non_witness_utxo"]["output"] as List;
    debugPrint("=========Inputs=====");
    for (var e in inputs) {
      debugPrint("amount: ${e["value"]}");
      debugPrint("script_pubkey: ${e["script_pubkey"]}");
    }
    debugPrint("=========Outputs=====");
    for (var e in outputs) {
      debugPrint("amount: ${e["value"]}");
      debugPrint("script_pubkey: ${e["script_pubkey"]}");
    }
  }

  sendBitcoin(Blockchain blockchain, Wallet aliceWallet, Wallet bobWallet,
      String addressStr) async {
    try {
      final txBuilder = TxBuilder();
      final address = await Address.create(address: addressStr);
      final script = await address.scriptPubKey();
      final feeRate = await estimateFeeRate(25, blockchain);
      final txBuilderResult = await txBuilder
          .addRecipient(script, 1500)
          .feeRate(feeRate.asSatPerVb())
          .finish(aliceWallet);
      getInputOutPuts(txBuilderResult, blockchain);

      final aliceSbt = await aliceWallet.sign(
          psbt: txBuilderResult.psbt,
          signOptions: const SignOptions(
              isMultiSig: true,
              trustWitnessUtxo: false,
              allowAllSighashes: false,
              removePartialSigs: true,
              tryFinalize: true,
              signWithTapInternalKey: true,
              allowGrinding: true));
      final bobSbt = await bobWallet.sign(psbt: aliceSbt);
      final tx = await bobSbt.extractTx();
      Isolate.run(() async => {await blockchain.broadcast(tx)});
    } on FormatException catch (e) {
      debugPrint(e.message);
    }
  }
}

class DescriptorInfo {
  final DescriptorSecretKey xprv;
  final DescriptorPublicKey xpub;
  DescriptorInfo(this.xprv, this.xpub);
}
