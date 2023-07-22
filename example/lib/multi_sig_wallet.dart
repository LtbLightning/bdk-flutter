import 'dart:isolate';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';

class MultiSigWallet {
  Future<List<Descriptor>> init2Of3Descriptors(List<Mnemonic> mnemonics) async {
    final List<DescriptorKeyInfo> descriptorInfos = [];
    for (var e in mnemonics) {
      final secret = await DescriptorSecretKey.create(
          network: Network.Testnet, mnemonic: e);
      final public = await secret.asPublic();
      descriptorInfos.add(DescriptorKeyInfo(secret, public));
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

  Future<List<Descriptor>> createDescriptors() async {
    final alice = await Mnemonic.fromString(
        'thumb member wage display inherit music elevator need side setup tube panther broom giant auction banner split potato');
    final bob = await Mnemonic.fromString(
        'tired shine hat tired hover timber reward bridge verb aerobic safe economy');
    final dave = await Mnemonic.fromString(
        'lawsuit upper gospel minimum cinnamon common boss wage benefit betray ribbon hour');
    final descriptors = await init2Of3Descriptors([alice, bob, dave]);
    return descriptors;
  }

  Future<List<Wallet>> init20f3Wallets() async {
    final descriptors = await createDescriptors();
    final alice = await Wallet.create(
        descriptor: descriptors[0],
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
    final bob = await Wallet.create(
        descriptor: descriptors[1],
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
    final dave = await Wallet.create(
        descriptor: descriptors[2],
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
    return [alice, bob, dave];
  }

  sendBitcoin(Blockchain blockchain, Wallet aliceWallet, Wallet bobWallet,
      String addressStr) async {
    try {
      final txBuilder = TxBuilder();
      final address = await Address.create(address: addressStr);
      final script = await address.scriptPubKey();
      final feeRate = await blockchain.estimateFee(25);
      final txBuilderResult = await txBuilder
          .addRecipient(script, 1000)
          .feeRate(feeRate.asSatPerVb())
          .finish(aliceWallet);
      final aliceSbt = await aliceWallet.sign(
          psbt: txBuilderResult.psbt,
          signOptions: const SignOptions(
              isMultiSig: true,
              trustWitnessUtxo: false,
              allowAllSighashes: true,
              removePartialSigs: true,
              tryFinalize: true,
              signWithTapInternalKey: true,
              allowGrinding: true));
      final bobSbt = await bobWallet.sign(psbt: aliceSbt);
      final tx = await bobSbt.extractTx();
      Isolate.run(() async => {await blockchain.broadcast(tx)});
    } on FormatException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }
}

class DescriptorKeyInfo {
  final DescriptorSecretKey xprv;
  final DescriptorPublicKey xpub;
  DescriptorKeyInfo(this.xprv, this.xpub);
}
