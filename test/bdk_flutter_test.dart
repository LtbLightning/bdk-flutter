import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/utils/exceptions/broadcast_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/key_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exceptions.dart';
import 'package:bdk_flutter/src/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'bdk_flutter_test.mocks.dart';
@GenerateNiceMocks([MockSpec<BdkFlutter>()])
@GenerateNiceMocks([MockSpec<GenerateKeys>()])
abstract class GenerateKeys {
  Future<WalletDescriptor> createDescriptors(
      {String? descriptorPath,
        String? changeDescriptorPath,
        String? xprv,
        required Descriptor type,
        String? mnemonic,
        Network? network,
        String? password,
        List<String>? publicKeys,
        int? threshold = 4});

  Future<DerivedKeyInfo> createDerivedKey(
      {required Network network,
        required String mnemonic,
        String? path,
        String? password = ''});

  Future<ExtendedKeyInfo> createExtendedKey(
      {required Network network,
        required String mnemonic,
        String? password = ''});

  Future<String> generateMnemonic({
    WordCount? wordCount,
    Entropy? entropy});
}


void main() {
  final mockGenKeys = MockGenerateKeys();
  final mockBdkFlutter = MockBdkFlutter();

  group('Generate Mnemonic', () {
    test('Verify default word count', () async {
      when( mockGenKeys.generateMnemonic()).thenAnswer((_) async => 'puppy interest whip tonight dad never sudden response push zone pig patch');
      final res = await mockGenKeys.generateMnemonic();
      final wordCount = res.split(' ');
      expect(wordCount.length, 12);
    });
    test('Verify if function returns mnemonic, according to WordCount provided', () async {
      when( mockGenKeys.generateMnemonic(wordCount: WordCount.WORDS12)).thenAnswer((_) async => 'puppy interest whip tonight dad never sudden response push zone pig patch');
      final res = await mockGenKeys.generateMnemonic(wordCount: WordCount.WORDS12);
      final wordCount = res.split(' ');
      expect(wordCount.length, 12);
    });
  });

  group('Create Derived Key', () {
    test('Should throw an exception on invalid mnemonic', () async {
      try {
        when( mockGenKeys.createDerivedKey(network: Network.TESTNET, mnemonic: "invalid Mnemonic")).thenThrow(const KeyException.badWordCount("The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24"));

        await mockGenKeys.createDerivedKey(network: Network.TESTNET, mnemonic: "invalid Mnemonic");
      } catch (error) {
        expect(error, const KeyException.badWordCount("The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24"));
        expect(error, isA<KeyException>());
      }
    });
    test('Should create valid derived key', () async {
      var res =  await mockGenKeys.createDerivedKey(
          network: Network.TESTNET,
          mnemonic:
          "school alcohol coral light army gather adapt blossom school alcohol coral lens");
      expect(res, isA<DerivedKeyInfo>());
    });
  });

  group('Create ExtendedKey', () {
    test('Should throw an exception on invalid mnemonic', () async {
      when( mockGenKeys.createExtendedKey(network: Network.TESTNET, mnemonic: "invalid Mnemonic")).thenThrow(const KeyException.badWordCount("The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24"));
      try {
        await mockGenKeys.createExtendedKey(network: Network.TESTNET, mnemonic: "invalid Mnemonic");
      } catch (error) {
        expect(error, const KeyException.badWordCount("The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24"));
        expect(error, isA<KeyException>());
      }
    });
    test('Should create valid extended key', () async {
      var res =  await mockGenKeys.createExtendedKey(
          network: Network.TESTNET,
          mnemonic:
          "school alcohol coral light army gather adapt blossom school alcohol coral lens");
      expect(res, isA<ExtendedKeyInfo>());
    });
  });

  group('Create Descriptors', () {
    test('Should throw an KeyException if both xprv and mnemonic are provided', () async {
      try {
        when(await mockGenKeys.createDescriptors(type: Descriptor.P2PK))
            .thenThrow(const KeyException.insufficientCoreVariables(
            "Require a mnemonic or xprv."));
        await mockGenKeys.createDescriptors(type: Descriptor.P2PK);
      } catch (error) {
        expect(error, const KeyException.insufficientCoreVariables(
            "Require a mnemonic or xprv."));
        expect(error, isA<KeyException>());
      }
    });
    test('Should throw an exception when both xprv mnemonic is provided', () async {
      try {
        when(mockGenKeys.createDescriptors(
            type: Descriptor.P2PK,
            mnemonic: "daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save",
            xprv: "tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9"
        )).thenThrow(const KeyException.repetitiousArguments(
            "Provided both mnemonic and xprv."));

        mockGenKeys.createDescriptors(
            type: Descriptor.P2PK,
            mnemonic: "daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save",
            xprv: "tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9"
        );
      } catch (error) {
        expect(error, const KeyException.repetitiousArguments(
            "Provided both mnemonic and xprv."));
        expect(error, isA<KeyException>());
      }
    });
    test('Should throw an exception when public keys are null when descriptor is MULTI', () async {
      try {
        when(mockGenKeys.createDescriptors(
            type: Descriptor.MULTI,
            mnemonic: "daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save",
            threshold: 1
        )).thenThrow(const  KeyException.invalidPublicKey("Public keys must not be null"));

        mockGenKeys.createDescriptors(
            type: Descriptor.P2PK,
            mnemonic: "daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save",
            threshold: 1
        );
      } catch (error) {
        expect(error, const KeyException.invalidPublicKey("Public keys must not be null"));
        expect(error, isA<KeyException>());
      }
    });
  });

  group('Wallet Tests', () {
    test('Should throw an exception on invalid blockchain url', () async {
      try {
        await mockBdkFlutter.createWallet(
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
      final res = await mockBdkFlutter.createWallet(
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
      final res = await mockBdkFlutter.getNewAddress();
      expect(res, isA<String>());
    });
    test('Should return valid Balance Object', () async {

      final res = await mockBdkFlutter.getBalance();
      expect(res, isA<Balance>());
    });
    test('Should return valid Address', () async {
      final res = await mockBdkFlutter.getLastUnusedAddress();
      expect(res, isA<String>());
    });
    test('Create transaction() should throw error when amount is less than 100', () async {
      when( mockBdkFlutter.createTx(recipient: "recipient", amount: 0, feeRate: 1)).thenThrow(const BroadcastException.insufficientBroadcastAmount("The minimum amount should be greater 100"));
      try {
        await mockBdkFlutter.createTx(recipient: "recipient", amount: 0, feeRate: 1);
      } catch (e) {
        expect(e, isA<BroadcastException>());
      }
    });
    test('QuickSend() should throw error when amount is less than 100', () async {
      when( mockBdkFlutter.createTx(recipient: "recipient", amount: 0, feeRate: 1)).thenThrow(const BroadcastException.insufficientBroadcastAmount("The minimum amount should be greater 100"));
      try {
        await mockBdkFlutter.quickSend(recipient: "recipient", amount: 0, feeRate: 1);
      } catch (e) {
        expect(e, isA<BroadcastException>());
      }
    });
  });
}
