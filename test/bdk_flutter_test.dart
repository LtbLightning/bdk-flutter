import 'dart:convert';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bdk_flutter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Wallet>()])
@GenerateNiceMocks([MockSpec<Transaction>()])
@GenerateNiceMocks([MockSpec<Blockchain>()])
@GenerateNiceMocks([MockSpec<DescriptorSecretKey>()])
@GenerateNiceMocks([MockSpec<DescriptorPublicKey>()])
@GenerateNiceMocks([MockSpec<PartiallySignedTransaction>()])
@GenerateNiceMocks([MockSpec<TxBuilder>()])
@GenerateNiceMocks([MockSpec<BumpFeeTxBuilder>()])
@GenerateNiceMocks([MockSpec<ScriptBuf>()])
@GenerateNiceMocks([MockSpec<Address>()])
@GenerateNiceMocks([MockSpec<DerivationPath>()])
@GenerateNiceMocks([MockSpec<FeeRate>()])
@GenerateNiceMocks([MockSpec<LocalUtxo>()])
@GenerateNiceMocks([MockSpec<TransactionDetails>()])
void main() {
  final mockWallet = MockWallet();
  final mockBlockchain = MockBlockchain();
  final mockDerivationPath = MockDerivationPath();
  final mockAddress = MockAddress();
  final mockScript = MockScriptBuf();
  group('Blockchain', () {
    test('verify getHeight', () async {
      when(mockBlockchain.getHeight()).thenAnswer((_) async => 2396450);
      final res = await mockBlockchain.getHeight();
      expect(res, 2396450);
    });
    test('verify getHash', () async {
      when(mockBlockchain.getBlockHash(height: any)).thenAnswer((_) async =>
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
      final res = await mockBlockchain.getBlockHash(height: 2396450);
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
      when(mockBlockchain.getBlockHash(height: any)).thenAnswer((_) async =>
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
      final res = await mockBlockchain.getBlockHash(height: 2396450);
      expect(res,
          "0000000000004c01f2723acaa5e87467ebd2768cc5eadcf1ea0d0c4f1731efce");
    });
  });
  group('Wallet', () {
    test('Should return valid AddressInfo Object', () async {
      final res = mockWallet.getAddress(addressIndex: AddressIndex.increase());
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
      expect(res, isA<List<LocalUtxo>>());
    });
    test('Should return a Input object', () async {
      final res =
          mockWallet.getPsbtInput(utxo: MockLocalUtxo(), onlyWitnessUtxo: true);
      expect(res, isA<Input>());
    });
    test('Should return a Descriptor object', () async {
      final res = await mockWallet.getDescriptorForKeychain(
          keychain: KeychainKind.externalChain);
      expect(res, isA<Descriptor>());
    });
    test('Should return an empty list of TransactionDetails', () async {
      when(mockWallet.listTransactions(includeRaw: any))
          .thenAnswer((e) => List.empty());
      final res = mockWallet.listTransactions(includeRaw: true);
      expect(res, isA<List<TransactionDetails>>());
      expect(res, List.empty());
    });
    test('verify function call order', () async {
      await mockWallet.sync(blockchain: mockBlockchain);
      mockWallet.listTransactions(includeRaw: true);
      verifyInOrder([
        await mockWallet.sync(blockchain: mockBlockchain),
        mockWallet.listTransactions(includeRaw: true)
      ]);
    });
  });
  group('DescriptorSecret', () {
    final mockSDescriptorSecret = MockDescriptorSecretKey();

    test('verify asPublic()', () async {
      final res = mockSDescriptorSecret.toPublic();
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify asString', () async {
      final res = mockSDescriptorSecret.asString();
      expect(res, isA<String>());
    });
  });
  group('DescriptorPublic', () {
    final mockSDescriptorPublic = MockDescriptorPublicKey();
    test('verify derive()', () async {
      final res = mockSDescriptorPublic.derive(path: mockDerivationPath);
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify extend()', () async {
      final res = mockSDescriptorPublic.extend(path: mockDerivationPath);
      expect(res, isA<DescriptorPublicKey>());
    });
    test('verify asString', () async {
      final res = mockSDescriptorPublic.asString();
      expect(res, isA<String>());
    });
  });
  group('Tx Builder', () {
    final mockTxBuilder = MockTxBuilder();
    test('Should return a TxBuilderException when funds are insufficient',
        () async {
      try {
        when(mockTxBuilder.finish(mockWallet))
            .thenThrow(InsufficientFundsException());
        mockTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<InsufficientFundsException>());
      }
    });
    test('Should return a TxBuilderException when no recipients are added',
        () async {
      try {
        when(mockTxBuilder.finish(mockWallet))
            .thenThrow(NoRecipientsException());
        mockTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<NoRecipientsException>());
      }
    });
    test('Verify addData() Exception', () async {
      try {
        when(mockTxBuilder.addData(data: List.empty()))
            .thenThrow(InvalidByteException(message: "List must not be empty"));
        mockTxBuilder.addData(data: []);
      } catch (error) {
        expect(error, isA<InvalidByteException>());
      }
    });
    test('Verify unSpendable()', () async {
      final res = mockTxBuilder.addUnSpendable(OutPoint(
          txid:
              "efc5d0e6ad6611f22b05d3c1fc8888c3552e8929a4231f2944447e4426f52056",
          vout: 1));
      expect(res, isNot(mockTxBuilder));
    });
    test('Verify addForeignUtxo()', () async {
      const inputInternal = {
        "non_witness_utxo": {
          "version": 1,
          "lock_time": 2433744,
          "input": [
            {
              "previous_output":
                  "8eca3ac01866105f79a1a6b87ec968565bb5ccc9cb1c5cf5b13491bafca24f0d:1",
              "script_sig":
                  "483045022100f1bb7ab927473c78111b11cb3f134bc6d1782b4d9b9b664924682b83dc67763b02203bcdc8c9291d17098d11af7ed8a9aa54e795423f60c042546da059b9d912f3c001210238149dc7894a6790ba82c2584e09e5ed0e896dea4afb2de089ea02d017ff0682",
              "sequence": 4294967294,
              "witness": []
            }
          ],
          "output": [
            {
              "value": 3356,
              "script_pubkey":
                  "76a91400df17234b8e0f60afe1c8f9ae2e91c23cd07c3088ac"
            },
            {
              "value": 1500,
              "script_pubkey":
                  "76a9149f9a7abd600c0caa03983a77c8c3df8e062cb2fa88ac"
            }
          ]
        },
        "witness_utxo": null,
        "partial_sigs": {},
        "sighash_type": null,
        "redeem_script": null,
        "witness_script": null,
        "bip32_derivation": [
          [
            "030da577f40a6de2e0a55d3c5c72da44c77e6f820f09e1b7bbcc6a557bf392b5a4",
            ["d91e6add", "m/44'/1'/0'/0/146"]
          ]
        ],
        "final_script_sig": null,
        "final_script_witness": null,
        "ripemd160_preimages": {},
        "sha256_preimages": {},
        "hash160_preimages": {},
        "hash256_preimages": {},
        "tap_key_sig": null,
        "tap_script_sigs": [],
        "tap_scripts": [],
        "tap_key_origins": [],
        "tap_internal_key": null,
        "tap_merkle_root": null,
        "proprietary": [],
        "unknown": []
      };
      final input = Input(s: json.encode(inputInternal));
      final outPoint = OutPoint(
          txid:
              'b3b72ce9c7aa09b9c868c214e88c002a28aac9a62fd3971eff6de83c418f4db3',
          vout: 0);
      when(mockAddress.scriptPubkey()).thenAnswer((_) => mockScript);
      when(mockTxBuilder.addRecipient(mockScript, any))
          .thenReturn(mockTxBuilder);
      when(mockTxBuilder.addForeignUtxo(input, outPoint, BigInt.zero))
          .thenReturn(mockTxBuilder);
      when(mockTxBuilder.finish(mockWallet)).thenAnswer((_) async =>
          Future.value(
              (MockPartiallySignedTransaction(), MockTransactionDetails())));
      final script = mockAddress.scriptPubkey();
      final txBuilder = mockTxBuilder
          .addRecipient(script, BigInt.from(1200))
          .addForeignUtxo(input, outPoint, BigInt.zero);
      final res = await txBuilder.finish(mockWallet);
      expect(res, isA<(PartiallySignedTransaction, TransactionDetails)>());
    });
    test('Create a proper psbt transaction ', () async {
      const psbtBase64 = "cHNidP8BAHEBAAAAAfU6uDG8hNUox2Qw1nodiir"
          "QhnLkDCYpTYfnY4+lUgjFAAAAAAD+////Ag5EAAAAAAAAFgAUxYD3fd+pId3hWxeuvuWmiUlS+1PoAwAAAAAAABYAFP+dpWfmLzDqhlT6HV+9R774474TxqQkAAABAN4"
          "BAAAAAAEBViD1JkR+REQpHyOkKYkuVcOIiPzB0wUr8hFmrebQxe8AAAAAAP7///8ClEgAAAAAAAAWABTwV07KrKa1zWpwKzW+ve93pbQ4R+gDAAAAAAAAFgAU/52lZ+YvMOqGVPodX71Hv"
          "vjjvhMCRzBEAiAa6a72jEfDuiyaNtlBYAxsc2oSruDWF2vuNQ3rJSshggIgLtJ/YuB8FmhjrPvTC9r2w9gpdfUNLuxw/C7oqo95cEIBIQM9XzutA2SgZFHjPDAATuWwHg19TTkb/NKZD/"
          "hfN7fWP8akJAABAR+USAAAAAAAABYAFPBXTsqsprXNanArNb6973eltDhHIgYCHrxaLpnD4ed01bFHcixnAicv15oKiiVHrcVmxUWBW54Y2R5q3VQAAIABAACAAAAAgAEAAABbAAAAACICAqS"
          "F0mhBBlgMe9OyICKlkhGHZfPjA0Q03I559ccj9x6oGNkeat1UAACAAQAAgAAAAIABAAAAXAAAAAAA";
      final psbt = await PartiallySignedTransaction.fromString(psbtBase64);
      when(mockAddress.scriptPubkey()).thenAnswer((_) => MockScriptBuf());
      when(mockTxBuilder.addRecipient(mockScript, any))
          .thenReturn(mockTxBuilder);

      when(mockAddress.scriptPubkey()).thenAnswer((_) => mockScript);
      when(mockTxBuilder.finish(mockWallet)).thenAnswer(
          (_) async => Future.value((psbt, MockTransactionDetails())));
      final script = mockAddress.scriptPubkey();
      final txBuilder = mockTxBuilder.addRecipient(script, BigInt.from(1200));
      final res = await txBuilder.finish(mockWallet);
      expect(res.$1, psbt);
    });
  });
  group('Bump Fee Tx Builder', () {
    final mockBumpFeeTxBuilder = MockBumpFeeTxBuilder();
    test('Should return a TxBuilderException when txid is invalid', () async {
      try {
        when(mockBumpFeeTxBuilder.finish(mockWallet))
            .thenThrow(TransactionNotFoundException());
        await mockBumpFeeTxBuilder.finish(mockWallet);
      } catch (error) {
        expect(error, isA<TransactionNotFoundException>());
      }
    });
  });
  group('Address', () {
    test('verify network()', () {
      final res = mockAddress.network();
      expect(res, isA<Network>());
    });
    test('verify payload()', () {
      final res = mockAddress.network();
      expect(res, isA<Network>());
    });
    test('verify scriptPubKey()', () {
      final res = mockAddress.scriptPubkey();
      expect(res, isA<ScriptBuf>());
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
      final res = mockTx.txid();
      expect(res, isA<String>());
    });
    test('verify weight', () async {
      final res = mockTx.weight();
      expect(res, isA<int>());
    });
    test('verify size', () async {
      final res = mockTx.size();
      expect(res, isA<int>());
    });
    test('verify vsize', () async {
      final res = mockTx.vsize();
      expect(res, isA<int>());
    });
    test('verify isCoinbase', () async {
      final res = mockTx.isCoinBase();
      expect(res, isA<bool>());
    });
    test('verify isExplicitlyRbf', () async {
      final res = mockTx.isExplicitlyRbf();
      expect(res, isA<bool>());
    });
    test('verify isLockTimeEnabled', () async {
      final res = mockTx.isLockTimeEnabled();
      expect(res, isA<bool>());
    });
    test('verify version', () async {
      final res = mockTx.version();
      expect(res, isA<int>());
    });
    test('verify lockTime', () async {
      final res = mockTx.lockTime();
      expect(res, isA<int>());
    });
    test('verify input', () async {
      final res = mockTx.input();
      expect(res, isA<List<TxIn>>());
    });
    test('verify output', () async {
      final res = mockTx.output();
      expect(res, isA<List<TxOut>>());
    });
  });
}
