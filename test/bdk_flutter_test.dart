import 'package:bdk_flutter/src/utils/exceptions/broadcast_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/key_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BdkWallet])
import 'bdk_flutter_test.mocks.dart';
final mockWallet = MockBdkWallet();
void main() {
  group('Generate Mnemonic', () {
    test('Verify default word count', () async {
      final res = await  generateMnemonic();
      final wordCount = res.split(' ');
      expect(
        wordCount.length, 12
      );
  });
    test('Verify if function returns, mnemonic according to Entropy provided', () async {
      final res = await  generateMnemonic(entropy: Entropy.Entropy128);
      final wordCount = res.split(' ');
      expect(
          wordCount.length, 12
      );
    });
    test('Verify if function returns mnemonic, according to WordCount provided', () async {
      final res = await  generateMnemonic(wordCount: WordCount.Words21);
      final wordCount = res.split(' ');
      expect(
          wordCount.length, 21
      );
    });
    test('Verify if function use entropy as parameter if both are provided', () async {
      final res = await  generateMnemonic(entropy: Entropy.Entropy128, wordCount: WordCount.Words24);
      final wordCount = res.split(' ');
      expect(
          wordCount.length, 12
      );
    });
});
  group('Create ExtendedKey', () {
    test('Should throw an exception on invalid mnemonic', () async {
      try {
        await createExtendedKey(network: Network.TESTNET, mnemonic: "invalid Mnemonic");
      } catch (error) {
        expect(
            error,
            isA<KeyException>()
        );
      }
    });
    test('Should create valid extended key', () async {
      var res =   await createExtendedKey(network: Network.TESTNET, mnemonic: "school alcohol coral light army gather adapt blossom school alcohol coral lens");
      expect(
          res,
          isA<ExtendedKeyInfo>()
      );
    });

  });
  group('Wallet Tests', () {
    test('Should throw an exception on invalid blockchain url', () async {
      try {
       await BdkWallet().createWallet(network: Network.TESTNET, blockchain: Blockchain.ELECTRUM, blockChainConfigUrl: '');
      } catch (error) {
        expect(
          error,
          isA<WalletException>()
        );
      }
    });
    test('Should return a response wallet', () async {
      final res = await BdkWallet().createWallet(
        mnemonic:"school alcohol coral light army gather adapt blossom school alcohol coral lens",
        password:"",
        network: Network.TESTNET,
        blockchain: Blockchain.ELECTRUM,
        blockChainConfigUrl: "ssl://electrum.blockstream.info:60002",);
      expect(
          res,
          isA<ResponseWallet>()
      );
    });
    test('Should return valid wallet address', () async {
      final res = await BdkWallet().getNewAddress();
      expect(
          res,
          isA<String>()
      );
      expect(
          res.isNotEmpty,
          true
      );
    });
    test('Should return valid unused address', () async {
      final res = await BdkWallet().getLastUnusedAddress();
      expect(
          res,
          isA<String>()
      );
      expect(
          res.isNotEmpty,
          true
      );
    });
    test('Createtransaction() should throw error when amount is less than 100', () async {
      try{
        await BdkWallet().createTransaction(recipient: "recipient", amount: 0, feeRate: 1);
      } catch (e){
        expect(
            e,
            isA<BroadcastException>()
        );
      }



    });
    test('QuickSend() should throw error when amount is less than 100', () async {
      try{
        await BdkWallet().quickSend(recipient: "recipient", amount: 0, feeRate: 1);
      } catch (e){
        expect(
            e,
            isA<BroadcastException>()
        );
      }



    });
  });
}

