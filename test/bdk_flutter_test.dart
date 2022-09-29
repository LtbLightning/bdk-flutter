import 'package:bdk_flutter/src/utils/exceptions/broadcast_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/key_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bdk_flutter/bdk_flutter.dart';

void main() {
  group('Generate Mnemonic', () {
    test('Verify default word count', () async {
      final res = await generateMnemonic();
      final wordCount = res.split(' ');
      expect(wordCount.length, 12);
    });
    test('Verify if function returns, mnemonic according to Entropy provided',
        () async {
      final res = await generateMnemonic(entropy: Entropy.ENTROPY128);
      final wordCount = res.split(' ');
      expect(wordCount.length, 12);
    });
    test('Verify if function returns mnemonic, according to WordCount provided',
        () async {
      final res = await generateMnemonic(wordCount: WordCount.WORDS12);
      final wordCount = res.split(' ');
      expect(wordCount.length, 21);
    });
    test('Verify if function use entropy as parameter if both are provided',
        () async {
      final res = await generateMnemonic(
          entropy: Entropy.ENTROPY128, wordCount: WordCount.WORDS24);
      final wordCount = res.split(' ');
      expect(wordCount.length, 12);
    });
  });
  group('Create ExtendedKey', () {
    test('Should throw an exception on invalid mnemonic', () async {
      try {
        await createExtendedKey(
            network: Network.TESTNET, mnemonic: "invalid Mnemonic");
      } catch (error) {
        expect(error, isA<KeyException>());
      }
    });
    test('Should create valid extended key', () async {
      var res = await createExtendedKey(
          network: Network.TESTNET,
          mnemonic:
              "school alcohol coral light army gather adapt blossom school alcohol coral lens");
      expect(res, isA<ExtendedKeyInfo>());
    });
  });
  group('Wallet Tests', () {
    test('Should throw an exception on invalid blockchain url', () async {
      try {
        await BdkFlutter().createWallet(
            network: Network.TESTNET,
            databaseConfig: const DatabaseConfig.memory(),
            blockchainConfig: BlockchainConfig.esplora(
                config: EsploraConfig(
              baseUrl: "ssl://electrum.blockstream.info:60002",
              timeout: 5,
              stopGap: 10,
            )));
      } catch (error) {
        expect(error, isA<WalletException>());
      }
    });
    test('Should return a response wallet', () async {
      final res = await BdkFlutter().createWallet(
          mnemonic:
              "school alcohol coral light army gather adapt blossom school alcohol coral lens",
          password: "",
          network: Network.TESTNET,
          databaseConfig: const DatabaseConfig.memory(),
          blockchainConfig: BlockchainConfig.esplora(
              config: EsploraConfig(
            baseUrl: "ssl://electrum.blockstream.info:60002",
            timeout: 5,
            stopGap: 10,
          )));
      expect(res, isA<ResponseWallet>());
    });
    test('Should return valid wallet address', () async {
      final res = await BdkFlutter().getNewAddress();
      expect(res, isA<String>());
      expect(res.isNotEmpty, true);
    });
    test('Should return valid unused address', () async {
      final res = await BdkFlutter().getLastUnusedAddress();
      expect(res, isA<String>());
      expect(res.isNotEmpty, true);
    });
    test('Createtransaction() should throw error when amount is less than 100',
        () async {
      try {
        await BdkFlutter()
            .createTransaction(recipient: "recipient", amount: 0, feeRate: 1);
      } catch (e) {
        expect(e, isA<BroadcastException>());
      }
    });
    test('QuickSend() should throw error when amount is less than 100',
        () async {
      try {
        await BdkFlutter()
            .quickSend(recipient: "recipient", amount: 0, feeRate: 1);
      } catch (e) {
        expect(e, isA<BroadcastException>());
      }
    });
  });
}
