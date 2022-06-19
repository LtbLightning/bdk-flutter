import 'package:bdk_flutter/enums/blockchain_enum.dart';
import 'package:bdk_flutter/enums/network_enum.dart';
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
  String walletBalance = 'error';
  String wallet = '';
  String address = '';
  final _bdkFlutterPlugin = BdkFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    restoreWallet();
  }

  Future<void> initPlatformState() async {
    try {
      walletBalance = (await _bdkFlutterPlugin.getBalance())!;
      wallet = (await _bdkFlutterPlugin.getWallet())!;
      setState(() {});
    } catch (e) {
      print(e);
      walletBalance = 'Error Balance';
    }
  }

  createWallet() async {
    await _bdkFlutterPlugin
        .createWallet(
            mnemonic: "test",
            password: "test",
            network: Network.TESTNET,
            blockChain: Blockchain.ELECTRUM,
            blockChainConfigUrl: "ssl://electrum.blockstream.info:60002")
        .then((i) => print(i));
    setState(() {});
  }

  restoreWallet() async {
    await _bdkFlutterPlugin
        .restoreWallet(
            mnemonic:
                "pole account coconut skull draw more coyote sure neutral board large hello",
            password: "test",
            network: Network.TESTNET,
            blockChain: Blockchain.ELECTRUM,
            blockChainConfigUrl: "ssl://electrum.blockstream.info:60002")
        .then((i) => print(i));
    setState(() {});
  }

  sync() async {
    await _bdkFlutterPlugin.sync().then((i) => print(i));
    setState(() {
      initPlatformState();
    });
  }

  getNewAddress() async {
    await _bdkFlutterPlugin.getNewAddress().then((i) {
      setState(() {
        address = i.toString();
      });
      print(i);
    });
  }

  getConfirmedTransactions() async {
    await _bdkFlutterPlugin.getConfirmedTransactions().then((i) {
      print("confirmed result $i");
    });
  }

  getPendingTransactions() async {
    await _bdkFlutterPlugin.getPendingTransactions().then((i) {
      print("pending result $i");
    });
  }

  resetWallet() async {
    await _bdkFlutterPlugin.resetWallet().then((i) {
      print(i);
    });
  }

  sendBit() async {
    //  https://testnet-faucet.mempool.co/ address
    await _bdkFlutterPlugin
        .broadcastTransaction(
            recipient: 'tb1qfzrcgp0tdqe2dnsdc6m9nkacsprdaspagpadr0',
            amount: 1000)
        .then((i) {
      setState(() {
        initPlatformState();
      });
    });
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
              Text(wallet),
              Text('Balance: $walletBalance\n'),
              Text('Address: $address\n'),
              TextButton(
                  onPressed: () => createWallet(),
                  child: const Text('Press to create new Wallet')),
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
                  onPressed: () => resetWallet(),
                  child: const Text('Reset Wallet')),
            ],
          ),
        ),
      ),
    );
  }
}
