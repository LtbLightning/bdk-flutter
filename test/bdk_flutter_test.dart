import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'bdk_flutter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AddressInfo>()])
@GenerateNiceMocks([MockSpec<Address>()])
@GenerateNiceMocks([MockSpec<BumpFeeTxBuilder>()])
@GenerateNiceMocks([MockSpec<Connection>()])
@GenerateNiceMocks([MockSpec<CanonicalTx>()])
@GenerateNiceMocks([MockSpec<DerivationPath>()])
@GenerateNiceMocks([MockSpec<DescriptorSecretKey>()])
@GenerateNiceMocks([MockSpec<DescriptorPublicKey>()])
@GenerateNiceMocks([MockSpec<Descriptor>()])
@GenerateNiceMocks([MockSpec<EsploraClient>()])
@GenerateNiceMocks([MockSpec<ElectrumClient>()])
@GenerateNiceMocks([MockSpec<FeeRate>()])
@GenerateNiceMocks([MockSpec<FullScanRequestBuilder>()])
@GenerateNiceMocks([MockSpec<FullScanRequest>()])
@GenerateNiceMocks([MockSpec<LocalOutput>()])
@GenerateNiceMocks([MockSpec<Mnemonic>()])
@GenerateNiceMocks([MockSpec<PSBT>()])
@GenerateNiceMocks([MockSpec<ScriptBuf>()])
@GenerateNiceMocks([MockSpec<Transaction>()])
@GenerateNiceMocks([MockSpec<TxBuilder>()])
@GenerateNiceMocks([MockSpec<Wallet>()])
@GenerateNiceMocks([MockSpec<Update>()])
void main() {
  final mockWallet = MockWallet();
  final mockDerivationPath = MockDerivationPath();
  final mockAddress = MockAddress();
  final mockScript = MockScriptBuf();
  final mockElectrumClient = MockElectrumClient();
  final mockTx = MockTransaction();
  final mockPSBT = MockPSBT();
  group('Address', () {
    test('verify scriptPubKey()', () {
      final res = mockAddress.script();
      expect(res, isA<ScriptBuf>());
    });
  });
  group('Bump Fee Tx Builder', () {
    final mockBumpFeeTxBuilder = MockBumpFeeTxBuilder();
    test('Should throw a CreateTxException when txid is invalid', () async {
      try {
        when(mockBumpFeeTxBuilder.finish(mockWallet)).thenThrow(
            CreateTxException(code: "Unknown", errorMessage: "Invalid txid"));
        await mockBumpFeeTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<CreateTxException>());
        expect(error.toString().contains("Unknown"), true);
      }
    });
    test(
        'Should throw a CreateTxException when a tx is not found in the internal database',
        () async {
      try {
        when(mockBumpFeeTxBuilder.finish(mockWallet))
            .thenThrow(CreateTxException(code: "TransactionNotFound"));
        await mockBumpFeeTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<CreateTxException>());
        expect(error.toString().contains("TransactionNotFound"), true);
      }
    });

    test('Should thow a CreateTxException when feeRate is too low', () async {
      try {
        when(mockBumpFeeTxBuilder.finish(mockWallet))
            .thenThrow(CreateTxException(code: "FeeRateTooLow"));
        await mockBumpFeeTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<CreateTxException>());
        expect(error.toString().contains("FeeRateTooLow"), true);
      }
    });
    test(
        'Should return a CreateTxException when trying to spend an UTXO that is not in the internal database',
        () async {
      try {
        when(mockBumpFeeTxBuilder.finish(mockWallet)).thenThrow(
          CreateTxException(
              code: "UnknownUtxo",
              errorMessage: "reference to an unknown utxo}"),
        );
        await mockBumpFeeTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<CreateTxException>());
        expect(error.toString().contains("UnknownUtxo"), true);
      }
    });
  });

  group('Electrum Client', () {
    test('verify brodcast', () async {
      when(mockElectrumClient.broadcast(transaction: mockTx)).thenAnswer(
          (_) async =>
              "af7e34474bc17dbe93d47ab465a1122fb31f52cd2400fb4a4c5f3870db597f11");

      final res = await mockElectrumClient.broadcast(transaction: mockTx);
      expect(res,
          "af7e34474bc17dbe93d47ab465a1122fb31f52cd2400fb4a4c5f3870db597f11");
    });
  });

  group('DescriptorSecret', () {
    final mockSDescriptorSecret = MockDescriptorSecretKey();

    test('verify asPublic()', () async {
      final res = mockSDescriptorSecret.toPublic();
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify toString', () async {
      final res = mockSDescriptorSecret.toString();
      expect(res, isA<String>());
    });
  });
  group('DescriptorPublic', () {
    final mockSDescriptorPublic = MockDescriptorPublicKey();
    test('verify derive()', () async {
      final res = await mockSDescriptorPublic.derive(path: mockDerivationPath);
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify extend()', () async {
      final res = await mockSDescriptorPublic.extend(path: mockDerivationPath);
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify asString', () async {
      final res = mockSDescriptorPublic.asString();
      expect(res, isA<String>());
    });
  });

  group('Wallet', () {
    test('Should return valid AddressInfo Object', () async {
      final res = mockWallet.revealNextAddress(
          keychainKind: KeychainKind.externalChain);
      expect(res, isA<AddressInfo>());
    });

    test('Should return valid Balance object', () async {
      final res = mockWallet.getBalance();
      expect(res, isA<Balance>());
    });
    test('Should return Network enum', () async {
      final res = mockWallet.network();
      expect(res, isA<Network>());
    });
    test('Should return list of LocalUtxo object', () async {
      final res = mockWallet.listUnspent();
      expect(res, isA<List<LocalOutput>>());
    });

    test('Should return an empty list of TransactionDetails', () async {
      when(mockWallet.transactions()).thenAnswer((e) => [MockCanonicalTx()]);
      final res = mockWallet.transactions();
      expect(res, isA<List<CanonicalTx>>());
    });
  });
  group('Tx Builder', () {
    final mockTxBuilder = MockTxBuilder();
    test('Should return a TxBuilderException when funds are insufficient',
        () async {
      try {
        when(mockTxBuilder.finish(mockWallet))
            .thenThrow(CreateTxException(code: 'InsufficientFunds'));
        await mockTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<CreateTxException>());
        expect(error.toString().contains("InsufficientFunds"), true);
      }
    });
    test('Should return a TxBuilderException when no recipients are added',
        () async {
      try {
        when(mockTxBuilder.finish(mockWallet)).thenThrow(
          CreateTxException(code: "NoRecipients"),
        );
        await mockTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<CreateTxException>());
        expect(error.toString().contains("NoRecipients"), true);
      }
    });
    test('Verify unSpendable()', () async {
      final res = mockTxBuilder.addUnSpendable(OutPoint(
          txid:
              "efc5d0e6ad6611f22b05d3c1fc8888c3552e8929a4231f2944447e4426f52056",
          vout: 1));
      expect(res, isNot(mockTxBuilder));
    });
    test('Create a proper psbt transaction ', () async {
      const psbtBase64 = "cHNidP8BAHEBAAAAAfU6uDG8hNUox2Qw1nodiir"
          "QhnLkDCYpTYfnY4+lUgjFAAAAAAD+////Ag5EAAAAAAAAFgAUxYD3fd+pId3hWxeuvuWmiUlS+1PoAwAAAAAAABYAFP+dpWfmLzDqhlT6HV+9R774474TxqQkAAABAN4"
          "BAAAAAAEBViD1JkR+REQpHyOkKYkuVcOIiPzB0wUr8hFmrebQxe8AAAAAAP7///8ClEgAAAAAAAAWABTwV07KrKa1zWpwKzW+ve93pbQ4R+gDAAAAAAAAFgAU/52lZ+YvMOqGVPodX71Hv"
          "vjjvhMCRzBEAiAa6a72jEfDuiyaNtlBYAxsc2oSruDWF2vuNQ3rJSshggIgLtJ/YuB8FmhjrPvTC9r2w9gpdfUNLuxw/C7oqo95cEIBIQM9XzutA2SgZFHjPDAATuWwHg19TTkb/NKZD/"
          "hfN7fWP8akJAABAR+USAAAAAAAABYAFPBXTsqsprXNanArNb6973eltDhHIgYCHrxaLpnD4ed01bFHcixnAicv15oKiiVHrcVmxUWBW54Y2R5q3VQAAIABAACAAAAAgAEAAABbAAAAACICAqS"
          "F0mhBBlgMe9OyICKlkhGHZfPjA0Q03I559ccj9x6oGNkeat1UAACAAQAAgAAAAIABAAAAXAAAAAAA";
      when(mockPSBT.asString()).thenAnswer((_) => psbtBase64);
      when(mockTxBuilder.addRecipient(mockScript, any))
          .thenReturn(mockTxBuilder);
      when(mockAddress.script()).thenAnswer((_) => mockScript);
      when(mockTxBuilder.finish(mockWallet)).thenAnswer((_) async => mockPSBT);
      final script = mockAddress.script();
      final txBuilder = mockTxBuilder.addRecipient(script, BigInt.from(1200));
      final res = await txBuilder.finish(mockWallet);
      expect(res, isA<PSBT>());
      expect(res.asString(), psbtBase64);
    });
  });
  group('Script', () {
    test('verify create', () {
      final res = mockScript;
      expect(res, isA<MockScriptBuf>());
    });
  });
  group('Transaction', () {
    final mockTx = MockTransaction();
    test('verify serialize', () async {
      final res = mockTx.serialize();
      expect(res, isA<List<int>>());
    });
    test('verify txid', () async {
      final res = mockTx.computeTxid();
      expect(res, isA<String>());
    });
    // test('verify weight', () async {
    //   final res = await mockTx.weight();
    //   expect(res, isA<int>());
    // });
    //   test('verify vsize', () async {
    //     final res = mockTx.vsize();
    //     expect(res, isA<BigInt>());
    //   });
    //   test('verify isCoinbase', () async {
    //     final res = mockTx.isCoinbase();
    //     expect(res, isA<bool>());
    //   });
    //   test('verify isExplicitlyRbf', () async {
    //     final res = mockTx.isExplicitlyRbf();
    //     expect(res, isA<bool>());
    //   });
    //   test('verify isLockTimeEnabled', () async {
    //     final res = mockTx.isLockTimeEnabled();
    //     expect(res, isA<bool>());
    //   });
    //   test('verify version', () async {
    //     final res = mockTx.version();
    //     expect(res, isA<int>());
    //   });
    //   test('verify lockTime', () async {
    //     final res = mockTx.lockTime();
    //     expect(res, isA<int>());
    //   });
    //   test('verify input', () async {
    //     final res = mockTx.input();
    //     expect(res, isA<List<TxIn>>());
    //   });
    //   test('verify output', () async {
    //     final res = mockTx.output();
    //     expect(res, isA<List<TxOut>>());
    //   });
  });
}
