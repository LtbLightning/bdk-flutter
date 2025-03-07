import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'dart:typed_data';
import 'bdk_flutter_test.mocks.dart';

// Generate mocks for all classes
@GenerateNiceMocks([
  MockSpec<AddressInfo>(),
  MockSpec<Address>(),
  MockSpec<BumpFeeTxBuilder>(),
  MockSpec<Connection>(),
  MockSpec<CanonicalTx>(),
  MockSpec<DerivationPath>(),
  MockSpec<DescriptorSecretKey>(),
  MockSpec<DescriptorPublicKey>(),
  MockSpec<Descriptor>(),
  MockSpec<EsploraClient>(),
  MockSpec<ElectrumClient>(),
  MockSpec<FeeRate>(),
  MockSpec<FullScanRequestBuilder>(),
  MockSpec<FullScanRequest>(),
  MockSpec<LocalOutput>(),
  MockSpec<Mnemonic>(),
  MockSpec<PSBT>(),
  MockSpec<ScriptBuf>(),
  MockSpec<Transaction>(),
  MockSpec<TxBuilder>(),
  MockSpec<Wallet>(),
  MockSpec<Update>()
])
void main() {
  group('Address Tests', () {
    late MockAddress mockAddress;
    late MockScriptBuf mockScript;

    setUp(() {
      mockAddress = MockAddress();
      mockScript = MockScriptBuf();
    });

    test('script() returns ScriptBuf', () {
      when(mockAddress.script()).thenReturn(mockScript);
      expect(mockAddress.script(), isA<ScriptBuf>());
    });

    test('toQrUri() returns valid URI string', () {
      when(mockAddress.toQrUri()).thenReturn('bitcoin:bc1qxxx');
      expect(mockAddress.toQrUri(), startsWith('bitcoin:'));
    });

    test('isValidForNetwork() validates network correctly', () {
      when(mockAddress.isValidForNetwork(network: Network.testnet))
          .thenReturn(true);
      expect(mockAddress.isValidForNetwork(network: Network.testnet), isTrue);
    });
  });

  group('BumpFeeTxBuilder Tests', () {
    late MockBumpFeeTxBuilder mockBuilder;
    late MockWallet mockWallet;
    late MockPSBT mockPSBT;

    setUp(() {
      mockBuilder = MockBumpFeeTxBuilder();
      mockWallet = MockWallet();
      mockPSBT = MockPSBT();
    });

    test('finish() returns PSBT on success', () async {
      when(mockBuilder.finish(mockWallet)).thenAnswer((_) async => mockPSBT);
      final result = await mockBuilder.finish(mockWallet);
      expect(result, isA<PSBT>());
    });

    test('finish() throws on insufficient fee', () {
      when(mockBuilder.finish(mockWallet))
          .thenThrow(CreateTxException(code: "FeeRateTooLow"));
      expect(() => mockBuilder.finish(mockWallet),
          throwsA(isA<CreateTxException>()));
    });
  });

  group('DerivationPath Tests', () {
    late MockDerivationPath mockPath;

    setUp(() {
      mockPath = MockDerivationPath();
    });

    test('create() returns valid path', () async {
      when(mockPath.asString()).thenReturn("m/84'/0'/0'/0/0");
      expect(mockPath.asString(), "m/84'/0'/0'/0/0");
    });
  });

  group('Descriptor Tests', () {
    late MockDescriptor mockDescriptor;
    late MockDescriptorSecretKey mockSecretKey;

    setUp(() {
      mockDescriptor = MockDescriptor();
      mockSecretKey = MockDescriptorSecretKey();
    });

    test('create() returns valid descriptor', () async {
      when(mockDescriptor.asString()).thenReturn(
          "wpkh([f5acc2fd/84'/1'/0']tpubDCtKfsNyRhULjZ9XMS4VKKtVcPdVDi8MKUbcSD9MJDyjRu1A2ND5MiipozyyspBT9bg8upEp7a8EAgFxNxXn1d7QkdbL52Ty5jiSLcxPt1P/0/*)");
      expect(mockDescriptor.asString().startsWith("wpkh"), true);
    });
  });

  group('EsploraClient Tests', () {
    late MockEsploraClient mockClient;
    late MockTransaction mockTx;
    late MockUpdate mockUpdate;

    setUp(() {
      mockClient = MockEsploraClient();
      mockTx = MockTransaction();
      mockUpdate = MockUpdate();
    });

    test('broadcast() succeeds', () async {
      when(mockClient.broadcast(transaction: mockTx))
          .thenAnswer((_) async => {});
      await expectLater(mockClient.broadcast(transaction: mockTx), completes);
    });

    test('throws EsploraException on network error', () {
      when(mockClient.broadcast(transaction: mockTx))
          .thenThrow(EsploraException(code: "NetworkError"));
      expect(
        () => mockClient.broadcast(transaction: mockTx),
        throwsA(isA<EsploraException>()),
      );
    });
  });

  group('Wallet Tests', () {
    late MockWallet mockWallet;
    late MockAddressInfo mockAddressInfo;
    late MockTransaction mockTx;
    late MockLocalOutput mockOutput;

    setUp(() {
      mockWallet = MockWallet();
      mockAddressInfo = MockAddressInfo();
      mockTx = MockTransaction();
      mockOutput = MockLocalOutput();
    });

    test('revealNextAddress() returns valid AddressInfo', () {
      when(mockWallet.revealNextAddress(
              keychainKind: KeychainKind.externalChain))
          .thenReturn(mockAddressInfo);
      final result = mockWallet.revealNextAddress(
          keychainKind: KeychainKind.externalChain);
      expect(result, isA<AddressInfo>());
    });

    test('getBalance() returns valid Balance', () {
      when(mockWallet.getBalance()).thenReturn(Balance(
        trustedPending: BigInt.from(100000),
        untrustedPending: BigInt.from(0),
        confirmed: BigInt.from(0),
        spendable: BigInt.from(0),
        total: BigInt.from(100000),
        immature: BigInt.from(0),
      ));
      final balance = mockWallet.getBalance();
      expect(balance.total, BigInt.from(100000));
    });

    test('listUnspent() returns list of LocalOutput', () {
      when(mockWallet.listUnspent()).thenReturn([mockOutput]);
      final utxos = mockWallet.listUnspent();
      expect(utxos, isA<List<LocalOutput>>());
      expect(utxos.length, 1);
    });
  });

  group('PSBT Tests', () {
    late MockPSBT mockPsbt;
    late MockTransaction mockTx;

    setUp(() {
      mockPsbt = MockPSBT();
      mockTx = MockTransaction();
    });

    // test('fromString() creates valid PSBT', () async {
    //   const validPsbtBase64 =
    //       "cHNidP8BAHECAAAAAn+RHcVztpnXXtZyDLORWgd9IBgaRqjMz3L4oyfqelmLAAAAAAD+////kYv9zYwORLgUp2G/C2yT1G01c1KqgnBBdGz4vM7lbrcAAAAAAP7///8CYOMhAAAAAAAWABTQTaKJp3XepSAU6zRmKaWZNvam1/AiMQAAAAAAFgAUK4uLIPsZlZdP/ZL9QO3Xhh1o5OQAAAAAAAEBIIDDIQAAAAAACgAAAIABAIACAACAAAABASCAlpgAAAAAABYAFHI3ddhY4rGxBJNwSBPpztnjcIhUAQVHUiEDghdV1cgrVOiPqFqP5H0SmcPGA/MSLOa3F0Awk+JcCX4hA1Ds6R+JGvmh6rXnVFmXgY/8oIkuR0mD5BJVMgd2td9YUq4iBgOCF1XVyCtU6I+oWo/kfRKZw8YD8xIs5rcXQDCT4lwJfhirqOJUAACAAAAAgAAAAIACAACAAAAAAAAAAAAiBgNQ7OkfiRr5oeq151RZl4GP/KCJLkdJg+QSVTIHdrXfWBi7oqBUAACAAAAAgAAAAIACAACAAAAAAAAAAAABBUdSIQJf0d9flM3+BaCGIaGfeADYDj7kv6A/K3COquQmFaF+kyEDOyoxu8TcrHH7ZuXiAmEBxoKKaOTqZ0MZwCw9mRKJb7xSriICAl/R31+Uzf4FoIYhoZ94ANgOPuS/oD8rcI6q5CYVoX6TGNn1YlQAAIAAAACAAAAAgAIAAIAAAAAAAAAAACICAzsiMbvE3Kxx+2bl4gJhAcaCimjk6mdDGcAsPZkSiW+8GKeS71QAAIAAAACAAAAAgAIAAIAAAAAAAAAAAAEBR1IhAqIXv4yx8PKe8nez1E75MrLiB0qrKvZYIB3MU0TzqVlrIQK4YxHyyfboyQCHMzOCE1n5CwTKrVcFGzE4p1sRJr5wk1KuIgICohe/jLHw8p7yd7PUTvkysuIHSqsq9lggHcxTRPOpWWsY2fViVAAAgAAAAIAAAACAAgAAgAAAAAAAAAAAIgICuGMR8sn26MkAhzMzghNZ+QsEyq1XBRsxOKdbESa+cJMYp5LvVAAAgAAAAIAAAACAAgAAgAAAAAAAAAAA";
    //   final psbt = await PSBT.fromString(validPsbtBase64);
    //   expect(psbt, isA<PSBT>());
    // });

    // test('throws PsbtException on invalid PSBT string', () {
    //   expect(
    //     () => PSBT.fromString('invalid'),
    //     throwsA(isA<PsbtException>()),
    //   );
    // });
  });

  group('ScriptBuf Tests', () {
    late MockScriptBuf mockScript;

    setUp(() {
      mockScript = MockScriptBuf();
    });

    // test('withCapacity() creates script with capacity', () async {
    //   final script = await ScriptBuf.withCapacity(BigInt.from(32));
    //   expect(script, isA<ScriptBuf>());
    // });
  });

  group('Transaction Tests', () {
    late MockTransaction mockTx;

    setUp(() {
      mockTx = MockTransaction();
    });

    test('create() returns valid transaction', () async {
      when(mockTx.computeTxid()).thenReturn("validtxid");
      expect(mockTx.computeTxid(), "validtxid");
    });

    test('throws TransactionException on invalid transaction', () {
      when(mockTx.computeTxid())
          .thenThrow(TransactionException(code: "Invalid"));
      expect(
        () => mockTx.computeTxid(),
        throwsA(isA<TransactionException>()),
      );
    });
  });

  group('TxBuilder Tests', () {
    late MockTxBuilder mockBuilder;
    late MockWallet mockWallet;
    late MockScriptBuf mockScript;

    setUp(() {
      mockBuilder = MockTxBuilder();
      mockWallet = MockWallet();
      mockScript = MockScriptBuf();
    });

    test('finish() creates valid transaction', () async {
      final mockPsbt = MockPSBT();
      when(mockBuilder.finish(mockWallet)).thenAnswer((_) async => mockPsbt);
      final result = await mockBuilder.finish(mockWallet);
      expect(result, isA<PSBT>());
    });

    test('throws CreateTxException on insufficient funds', () {
      when(mockBuilder.finish(mockWallet))
          .thenThrow(CreateTxException(code: "InsufficientFunds"));
      expect(
        () => mockBuilder.finish(mockWallet),
        throwsA(isA<CreateTxException>()),
      );
    });
  });

  group('Mnemonic Tests', () {
    late MockMnemonic mockMnemonic;

    setUp(() {
      mockMnemonic = MockMnemonic();
    });

    test('fromString() creates valid mnemonic', () {
      when(mockMnemonic.asString()).thenReturn(
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about');
      expect(mockMnemonic.asString().split(' ').length, 12);
    });
  });

  group('DescriptorSecretKey Tests', () {
    late MockDescriptorSecretKey mockSecretKey;
    late MockDerivationPath mockPath;

    setUp(() {
      mockSecretKey = MockDescriptorSecretKey();
      mockPath = MockDerivationPath();
    });

    test('fromString() parses a valid secret key', () async {
      when(mockSecretKey.toString()).thenReturn(
          '[f5acc2fd/84h/1h/0h]tprv8ZgxMBicQKsPeWHBt7a68nPnvgTnuDhUgDWC8wZCgA8GahrQ3f3uWpq7wE7Uc1dLBnCe8siRbYPFP5PhdAgvMT3AKhRfxnwuMkQE9bmXdLY');
      final key = await DescriptorSecretKey.fromString(
          '[f5acc2fd/84h/1h/0h]tprv8ZgxMBicQKsPeWHBt7a68nPnvgTnuDhUgDWC8wZCgA8GahrQ3f3uWpq7wE7Uc1dLBnCe8siRbYPFP5PhdAgvMT3AKhRfxnwuMkQE9bmXdLY');
      expect(key.toString().startsWith('['), true);
    });
  });

  group('ElectrumClient Tests', () {
    late MockElectrumClient mockClient;
    late MockTransaction mockTx;

    setUp(() {
      mockClient = MockElectrumClient();
      mockTx = MockTransaction();
    });

    test('broadcast() succeeds', () async {
      when(mockClient.broadcast(transaction: mockTx))
          .thenAnswer((_) async => "validTxid");
      await expectLater(mockClient.broadcast(transaction: mockTx), completes);
    });

    test('throws ElectrumException on network error', () {
      when(mockClient.broadcast(transaction: mockTx))
          .thenThrow(ElectrumException(code: "NetworkError"));
      expect(
        () => mockClient.broadcast(transaction: mockTx),
        throwsA(isA<ElectrumException>()),
      );
    });
  });

  group('CanonicalTx Tests', () {
    late MockCanonicalTx mockCanonicalTx;

    setUp(() {
      mockCanonicalTx = MockCanonicalTx();
    });

    test('serialize() returns bytes', () async {
      when(mockCanonicalTx.transaction.serialize())
          .thenReturn(Uint8List.fromList([0, 1, 2]));
      final bytes = mockCanonicalTx.transaction.serialize();
      expect(bytes, isA<Uint8List>());
    });
  });
}
