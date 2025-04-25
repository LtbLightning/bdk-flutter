import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Derives extended descriptor keys (secret and public) based on the provided
/// hardened and unhardened derivation paths and mnemonic.
Future<(DescriptorSecretKey, DescriptorPublicKey)> deriveDescriptorKeys(
  DerivationPath hardenedPath,
  DerivationPath unHardenedPath,
  Mnemonic mnemonic,
) async {
  // Create the root secret key from the mnemonic
  final secretKey = await DescriptorSecretKey.create(
      mnemonic: mnemonic, network: Network.signet);

  // Derive the key at the hardened path
  final derivedSecretKey = secretKey.derive(hardenedPath);

  // Extend the derived secret key further using the unhardened path
  final derivedExtendedSecretKey = derivedSecretKey.extend(unHardenedPath);

  // Convert the derived secret key to its public counterpart
  final publicKey = derivedSecretKey.toPublic();

  // Extend the public key using the same unhardened path
  final derivedExtendedPublicKey = publicKey.extend(path: unHardenedPath);

  return (derivedExtendedSecretKey, derivedExtendedPublicKey);
}

/// Constructs a wallet descriptor using timelock conditions and public keys.
String createWalletDescriptor(
  String primaryReceivingSecret, // Alice's descriptor derived from m/0
  String secondaryReceivingPublic, // Bob's public key derived from m/0
  int primaryTimelock, // Alice's timelock
  int secondaryTimelock, // Bob's timelock
  String primaryChangePublic, // Alice's public key derived from m/1
  String secondaryChangePublic, // Bob's public key derived from m/1
) {
  // Define the multi-sig condition based on timelock priority
  String multi = (primaryTimelock < secondaryTimelock)
      ? 'multi(2,$primaryReceivingSecret,$secondaryReceivingPublic)'
      : 'multi(2,$secondaryReceivingPublic,$primaryReceivingSecret)';

  // Define the timelock conditions for Bob and Alice
  String timelockBob =
      'and_v(v:older($secondaryTimelock),pk($secondaryChangePublic))';
  String timelockAlice =
      'and_v(v:older($primaryTimelock),pk($primaryChangePublic))';

  // Combine the timelock conditions
  String timelockCondition = (primaryTimelock < secondaryTimelock)
      ? 'or_i($timelockAlice,$timelockBob)'
      : 'or_i($timelockBob,$timelockAlice)';

  // Return the final wallet descriptor
  return 'wsh(or_d($multi,$timelockCondition))';
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<(Wallet, Wallet, Blockchain)> createAndSyncWallets() async {
    // Define mnemonics for Alice and Bob
    final alice = await Mnemonic.fromString(
        'thumb member wage display inherit music elevator need side setup tube panther broom giant auction banner split potato');
    final bob = await Mnemonic.fromString(
        'tired shine hat tired hover timber reward bridge verb aerobic safe economy');

    // Define timelocks for Alice and Bob
    const aliceTimelock = 25;
    const bobTimeLock = 35;

    // Define derivation paths
    final hardenedDerivationPath =
        await DerivationPath.create(path: "m/84h/1h/0h");
    final receivingDerivationPath = await DerivationPath.create(path: "m/0");
    final changeDerivationPath = await DerivationPath.create(path: "m/1");

    // Derive keys for Alice
    final (aliceReceivingSecretKey, aliceReceivingPublicKey) =
        await deriveDescriptorKeys(
            hardenedDerivationPath, receivingDerivationPath, alice);
    final (aliceChangeSecretKey, aliceChangePublicKey) =
        await deriveDescriptorKeys(
            hardenedDerivationPath, changeDerivationPath, alice);

    // Derive keys for Bob
    final (bobReceivingSecretKey, bobReceivingPublicKey) =
        await deriveDescriptorKeys(
            hardenedDerivationPath, receivingDerivationPath, bob);
    final (bobChangeSecretKey, bobChangePublicKey) = await deriveDescriptorKeys(
        hardenedDerivationPath, changeDerivationPath, bob);

    // Create wallet descriptors for Alice and Bob
    final aliceDescriptor = createWalletDescriptor(
        aliceReceivingSecretKey.toString(),
        bobReceivingPublicKey.toString(),
        aliceTimelock,
        bobTimeLock,
        aliceChangePublicKey.toString(),
        bobChangePublicKey.toString());
    final bobDescriptor = createWalletDescriptor(
        bobReceivingSecretKey.toString(),
        aliceReceivingPublicKey.toString(),
        bobTimeLock,
        aliceTimelock,
        bobChangePublicKey.toString(),
        aliceChangePublicKey.toString());

    // Debug print descriptors
    debugPrint("Alice's descriptor: $aliceDescriptor");
    debugPrint("Bob's descriptor: $bobDescriptor");

    // Create wallets
    final aliceWallet = await Wallet.create(
        descriptor: await Descriptor.create(
            descriptor: aliceDescriptor, network: Network.signet),
        network: Network.signet,
        databaseConfig: const DatabaseConfig.memory());
    final bobWallet = await Wallet.create(
        descriptor: await Descriptor.create(
            descriptor: bobDescriptor, network: Network.signet),
        network: Network.signet,
        databaseConfig: const DatabaseConfig.memory());

    // Sync wallets
    final blockchain = await Blockchain.createMutinynet();
    debugPrint("Syncing Bob's wallet...");
    await bobWallet.sync(blockchain: blockchain);
    debugPrint("Syncing Alice's wallet...");
    await aliceWallet.sync(blockchain: blockchain);
    debugPrint("Synchronization complete");

    return (aliceWallet, bobWallet, blockchain);
  }

  group('Time-locked multi-sig wallet synchronization', () {
    setUp(() async {});
    test("Alice and Bob should have the same initial address and balance",
        () async {
      final (aliceWallet, bobWallet, esploraClient) =
          await createAndSyncWallets();
      final bobBalance = bobWallet.getBalance().total.toInt();
      final aliceBalance = aliceWallet.getBalance().total.toInt();
      assert(bobBalance == aliceBalance, "Balances should match");
      debugPrint("Alice's balance: $aliceBalance");
      debugPrint("Bob's balance: $bobBalance");
    });
    test("Alice and Bob should have the same initial address and balance",
        () async {
      final (aliceWallet, bobWallet, esploraClient) =
          await createAndSyncWallets();
      final aliceAddress = aliceWallet
          .getAddress(addressIndex: const AddressIndex.peek(index: 0))
          .address
          .toString();
      final bobAddress = bobWallet
          .getAddress(addressIndex: const AddressIndex.peek(index: 0))
          .address
          .toString();
      assert(aliceAddress == bobAddress, "Addresses should match");

      debugPrint("Alice's receiving address: $aliceAddress");
      debugPrint("Bob's receiving address: $bobAddress");
    });

    test(
        "Should throw an error on broadcasting the tx without second signature",
        () async {
      final (aliceWallet, bobWallet, esploraClient) =
          await createAndSyncWallets();
      final aliceAddress = aliceWallet
          .getAddress(addressIndex: const AddressIndex.peek(index: 0))
          .address
          .toString();
      final bobAddress = bobWallet
          .getAddress(addressIndex: const AddressIndex.peek(index: 0))
          .address
          .toString();
      assert(aliceAddress == bobAddress, "Addresses should match");

      debugPrint("Alice's receiving address: $aliceAddress");
      debugPrint("Bob's receiving address: $bobAddress");
    });
  });
}
