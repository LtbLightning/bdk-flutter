import 'dart:convert';
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

  @override
  void initState() {
    //restoreWallet("puppy interest whip tonight dad never sudden response push zone pig patch", Network.TESTNET);
     generateKeys();
    super.initState();
  }

  generateKeys() async{
   var extendedKey =  await  generateExtendedKey(network: Network.REGTEST, wordCount:  WordCount.Words12, entropy: Entropy.Entropy160);
   var xprv = await  createXprv(network: Network.TESTNET, wordCount:  WordCount.Words12, entropy: Entropy.Entropy192);
   var mnemonic = await generateMnemonic(network: Network.TESTNET, wordCount:  WordCount.Words12, entropy: Entropy.Entropy192);
   print("Extended key Fingerprint ${extendedKey.fingerprint}");
   print("private key  $xprv");
   print("mnemonic $mnemonic");

  }

  restoreWallet(String mnemonic, Network network) async {
    var  key = await restoreExtendedKey(network:network, mnemonic:mnemonic);
    var descriptor = createDescriptor(key.xprv);
    var changeDescriptor = createChangeDescriptor(key.xprv);
    bdkWallet.createWallet(
        descriptor:descriptor,
        changeDescriptor:changeDescriptor,
        useDescriptors: true,
        network: network,
        blockChainConfigUrl: "",
        blockchain: Blockchain.ELECTRUM);
    bdkWallet.sync();
    return bdkWallet;
  }

  sync() async {
    bdkWallet.sync();
  }
  getNewAddress() async {
    await bdkWallet.getNewAddress().then((value) => print(value));
  }

  getConfirmedTransactions() async {
    final res =  await bdkWallet.getConfirmedTransactions();
    for (var e in res) {
      print(e.details.txid);
    }
  }

  getPendingTransactions() async {
    final res =  await bdkWallet.getPendingTransactions();
    res.map((e) => print(e.details.txid));
  }
  getBalance() async {
    final res =  await bdkWallet.getBalance();
    print(res.toString());
  }

  sendBit() async {
    await bdkWallet.broadcastTransaction(recipient: "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt", amount: 1200, feeRate: 1);
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
                  onPressed: () =>  getBalance(),
                  child: const Text('get Balance')),
            ],
          ),
        ),
      ),
    );
  }
}
