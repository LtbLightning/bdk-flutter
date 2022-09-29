import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bdk_flutter/bdk_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BdkFlutter bdkFlutter = BdkFlutter();
  late ResponseWallet wallet;
  @override
  void initState() {
    restoreWallet(
        "puppy interest whip tonight dad never sudden response push zone pig patch",
        //"science source gallery fresh gallery vanish lamp deal home flash behave frog",
        Network.TESTNET);

    //restoreWalletFromDescriptors();
    //  generateDescriptors();
    //generateMnemonicKeys();
    super.initState();
  }

  generateMnemonicKeys() async {
    var mnemonicWithEntropy =
        await generateMnemonic(entropy: Entropy.ENTROPY128);
    var mnemonicWithEntropy2 =
        await generateMnemonic(entropy: Entropy.ENTROPY192);
    var mnemonicWithEntropy5 =
        await generateMnemonic(entropy: Entropy.ENTROPY256);
    print("mnemonicWithEntropy: $mnemonicWithEntropy ");
    print("mnemonicWithEntropy: $mnemonicWithEntropy2 ");
    print("mnemonicWithEntropy: $mnemonicWithEntropy5 ");
  }

  generateDescriptors() async {
    var aliceDescriptor = await createDescriptor(
        mnemonic:
            "puppy interest whip tonight dad never sudden response push zone pig patch",
        network: Network.TESTNET,
        type: Descriptor.MULTI,
        publicKeys: [
          "tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*",
          "tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*"
        ],
        threshold: 1,
        descriptorPath: 'm/0',
        changeDescriptorPath: 'm/1');

    var bobDescriptor = await createDescriptor(
        mnemonic:
            "master amused swim decline spice nasty juice craft spoil two figure love",
        network: Network.TESTNET,
        type: Descriptor.MULTI,
        publicKeys: [
          "tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*",
          "tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*"
        ],
        threshold: 1,
        descriptorPath: 'm/0',
        changeDescriptorPath: 'm/1');

    var daveDescriptor = await createDescriptor(
        mnemonic:
            "science source gallery fresh gallery vanish lamp deal home flash behave frog",
        network: Network.TESTNET,
        type: Descriptor.MULTI,
        publicKeys: [
          "tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*",
          "tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*"
        ],
        threshold: 1,
        descriptorPath: 'm/0',
        changeDescriptorPath: 'm/1');

    print("Alice Descriptor: ${aliceDescriptor.descriptor}");
    print("Alice ChangeDescriptor: ${aliceDescriptor.changeDescriptor}");
    print("Bob Descriptor: ${bobDescriptor.descriptor}");
    print("Bob ChangeDescriptor: ${bobDescriptor.changeDescriptor}");
    print("Dave Descriptor: ${daveDescriptor.descriptor}");
    print("Dave ChangeDescriptor: ${daveDescriptor.changeDescriptor}");
  }


  restoreWalletFromDescriptors() async {
    var aliceWallet = await bdkFlutter.createWallet(
        descriptor:
            "wsh(multi(1,[d91e6add/0]tprv8dAegvLT1CZ6rzZPQLjnWJQvB8W6yXecQQ9gLbJKyuYRFGoAR1niu1DjdpERVZGPcuu1ZxkAjDnwxJWCQ24AoqzAoyUrFeuzAiYc5RwbkkE/*,"
            "tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*,"
            "tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*))",
        changeDescriptor:
            "wsh(multi(1,[d91e6add/1]tprv8dAegvLT1CZ6tzXM9HEND19DKkQKHQihXLrubw2a2AYz8cJb49BqN36peiQBhmY2LHw36oHm8tjCmU49tVA7MSGe6n8Ku68TfUshoKZwRNe/*,"
            "tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*,"
            "tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*))",
        network: Network.TESTNET,
        databaseConfig: const DatabaseConfig.memory(),
        blockchainConfig: BlockchainConfig.esplora(
            config: EsploraConfig(
          baseUrl: "ssl://electrum.blockstream.info:60002",
          timeout: 5,
          stopGap: 10,
        )));

    // var bobWallet = await bdkWallet.createWallet(
    //     descriptor: "wsh(multi(1,[04f28e3e/0]tprv8bcCYCRz5Z3jpfScYvdKgecYJ5WPL6ji9sdjMqhTJA7ze66vAQDQWSTeuM5irB7ydbX1cB7v75NDrH1JiARQJMnzx1b55hvycsq23jWprje/*,tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*,tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*))",
    //     changeDescriptor: "wsh(multi(1,[04f28e3e/1]tprv8bcCYCRz5Z3jt5PkL3F4j3rFdWrmbT3MehW6Du6zP3ZjpZRx36RUtzAhc1QDBQEGtVgvmEVhYDMukEeCGHMG8zZ5CaN7ARwTwk3mFC8e5pM/*,tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*,tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*))",
    //     network: Network.TESTNET,
    //     databaseConfig: const DatabaseConfig.memory(),
    //     blockchainConfig: BlockchainConfig.esplora(config: EsploraConfig(
    //       baseUrl: "ssl://electrum.blockstream.info:60002",
    //       timeout: 5,
    //       stopGap: 10,
    //     )));

    // var daveWallet = await bdkFlutter.createWallet(
    //     descriptor: "wsh(multi(1,[f20279dc/0]tprv8dMG977nxe1x19vutKKBaARhk1sc2SqLdBgHdwpmczdtBUhK6hqDipjHqgqUkgZ3PtGjvKiwNDjriBmQKj9JgPEmsYmFaJpHqqRg6i2TNav/*,tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*,tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*))",
    //     changeDescriptor: "wsh(multi(1,[f20279dc/1]tprv8dMG977nxe1x4xSD7kxthnbUVammyMGCW3Xu22kZsgPeVcABDaUEPDwqwqJ1n6p9RkLPUY6xs1kXb4x7RYxhUF1asdCqiLqW56Q9maWiTxh/*,tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*,tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*))",
    //     network: Network.TESTNET,
    //     databaseConfig: const DatabaseConfig.memory(),
    //     blockchainConfig: BlockchainConfig.electrum(
    //         config: ElectrumConfig(
    //       url: "ssl://electrum.blockstream.info:60002",
    //       timeout: 5,
    //       stopGap: 10, retry: 10,
    //     )
    //     )
    // );
  }

  restoreWallet(String mnemonic, Network network) async {
    final key = await createDescriptor(
        descriptorPath: "m/84'/0'/0'",
        changeDescriptorPath: "m/84'/0'/1'",
        type: Descriptor.P2WPKH,
        mnemonic: mnemonic,
        network: network);
    print(key.descriptor);
    print(key.changeDescriptor);
    var resWallet = await  bdkFlutter.createWallet(
        mnemonic: mnemonic,
        network: network,
        blockchainConfig: BlockchainConfig.electrum(
            config: ElectrumConfig(
                stopGap: 10,
                retry: 5,
                url: "ssl://electrum.blockstream.info:60002")));
    print(resWallet.address);
    print(resWallet.balance.total);
  }

  sync() async {
    bdkFlutter.syncWallet();
  }

  getBlockHeightAndHash() async {
    final height = await bdkFlutter.getBlockchainHeight();
    print(height);
    final hash = await bdkFlutter.getBlockchainHash(height);
    print(hash);
  }

  Future<String> getNewAddress() async {
    final res = await bdkFlutter.getNewAddress();
    print(res);
    return res;
  }

  Future<List<Transaction>> getConfirmedTransactions() async {
    final res = await bdkFlutter.getConfirmedTransactions();
    for (var e in res) {
      print(e.details.txid);
    }
    return res;
  }

  getPendingTransactions() async {
    final res = await bdkFlutter.getPendingTransactions();
    if (res.isEmpty) print("No Pending Transactions");
    for (var e in res) {
      print(e.details.txid);
    }
  }

  getBalance() async {
    final res = await bdkFlutter.getBalance();
    print(res.total);
  }

  getXpubFromMnemonic() async {
    var aliceKey = await createExtendedKey(
        network: Network.TESTNET,
        mnemonic:
            "puppy interest whip tonight dad never sudden response push zone pig patch");
    var bobKey = await createExtendedKey(
        network: Network.TESTNET,
        mnemonic:
            "master amused swim decline spice nasty juice craft spoil two figure love");
    var daveKey = await createExtendedKey(
        network: Network.TESTNET,
        mnemonic:
            "science source gallery fresh gallery vanish lamp deal home flash behave frog");
    print("Bob: ${bobKey.xpub}");
    print("Dave: ${daveKey.xprv}");
    print("Alice: ${aliceKey.xprv}");
  }


  sendBit() async {
    final txid = await bdkFlutter.quickSend(
        recipient: "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt",
        amount: 1200,
        feeRate: 1);
    print(txid);
  }

  exportWallet() async {
    final res = await bdkFlutter.exportWallet(walletName: "TestWallet");
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Bdk Flutter',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => getNewAddress(),
                  child: const Text('Press to create new Address')),
              TextButton(
                  onPressed: () => sendBit(),
                  child: const Text('Press to  send 1200 satoshi')),
              TextButton(
                  onPressed: () => sync(), child: const Text('Press to  sync')),
              TextButton(
                  onPressed: () => getConfirmedTransactions(),
                  child: const Text('Get ConfirmedTransactions')),
              TextButton(
                  onPressed: () => getPendingTransactions(),
                  child: const Text('getPendingTransactions')),
              TextButton(
                  onPressed: () => getBalance(),
                  child: const Text('get Balance')),
              TextButton(
                  onPressed: () => getXpubFromMnemonic(),
                  child: const Text('get Public Key')),
              TextButton(
                  onPressed: () => getBlockHeightAndHash(),
                  child: const Text('get Blockchain info')),
            ],
          ),
        ),
      ),
    );
  }
}
