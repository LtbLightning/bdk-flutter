import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/utils/exceptions/bdk_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bdk_flutter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Wallet>()])
@GenerateNiceMocks([MockSpec<Blockchain>()])
@GenerateNiceMocks([MockSpec<DescriptorSecretKey>()])
@GenerateNiceMocks([MockSpec<DescriptorPublicKey>()])
@GenerateNiceMocks([MockSpec<PartiallySignedTransaction>()])
@GenerateNiceMocks([MockSpec<TxBuilder>()])
@GenerateNiceMocks([MockSpec<BumpFeeTxBuilder>()])
@GenerateNiceMocks([MockSpec<Script>()])
@GenerateNiceMocks([MockSpec<Address>()])
@GenerateNiceMocks([MockSpec<DerivationPath>()])
@GenerateNiceMocks([MockSpec<FeeRate>()])
@GenerateNiceMocks([MockSpec<TxBuilderResult>()])
void main() {
  final mockWallet = MockWallet();
  final mockSDescriptorSecret = MockDescriptorSecretKey();
  final mockSDescriptorPublic = MockDescriptorPublicKey();
  final mockBlockchain = MockBlockchain();
  final mockDerivationPath = MockDerivationPath();
  final mockTxBuilder = MockTxBuilder();
  final mockAddress = MockAddress();
  final mockBumpFeeTxBuilder = MockBumpFeeTxBuilder();
  final mockScript = MockScript();
  final mockTxBuilderResult = MockTxBuilderResult();

  group('Blockchain', () {
    test('verify getHeight', () async {
      when(mockBlockchain.getHeight()).thenAnswer((_) async => 2396450);
      final res = await mockBlockchain.getHeight();
      expect(res, 2396450);
    });
    test('verify getHash', () async {
      when(mockBlockchain.getBlockHash(any)).thenAnswer((_) async =>
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
      final res = await mockBlockchain.getBlockHash(2396450);
      expect(res,
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
    });
  });

  group('FeeRate', () {
    test('Should return a double when called', () async {
      when(mockBlockchain.getHeight()).thenAnswer((_) async => 2396450);
      final res = await mockBlockchain.getHeight();
      expect(res, 2396450);
    });
    test('verify getHash', () async {
      when(mockBlockchain.getBlockHash(any)).thenAnswer((_) async =>
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
      final res = await mockBlockchain.getBlockHash(2396450);
      expect(res,
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
    });
  });

  group('Wallet', () {
    test('Should return valid AddressInfo Object', () async {
      final res = await mockWallet.getAddress(addressIndex: AddressIndex());
      expect(res, isA<AddressInfo>());
    });
    test('Should return a new AddressInfo', () async {
      when(mockWallet.getAddress(addressIndex: AddressIndex())).thenAnswer(
          (e) async => AddressInfo(
              index: 82,
              address: "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd"));
      final res = await mockWallet.getAddress(addressIndex: AddressIndex());
      expect(res.index, 82);
      expect(res.address, "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd");
    });
    test('Should return a last unused AddressInfo', () async {
      when(mockWallet.getAddress(addressIndex: AddressIndex.lastUnused()))
          .thenAnswer((e) async => AddressInfo(
              index: 82,
              address: "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd"));
      final res =
          await mockWallet.getAddress(addressIndex: AddressIndex.lastUnused());
      expect(res.index, 82);
      expect(res.address, "tb1qzn0qsh9wdp0m7sx877p9u8kptnvmykm9ld5lyd");
    });
    test('Should return valid Balance object', () async {
      final res = await mockWallet.getBalance();
      expect(res, isA<Balance>());
    });
    test('Should return Network enum', () async {
      final res = await mockWallet.network();
      expect(res, isA<Network>());
    });
    test('Should return list of LocalUtxo object', () async {
      final res = await mockWallet.listUnspent();
      expect(res, isA<List<LocalUtxo>>());
    });
    test('Should return an empty list of TransactionDetails', () async {
      when(mockWallet.listTransactions()).thenAnswer((e) async => List.empty());
      final res = await mockWallet.listTransactions();
      expect(res, isA<List<TransactionDetails>>());
      expect(res, List.empty());
    });
    test('verify function call order', () async {
      await mockWallet.sync(mockBlockchain);
      await mockWallet.listTransactions();
      verifyInOrder([
        await mockWallet.sync(mockBlockchain),
        await mockWallet.listTransactions()
      ]);
    });
  });
  group('DescriptorSecret', () {
    test('verify derive()', () async {
      final res = await mockSDescriptorSecret.derive(mockDerivationPath);
      expect(res, isA<DescriptorSecretKey>());
    });
    test('verify extend()', () async {
      final res = await mockSDescriptorSecret.extend(mockDerivationPath);
      expect(res, isA<DescriptorSecretKey>());
    });
    test('verify asPublic()', () async {
      final res = await mockSDescriptorSecret.asPublic();
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify asString', () async {
      final res = mockSDescriptorSecret.asString();
      expect(res, isA<String>());
    });
  });
  group('DescriptorPublic', () {
    test('verify derive()', () async {
      final res = await mockSDescriptorPublic.derive(mockDerivationPath);
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify extend()', () async {
      final res = await mockSDescriptorPublic.extend(mockDerivationPath);
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify asString', () async {
      final res = mockSDescriptorPublic.asString();
      expect(res, isA<String>());
    });
  });
  group('Tx Builder', () {
    test('Should return a TxBuilderException when funds are insufficient',
        () async {
      try {
        when(mockTxBuilder.finish(mockWallet)).thenThrow(
            const BdkException.insufficientFunds(
                "{ needed: 751, available: 0 }"));
        await mockTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(
            error,
            const BdkException.insufficientFunds(
                "{ needed: 751, available: 0 }"));
        expect(error, isA<BdkException>());
      }
    });
    test('Should return a TxBuilderException when no recipients are added',
        () async {
      try {
        when(mockTxBuilder.finish(mockWallet))
            .thenThrow(const BdkException.noRecipients());
        await mockTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, const BdkException.noRecipients());
        expect(error, isA<BdkException>());
      }
    });

    test('Verify addData() Exception', () async {
      try {
        when(mockTxBuilder.addData(data: List.empty()))
            .thenThrow(const BdkException.unExpected("List must not be empty"));
        mockTxBuilder.addData(data: []);
      } catch (error) {
        expect(error, const BdkException.unExpected("List must not be empty"));
        expect(error, isA<BdkException>());
      }
    });
    test('Verify unSpendable()', () async {
      final res = mockTxBuilder.addUnSpendable(OutPoint(
          txid:
              "efc5d0e6ad6611f22b05d3c1fc8888c3552e8929a4231f2944447e4426f52056",
          vout: 1));
      expect(res, isNot(mockTxBuilder));
    });

    test(
        'Should not return a TxBuilderException when, a drainTo script address is added (with feeRate)',
        () async {
      when(mockTxBuilder.drainTo("mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB"))
          .thenReturn(mockTxBuilder);
      when(mockTxBuilder.drainTo("mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB"))
          .thenReturn(mockTxBuilder);
      when(mockTxBuilder.feeRate(any)).thenReturn(mockTxBuilder);
      when(mockTxBuilder.finish(mockWallet))
          .thenAnswer((_) async => mockTxBuilderResult);
      final txBuilder = mockTxBuilder
          .drainTo("mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB")
          .feeRate(25);
      final res = await txBuilder.finish(mockWallet);
      expect(res.psbt, isA<PartiallySignedTransaction>());
      expect(res.txDetails, isA<TransactionDetails>());
    });
    test(
        'Should not return a TxBuilderException when, a drainTo script address is added, instead of addRecipients',
        () async {
      when(mockTxBuilder.drainTo("mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB"))
          .thenReturn(mockTxBuilder);
      when(mockTxBuilder.finish(mockWallet))
          .thenAnswer((_) async => mockTxBuilderResult);
      final txBuilder =
          mockTxBuilder.drainTo("mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");
      final res = await txBuilder.finish(mockWallet);
      expect(res.psbt, isA<PartiallySignedTransaction>());
      expect(res.txDetails, isA<TransactionDetails>());
    });

    test('Create a proper psbt transaction ', () async {
      when(mockAddress.scriptPubKey()).thenAnswer((_) async => mockScript);
      when(mockTxBuilder.addRecipient(mockScript, any))
          .thenReturn(mockTxBuilder);
      when(mockTxBuilder.finish(mockWallet))
          .thenAnswer((_) async => mockTxBuilderResult);
      final script = await mockAddress.scriptPubKey();
      final txBuilder = mockTxBuilder.addRecipient(script, 1200);
      final res = await txBuilder.finish(mockWallet);
      expect(res, mockTxBuilderResult);
    });
  });
  group('Bump Fee Tx Builder', () {
    test('Should return a TxBuilderException when txid is invalid', () async {
      try {
        when(mockBumpFeeTxBuilder.finish(mockWallet))
            .thenThrow(const BdkException.transactionNotFound());
        await mockBumpFeeTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, const BdkException.transactionNotFound());
        expect(error, isA<BdkException>());
      }
    });
  });
  group('Address', () {
    test('verify scriptPubKey()', () async {
      when(mockAddress.scriptPubKey()).thenAnswer((_) async => mockScript);
      final res = await mockAddress.scriptPubKey();
      expect(res, isA<Script>());
    });
  });
  group('Script', () {
    test('verify create', () async {
      final res = mockScript;
      expect(res, isA<MockScript>());
    });
  });
}
