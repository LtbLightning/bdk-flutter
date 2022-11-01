import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/utils/exceptions/blochchain_exception.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'bdk_flutter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Wallet>()])
@GenerateNiceMocks([MockSpec<Blockchain>()])
@GenerateNiceMocks([MockSpec<DescriptorSecretKey>()])
@GenerateNiceMocks([MockSpec<DescriptorPublicKey>()])
@GenerateNiceMocks([MockSpec<PartiallySignedBitcoinTransaction>()])
@GenerateNiceMocks([MockSpec<TxBuilder>()])
@GenerateNiceMocks([MockSpec<BumpFeeTxBuilder>()])
@GenerateNiceMocks([MockSpec<Script>()])
@GenerateNiceMocks([MockSpec<Address>()])
@GenerateNiceMocks([MockSpec<BdkFlutter>()])
@GenerateNiceMocks([MockSpec<DerivationPath>()])
abstract class BdkFlutter {
  Future<String> generateMnemonic({required WordCount wordCount});
}

void main() {
  final mockWallet = MockWallet();
  final mockSDescriptorSecret = MockDescriptorSecretKey();
  final mockBlockchian = MockBlockchain();
  final mockBdkFlutter = MockBdkFlutter();
  final mockDerivationPath = MockDerivationPath();
  group('Generate Mnemonic', () {
    test('verify  word count', () async {
      when(mockBdkFlutter.generateMnemonic(wordCount: WordCount.WORDS12))
          .thenAnswer((_) async =>
              'puppy interest whip tonight dad never sudden response push zone pig patch');
      final res =
          await mockBdkFlutter.generateMnemonic(wordCount: WordCount.WORDS12);
      final wordCount = res.split(' ');
      expect(wordCount.length, 12);
    });
    test('verify generated mnemonic', () async {
      const mnemonic =
          "uncover melt orient double buyer birth run glad unhappy sport dizzy squeeze top offer axis rare bulk item";
      when(mockBdkFlutter.generateMnemonic(wordCount: WordCount.WORDS12))
          .thenAnswer((_) async => mnemonic);
      final res =
          await mockBdkFlutter.generateMnemonic(wordCount: WordCount.WORDS12);
      expect(mnemonic, res);
    });
  });
  group('Blockchain', () {
    test('verify create', () async {
      when(mockBlockchian.create(config: defaultConfig))
          .thenAnswer((_) async => Blockchain());
      final res = await mockBlockchian.create(config: defaultConfig);
      expect(res, isA<Blockchain>());
    });
    test('verify getHeight', () async {
      when(mockBlockchian.getHeight()).thenAnswer((_) async => 2396450);
      final res = await mockBlockchian.getHeight();
      expect(res, 2396450);
    });
    test('getHeight Exception', () async {
      try {
        when(mockBlockchian.getHeight()).thenThrow(
            const BlockchainException.unexpected("Blockchain not initialized"));
        await mockBlockchian.getHeight();
      } catch (error) {
        expect(error,
            const BlockchainException.unexpected("Blockchain not initialized"));
        expect(error, isA<BlockchainException>());
      }
    });

    test('verify getHash', () async {
      when(mockBlockchian.getBlockHash(any)).thenAnswer((_) async =>
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
      final res = await mockBlockchian.getBlockHash(2396450);
      expect(res,
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
    });
    test('verify getHash  Exception', () async {
      try {
        when(mockBlockchian.getBlockHash(any)).thenThrow(
            const BlockchainException.unexpected("Blockchain not initialized"));
        await mockBlockchian.getHeight();
      } catch (error) {
        expect(error,
            const BlockchainException.unexpected("Blockchain not initialized"));
        expect(error, isA<BlockchainException>());
      }
    });
  });
  group('Wallet', () {
    test('Should return valid AddressInfo Object', () async {
      final res = await mockWallet.getAddress(addressIndex: AddressIndex.New);
      expect(res, isA<AddressInfo>());
    });
    test('verify getAddress() Exception', () async {
      try {
        when(mockWallet.getAddress(addressIndex: AddressIndex.New)).thenThrow(
            const WalletException.unexpected("Wallet not initialized"));
        await mockWallet.getAddress(addressIndex: AddressIndex.New);
      } catch (error) {
        expect(
            error, const WalletException.unexpected("Wallet not initialized"));
        expect(error, isA<WalletException>());
      }
    });
    test('Should return a new AddressInfo', () async {
      when(mockWallet.getAddress(addressIndex: AddressIndex.New)).thenAnswer(
          (e) async => AddressInfo(
              index: 82,
              address: "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd"));
      final res = await mockWallet.getAddress(addressIndex: AddressIndex.New);
      expect(
          res,
          AddressInfo(
              index: 82,
              address: "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd"));
    });

    test('Should return a last unused AddressInfo', () async {
      when(mockWallet.getAddress(addressIndex: AddressIndex.LastUnused))
          .thenAnswer((e) async => AddressInfo(
              index: 82,
              address: "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd"));
      final res =
          await mockWallet.getAddress(addressIndex: AddressIndex.LastUnused);
      expect(
          res,
          AddressInfo(
              index: 82,
              address: "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd"));
    });

    test('Should return valid Balance object', () async {
      final res = await mockWallet.getBalance();
      expect(res, isA<Balance>());
    });
    test('verify getBalance() Exception', () async {
      try {
        when(mockWallet.getBalance()).thenThrow(
            const WalletException.unexpected("Wallet not initialized"));
        await mockWallet.getBalance();
      } catch (error) {
        expect(
            error, const WalletException.unexpected("Wallet not initialized"));
        expect(error, isA<WalletException>());
      }
    });
    test('Should return Network enum', () async {
      final res = await mockWallet.network();
      expect(res, isA<Network>());
    });
    test('verify network() Exception', () async {
      try {
        when(mockWallet.network()).thenThrow(
            const WalletException.unexpected("Wallet not initialized"));
        await mockWallet.network();
      } catch (error) {
        expect(
            error, const WalletException.unexpected("Wallet not initialized"));
        expect(error, isA<WalletException>());
      }
    });

    test('Should return list of LocalUtxo object', () async {
      final res = await mockWallet.listUnspent();
      expect(res, isA<List<LocalUtxo>>());
    });

    test('verify listUnspent() Exception', () async {
      try {
        when(mockWallet.listUnspent()).thenThrow(
            const WalletException.unexpected("Wallet not initialized"));
        await mockWallet.listUnspent();
      } catch (error) {
        expect(
            error, const WalletException.unexpected("Wallet not initialized"));
        expect(error, isA<WalletException>());
      }
    });

    test('Should return an empty list of TransactionDetails', () async {
      when(mockWallet.listTransactions()).thenAnswer((e) async => List.empty());
      final res = await mockWallet.listTransactions();
      expect(res, isA<List<TransactionDetails>>());
      expect(res, List.empty());
    });

    test('verify listTransactions() Exception', () async {
      try {
        when(mockWallet.listUnspent()).thenThrow(
            const WalletException.unexpected("Wallet not initialized"));
        await mockWallet.listUnspent();
      } catch (error) {
        expect(
            error, const WalletException.unexpected("Wallet not initialized"));
        expect(error, isA<WalletException>());
      }
    });

    test('verify listTransactions() after sync()', () async {
      await mockWallet.sync(mockBlockchian);
      await mockWallet.listTransactions();
      verifyInOrder([
        await mockWallet.sync(mockBlockchian),
        await mockWallet.listTransactions()
      ]);
    });
  });
  group('DescriptorSecret', () {
    test('verify derive()', () async {
      final path =
          await mockDerivationPath.create(path: DEFAULT_DERIVATION_PATH);
      final res = await mockSDescriptorSecret.derive(path);
      expect(res, isA<DescriptorSecretKey>());
    });
    test('verify extend()', () async {
      final path =
          await mockDerivationPath.create(path: DEFAULT_DERIVATION_PATH);
      final res = await mockSDescriptorSecret.extend(path);
      expect(res, isA<DescriptorSecretKey>());
    });

    test('verify asPublic()', () async {
      final res = await mockSDescriptorSecret.asPublic();
      expect(res, isA<DescriptorPublicKey>());
    });

    test('verify asString', () async {
      final res = await mockSDescriptorSecret.asString();
      expect(res, isA<String>());
    });
  });
}
