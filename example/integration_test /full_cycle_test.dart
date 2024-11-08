import 'dart:typed_data';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Descriptor & Wallet', () {
    setUp(() async {});
    testWidgets('generating psbt using a muti-sig wallet', (_) async {
      final externalDescriptor = await Descriptor.create(
          descriptor:
              "wsh(thresh(2,pk(tpubD6NzVbkrYhZ4XJBfEJ6gt9DiVdfWJijsQTCE3jtXByW3Tk6AVGQ3vL1NNxg3SjB7QkJAuutACCQjrXD8zdZSM1ZmBENszCqy49ECEHmD6rf/0/*),sj:and_v(v:pk(tpubD6NzVbkrYhZ4YfAr3jCBRk4SpqB9L1Hh442y83njwfMaker7EqZd7fHMqyTWrfRYJ1e5t2ue6BYjW5i5yQnmwqbzY1a3kfqNxog1AFcD1aE/0/*),n:older(6)),snj:and_v(v:pk(tprv8ZgxMBicQKsPeitVUz3s6cfyCECovNP7t82FaKPa4UKqV1kssWcXgLkMDjzDbgG9GWoza4pL7z727QitfzkiwX99E1Has3T3a1MKHvYWmQZ/0/*),after(630000))))",
          network: Network.signet);
      final internalDescriptor = await Descriptor.create(
          descriptor:
              "wsh(thresh(2,pk(tpubD6NzVbkrYhZ4XJBfEJ6gt9DiVdfWJijsQTCE3jtXByW3Tk6AVGQ3vL1NNxg3SjB7QkJAuutACCQjrXD8zdZSM1ZmBENszCqy49ECEHmD6rf/1/*),sj:and_v(v:pk(tpubD6NzVbkrYhZ4YfAr3jCBRk4SpqB9L1Hh442y83njwfMaker7EqZd7fHMqyTWrfRYJ1e5t2ue6BYjW5i5yQnmwqbzY1a3kfqNxog1AFcD1aE/1/*),n:older(6)),snj:and_v(v:pk(tprv8ZgxMBicQKsPeitVUz3s6cfyCECovNP7t82FaKPa4UKqV1kssWcXgLkMDjzDbgG9GWoza4pL7z727QitfzkiwX99E1Has3T3a1MKHvYWmQZ/1/*),after(630000))))",
          network: Network.signet);

      final wallet = await Wallet.create(
          descriptor: externalDescriptor,
          changeDescriptor: internalDescriptor,
          network: Network.signet,
          databaseConfig: const DatabaseConfig.memory());
      final blockchain = await Blockchain.createMutinynet();
      wallet.sync(blockchain: blockchain);
      debugPrint("Wallet balance: ${wallet.getBalance().total}");
      final toAddress = wallet
          .getAddress(addressIndex: const AddressIndex.increase())
          .address;
      debugPrint("Wallet address: ${toAddress.toString()}");
      final externalWalletPolicy = wallet.policies(KeychainKind.externalChain);
      final ineternalWalletPolicy = wallet.policies(KeychainKind.internalChain);
      if (externalWalletPolicy != null && ineternalWalletPolicy != null) {
        // Construct external and internal policy paths
        final extPath = {
          ineternalWalletPolicy.id(): Uint32List.fromList([0, 1])
        };
        debugPrint("External Policy path: $extPath\n");

        final intPath = {
          ineternalWalletPolicy.id(): Uint32List.fromList([0, 1])
        };
        debugPrint("Internal Policy Path: $intPath\n");

        // Build the transaction
        final txBuilder = TxBuilder()
            .addRecipient(
              toAddress.scriptPubkey(),
              BigInt.from(1000),
            )
            .doNotSpendChange()
            .policyPath(KeychainKind.internalChain, intPath)
            .policyPath(KeychainKind.externalChain, extPath);

        final (psbt, _) = await txBuilder.finish(wallet);
        debugPrint("Transaction serialized: ${psbt.toString()}\n");
      }
    });
  });
}
