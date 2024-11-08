import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Descriptor & Keys', () {
    setUp(() async {});
    testWidgets('Muti-sig wallet generation', (_) async {
      final descriptor = await Descriptor.create(
          descriptor:
              "wsh(or_d(pk([24d87569/84'/1'/0'/0/0]tpubDHebJGZWZaZ3JkhwTx5DytaRpFhK9ffFaN9PMBm7m63bdkdxqKgXkSPMzYzfDAGStx8LWt4b2CgGm86BwtNuG6PdsxsLVmuf6EjREX3oHjL/0/0/*),and_v(v:older(12),pk([24d87569/84'/1'/0'/0/0]tpubDHebJGZWZaZ3JkhwTx5DytaRpFhK9ffFaN9PMBm7m63bdkdxqKgXkSPMzYzfDAGStx8LWt4b2CgGm86BwtNuG6PdsxsLVmuf6EjREX3oHjL/0/1/*))))",
          network: Network.testnet);
      final changeDescriptor = await Descriptor.create(
          descriptor:
              "wsh(or_d(pk([24d87569/84'/1'/0'/1/0]tpubDHebJGZWZaZ3JkhwTx5DytaRpFhK9ffFaN9PMBm7m63bdkdxqKgXkSPMzYzfDAGStx8LWt4b2CgGm86BwtNuG6PdsxsLVmuf6EjREX3oHjL/1/0/*),and_v(v:older(12),pk([24d87569/84'/1'/0'/1/0]tpubDHebJGZWZaZ3JkhwTx5DytaRpFhK9ffFaN9PMBm7m63bdkdxqKgXkSPMzYzfDAGStx8LWt4b2CgGm86BwtNuG6PdsxsLVmuf6EjREX3oHjL/1/1/*))))",
          network: Network.testnet);

      final wallet = await Wallet.create(
          descriptor: descriptor,
          changeDescriptor: changeDescriptor,
          network: Network.testnet,
          connection: await Connection.createInMemory());
      debugPrint(wallet.network().toString());
    });
    testWidgets('Derive descriptorSecretKey Manually', (_) async {
      final mnemonic = await Mnemonic.create(WordCount.words12);
      final descriptorSecretKey = await DescriptorSecretKey.create(
          network: Network.testnet, mnemonic: mnemonic);
      debugPrint(descriptorSecretKey.toString());

      for (var e in [0, 1]) {
        final derivationPath =
            await DerivationPath.create(path: "m/84'/1'/0'/$e");
        final derivedDescriptorSecretKey =
            await descriptorSecretKey.derive(derivationPath);
        debugPrint(derivedDescriptorSecretKey.toString());
        debugPrint(derivedDescriptorSecretKey.toPublic().toString());
        final descriptor = await Descriptor.create(
            descriptor: "wpkh($derivedDescriptorSecretKey)",
            network: Network.testnet);

        debugPrint(descriptor.toString());
      }
    });
  });
}
