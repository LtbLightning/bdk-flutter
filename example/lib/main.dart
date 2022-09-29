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
  BdkWallet bdkWallet = BdkWallet();
  late ResponseWallet wallet;
  @override
  void initState() {
    restoreWallet(
       "puppy interest whip tonight dad never sudden response push zone pig patch",
        Network.TESTNET);
    // restoreWalletFromDescriptors();
    // generateDescriptors();
    super.initState();
  }
  generateMnemonicKeys() async{
    var mnemonicWithEntropy = await generateMnemonic(entropy: Entropy.Entropy192);
    var mnemonicDefault = await generateMnemonic();
    print("mnemonicWithEntropy: $mnemonicWithEntropy ");
    print("mnemonicDefault: $mnemonicDefault");
  }

  generateDescriptors() async {
    var aliceDescriptor = await createDescriptor(
        mnemonic: "puppy interest whip tonight dad never sudden response push zone pig patch",
        network: Network.TESTNET,
        type: Descriptor.MULTI,
        publicKeys: [
          "tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*",
          "tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*"
        ],
        threshold: 1,
        descriptorPath: 'm/0',
        changeDescriptorPath:'m/1'
    );

    var bobDescriptor = await createDescriptor(
        mnemonic: "master amused swim decline spice nasty juice craft spoil two figure love",
        network: Network.TESTNET,
        type: Descriptor.MULTI,
        publicKeys: [
          "tpubD6NzVbkrYhZ4Ypz1zy41nMPDvELhgP3Zf65SBZ3qwmsKwohtNaPvhZEYPhrRkbd7YGvVEpbp6Jx7kKdimJBX74iyb7VyKCWEgT9PfnsmmxX/*",
          "tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*"
        ],
        threshold: 1,
        descriptorPath: 'm/0',
        changeDescriptorPath:'m/1'
    );

    var daveDescriptor = await createDescriptor(
        mnemonic: "science source gallery fresh gallery vanish lamp deal home flash behave frog",
        network: Network.TESTNET,
        type: Descriptor.MULTI,
        publicKeys: [
          "tpubD6NzVbkrYhZ4Y7vS12GNPcMGdG8bqsASki27XzHKA8rG2WWXMW8wi8aLQUZEUp9BsY4rk2PEDcJa7uhzRAecdgrPFSCKQHGKLtfbxPtJpke/*",
          "tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/*"
        ],
        threshold: 1,
        descriptorPath: 'm/0',
        changeDescriptorPath:'m/1'
    );

    // print("Alice Descriptor: ${aliceDescriptor.descriptor}");
    // print("Alice ChangeDescriptor: ${aliceDescriptor.changeDescriptor}");
    // print("Bob Descriptor: ${bobDescriptor.descriptor}");
    // print("Bob ChangeDescriptor: ${bobDescriptor.changeDescriptor}");
    // print("Dave Descriptor: ${daveDescriptor.descriptor}");
    // print("Dave ChangeDescriptor: ${daveDescriptor.changeDescriptor}");
  }

  restoreWallet(String mnemonic, Network network) async {
    final key =await createDescriptor(
        descriptorPath: "m/84'/0'/0'",
        changeDescriptorPath: "m/84'/0'/1'",
        type: Descriptor.P2WPKH,
      mnemonic: mnemonic,
      network: network
    );
    print(key.descriptor);
    print(key.changeDescriptor);
    var resWallet = await bdkWallet.createWallet(
         mnemonic: mnemonic,
        network: network,
        blockChainConfigUrl: "ssl://electrum.blockstream.info:60002",
        blockchain: Blockchain.ELECTRUM);
    print(resWallet.address);
    print(resWallet.balance.total);
  }

  sync() async {
    bdkWallet.syncWallet();
  }

  getNewAddress() async {
    final res =   await bdkWallet.getNewAddress();
    print(res);
    return res;
  }

  Future<List<Transaction>> getConfirmedTransactions() async {
    final res = await BdkWallet().getConfirmedTransactions();
    for (var e in res) {
      print(e.details.txid);
    }
    return res;
  }

  getPendingTransactions() async {
    final res = await BdkWallet().getPendingTransactions();
    if (res.isEmpty) print("No Pending Transactions");
    for (var e in res) {
      print(e.details.txid);
    }
  }

  getBalance() async {
    final res = await bdkWallet.getBalance();
    print(res.toString());
  }

  getXpubFromMnemonic() async {
    var aliceKey = await  createExtendedKey(network: Network.TESTNET, mnemonic:  "puppy interest whip tonight dad never sudden response push zone pig patch");
    var bobKey = await  createExtendedKey(network: Network.TESTNET, mnemonic: "master amused swim decline spice nasty juice craft spoil two figure love");
    var daveKey = await createExtendedKey(network: Network.TESTNET, mnemonic: "science source gallery fresh gallery vanish lamp deal home flash behave frog");

    print("Bob: ${bobKey.xprv}");
    print("Dave: ${daveKey.xpub}");
    print("Alice: ${aliceKey.xprv}");
  }

  sendBit() async {
    final txid =  await BdkWallet().quickSend(recipient: "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt", amount: 1200, feeRate: 1);
    print(txid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Bdk Flutter',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                fontWeight: FontWeight.w900),),
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
            ],
          ),
        ),
      ),
    );
  }
}

