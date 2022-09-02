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
    generateKeys();
    super.initState();
  }

  generateKeys() async {
    var key = await createExtendedKey(network: Network.TESTNET,
        mnemonic:
        "school alcohol coral light army gather adapt blossom school alcohol coral lens",
        password: "password");
    var descriptor = await createDescriptor(xprv: key.xprv, type: Descriptor.MULTI, threshold:2,
        publicKeys: ["tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*"]
    );
    var changeDescriptor = createChangeDescriptor(descriptor:descriptor );
    var mnemonicWithCount = await generateMnemonic(wordCount: WordCount.Words15);
    var mnemonicWithEntropy = await generateMnemonic(entropy: Entropy.Entropy192);
    var mnemonicDefault = await generateMnemonic();
    print("mnemonicWithCount: $mnemonicWithCount ");
    print("mnemonicWithEntropy: $mnemonicWithEntropy ");
    print("mnemonicDefault: $mnemonicDefault");
    print("descriptor $descriptor");
    print("changeDescriptor $changeDescriptor");
  }

  restoreWallet(String mnemonic, Network network) async {
    var key = await createExtendedKey(network: network, mnemonic: mnemonic);
    var descriptor = await createDescriptor(xprv: key.xprv, type: Descriptor.P2WPKH);
    var changeDescriptor =  createChangeDescriptor(descriptor:descriptor);
    bdkWallet.createWallet(
        descriptor: descriptor,
        changeDescriptor: changeDescriptor,
        network: network,
        blockChainConfigUrl: "ssl://electrum.blockstream.info:60002",
        blockchain: Blockchain.ELECTRUM);
    getNewAddress();
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
  getXpubFromAddress() async {

    final res = await getXpub(
      network: Network.TESTNET,
      mnemonic: "puppy interest whip tonight dad never sudden response push zone pig patch",
    );
    print(res.toString());
  }
  sendBit() async {
    final txid =  await BdkWallet().quickSend(recipient: "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt", amount: 1200, feeRate: 1);
    print(txid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
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
                  onPressed: () => getXpubFromAddress(),
                  child: const Text('get Public Key')),
            ],
          ),
        ),
      ),
    );
  }
}
