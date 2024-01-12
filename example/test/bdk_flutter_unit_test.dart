import 'dart:typed_data';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setCurrentDirectory();
  const derivationPath = "m/44'/1'/0'";
  const script = [
    118,
    169,
    20,
    159,
    154,
    122,
    189,
    96,
    12,
    12,
    170,
    3,
    152,
    58,
    119,
    200,
    195,
    223,
    142,
    6,
    44,
    178,
    250,
    136,
    172
  ];

  final address =
      await Address.create(address: "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");
  final blockchain = await Blockchain.create(
      config: const BlockchainConfig.electrum(
          config: ElectrumConfig(
              stopGap: 10,
              timeout: 5,
              retry: 5,
              url: "ssl://electrum.blockstream.info:60002",
              validateDomain: true)));

  Future<DescriptorSecretKey> getDescriptorSecretKey() async {
    final mnemonic = await Mnemonic.fromString(
        "chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect");
    return await DescriptorSecretKey.create(
        network: Network.Testnet, mnemonic: mnemonic);
  }

  Future<DescriptorSecretKey> deriveDescriptorSecretKey(
      DescriptorSecretKey secretKey, String path) async {
    return await secretKey.derive(await DerivationPath.create(path: path));
  }

  Future<DescriptorSecretKey> extendDescriptorSecretKey(
      DescriptorSecretKey secretKey, String path) async {
    return await secretKey.extend(await DerivationPath.create(path: path));
  }

  Future<DescriptorPublicKey> deriveDescriptorPublicKey(
      DescriptorPublicKey publicKey, String path) async {
    return await publicKey.derive(await DerivationPath.create(path: path));
  }

  Future<DescriptorPublicKey> extendDescriptorPublicKey(
      DescriptorPublicKey publicKey, String path) async {
    return await publicKey.extend(await DerivationPath.create(path: path));
  }

  Future<Wallet> getFundedWallet(String descriptor) async {
    return await Wallet.create(
        descriptor: (await Descriptor.create(
            descriptor: descriptor, network: Network.Testnet)),
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
  }

  group('Address', () {
    test('verify toString()', () async {
      final res = address.toString();
      expect(res, "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");
    });
    test('verify scriptPubKey ()', () async {
      final res = await address.scriptPubKey();
      expect(res.inner, script);
    });
    test('verify scriptPubKey type()', () async {
      final res = await address.scriptPubKey();
      expect(res.inner, isA<Uint8List>());
    });
    test('verify network()', () async {
      final res = await address.network();
      expect(res, Network.Testnet);
    });
    test('verify payload()', () async {
      final res = await address.payload();
      expect(res, isA<Payload>());
    });
  });
  group('Blockchain', () {
    test('verify getHeight() type', () async {
      final res = await blockchain.getHeight();
      expect(res, isA<int>());
    });
    test('verify getBlockHash() type', () async {
      final height = await blockchain.getHeight();
      final res = await blockchain.getBlockHash(height);
      expect(res, isA<String>());
    });
    test('verify estimateFee() type', () async {
      final res = await blockchain.estimateFee(25);
      expect(res, isA<FeeRate>());
    });
  });
  group('DerivationPath', () {
    test('verify create() type', () async {
      final res = await DerivationPath.create(path: "m/44h/1h/0h");
      expect(res.toString(), derivationPath);
    });
  });
  group('Mnemonic', () {
    test('verify mnemonic length; create()', () async {
      for (var e in [WordCount.Words12, WordCount.Words18, WordCount.Words24]) {
        final length = int.parse(e.name.split('s').last);
        final res = await Mnemonic.create(e);
        expect(res.asString().split(RegExp(r'\s+')).length, length);
      }
    });
    test('verify fromString()', () async {
      final res = await Mnemonic.fromString(
          "chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect");
      expect(res, isA<Mnemonic>());
    });
  });
  group('Descriptor', () {
    //DescriptorSecretKey
    test('verify generate_descriptor_secret_key', () async {
      final res = await getDescriptorSecretKey();
      expect(res.asString(),
          "tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/*");
      expect((await res.asPublic()).asString(),
          "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/*");
    });
    test('_derive_self', () async {
      final secretKey = await getDescriptorSecretKey();
      final derivedDsk = await deriveDescriptorSecretKey(secretKey, "m");
      expect(derivedDsk.asString(),
          "[d1d04177]tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/*");
      final publicKey = await secretKey.asPublic();
      final derivedDpk = await deriveDescriptorPublicKey(publicKey, "m");
      expect(derivedDpk.asString(),
          "[d1d04177]tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/*");
    });

    test('verify DescriptorSecretKey.create() type', () async {
      final res = await getDescriptorSecretKey();
      expect(res, isA<DescriptorSecretKey>());
    });
    test('verify descriptorSecretKey.asPublic type', () async {
      final res = await getDescriptorSecretKey();
      expect(await res.asPublic(), isA<DescriptorPublicKey>());
    });

    test('verify descriptorSecretKey.secretBytes()', () async {
      final res = await getDescriptorSecretKey();
      expect((await res.secretBytes()), [
        233,
        51,
        21,
        214,
        206,
        64,
        30,
        180,
        219,
        128,
        58,
        86,
        35,
        47,
        14,
        211,
        230,
        155,
        5,
        55,
        116,
        230,
        4,
        125,
        245,
        79,
        27,
        208,
        14,
        94,
        169,
        54
      ]);
    });
    test('verify descriptorSecretKey.extend()', () async {
      expect(
          (await extendDescriptorSecretKey(
                  await getDescriptorSecretKey(), derivationPath))
              .asString(),
          "tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/44'/1'/0'/*");
    });
    test('verify descriptorSecretKey.derive()', () async {
      expect(
          ((await deriveDescriptorSecretKey(
                  await getDescriptorSecretKey(), derivationPath)))
              .asString(),
          "[d1d04177/44'/1'/0']tprv8g7MbPjRKU1LkemDd2cE1UWJwsEyVCDG5Wrs6JURJcdec9fMnvURoRqz68mKiJLXBiBiWc3aUVRL8RaGZPVWxFZ67btBuf1kp2Z5HLSwTGo/*");
    });
    test('verify DescriptorSecretKey.fromString', () async {
      final res = await DescriptorSecretKey.fromString(
          "[d1d04177/44'/1'/0']tprv8g7MbPjRKU1LkemDd2cE1UWJwsEyVCDG5Wrs6JURJcdec9fMnvURoRqz68mKiJLXBiBiWc3aUVRL8RaGZPVWxFZ67btBuf1kp2Z5HLSwTGo/*");
      expect(res.asString(),
          "[d1d04177/44'/1'/0']tprv8g7MbPjRKU1LkemDd2cE1UWJwsEyVCDG5Wrs6JURJcdec9fMnvURoRqz68mKiJLXBiBiWc3aUVRL8RaGZPVWxFZ67btBuf1kp2Z5HLSwTGo/*");
    });
    // descriptorPublicKey
    test('verify descriptorPublicKey.asString()', () async {
      final res = await getDescriptorSecretKey();
      expect((await res.asPublic()).asString(),
          "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/*");
    });
    test('verify descriptorPublicKey.extend()', () async {
      final descriptorSecretKey = await getDescriptorSecretKey();
      final descriptorPublicKey = await descriptorSecretKey.asPublic();
      expect(
          (await extendDescriptorPublicKey(descriptorPublicKey, derivationPath))
              .toString(),
          "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/44'/1'/0'/*");
    });
    test('verify DescriptorPublicKey.fromString', () async {
      expect(
          (await DescriptorPublicKey.fromString(
                  "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/44'/1'/0'/*"))
              .toString(),
          "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/44'/1'/0'/*");
    });

    test('verify Descriptor templates', () async {
      final descriptorSecretKey = await getDescriptorSecretKey();
      debugPrint("DescriptorSecretKey: ${descriptorSecretKey.asString()}");
      final handmadePublic44 = await (await deriveDescriptorSecretKey(
              descriptorSecretKey, "m/44h/1h/0h"))
          .asPublic();
      debugPrint("Public 44: ${handmadePublic44.asString()}");
      final handmadePublic49 = await (await deriveDescriptorSecretKey(
              descriptorSecretKey, "m/49h/1h/0h"))
          .asPublic();

      debugPrint("Public 49: ${handmadePublic49.asString()}");

      final handmadePublic84 = await (await deriveDescriptorSecretKey(
              descriptorSecretKey, "m/84h/1h/0h"))
          .asPublic();

      debugPrint("Public 84: ${handmadePublic84.asString()}");

      final templatePrivate44 = await Descriptor.newBip44(
          secretKey: descriptorSecretKey,
          network: Network.Testnet,
          keychain: KeychainKind.External);
      final templatePrivate49 = await Descriptor.newBip49(
          secretKey: descriptorSecretKey,
          network: Network.Testnet,
          keychain: KeychainKind.External);
      final templatePrivate84 = await Descriptor.newBip84(
          secretKey: descriptorSecretKey,
          network: Network.Testnet,
          keychain: KeychainKind.External);
      debugPrint("Template 49: ${await templatePrivate44.asString()}");
      debugPrint("Template 44:  ${await templatePrivate49.asString()}");
      debugPrint("Template 84:  ${await templatePrivate84.asString()}");

      final templatePublic44 = await Descriptor.newBip44Public(
          publicKey: handmadePublic44,
          network: Network.Testnet,
          keychain: KeychainKind.External,
          fingerPrint: 'd1d04177');
      final templatePublic49 = await Descriptor.newBip49Public(
          publicKey: handmadePublic49,
          network: Network.Testnet,
          keychain: KeychainKind.External,
          fingerPrint: 'd1d04177');
      final templatePublic84 = await Descriptor.newBip84Public(
          publicKey: handmadePublic84,
          network: Network.Testnet,
          keychain: KeychainKind.External,
          fingerPrint: 'd1d04177');
      expect(await templatePublic84.asString(),
          await templatePublic84.asStringPrivate());
      expect(await templatePublic44.asString(),
          await templatePublic44.asStringPrivate());
      expect(await templatePublic49.asString(),
          await templatePublic49.asStringPrivate());
      // when using asString on a private key, we get the same result as when using it on a public key
      expect(
          await templatePublic84.asString(), await templatePublic84.asString());
      expect(
          await templatePublic44.asString(), await templatePublic44.asString());
      expect(
          await templatePublic49.asString(), await templatePublic49.asString());
    });
  });
  group('Psbt', () {
    test('verify psbt_fee', () async {
      const testWpkh =
          "wpkh(cVpPVruEDdmutPzisEsYvtST1usBR3ntr8pXSyt6D2YYqXRyPcFW)";
      final wallet = await getFundedWallet(testWpkh);
      await wallet.sync(blockchain);
      const drainToAddress = "tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt";
      final drainToScript =
          await (await Address.create(address: drainToAddress)).scriptPubKey();
      final txBuilder =
          TxBuilder().feeRate(2.0).drainWallet().drainTo(drainToScript);
      final builderRes = await txBuilder.finish(wallet);
      expect((await builderRes.psbt.feeRate() != null), true);
      expect(
          (await builderRes.psbt.feeRate())?.asSatPerVb(), 3.2113821506500244);

      expect((await builderRes.psbt.feeAmount() != null), true);
      expect((await builderRes.psbt.feeAmount()), 1580);
    });
  });
}
