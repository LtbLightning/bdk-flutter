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
        Network.TESTNET);
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


  restoreWallet(String mnemonic, Network network) async {
    final resWallet = await  bdkFlutter.createWallet(
        mnemonic: mnemonic,
        network: network,
        blockchainConfig: BlockchainConfig.electrum(
            config: ElectrumConfig(
                stopGap: 10,
                retry: 5,
                url: "ssl://electrum.blockstream.info:60002"))
    );
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

getConfirmedTransactions() async {
    final res = await bdkFlutter.getConfirmedTransactions();
    for (var e in res) {
      print(e.details.txid);
    }
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

  getPublicDescriptor() async {
    final res= await bdkFlutter.getPublicDescriptor();
    print(res);
  }

  sendBit() async {
    final psbt = await bdkFlutter.createTx(
        recipient: "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt",
        amount: 1200,
        feeRate: 1);
    final sbt = await bdkFlutter.signTx(psbt: psbt);
    final txid = await bdkFlutter.broadcastTx(sbt: sbt);
    print(txid);
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
                  child: const Text('Press to  send 1200 sats')),
              TextButton(
                  onPressed: () => sync(), child: const Text('Press to  sync')),
              TextButton(
                  onPressed: () => getConfirmedTransactions(),
                  child: const Text('Get ConfirmedTransactions')),
              TextButton(
                  onPressed: () => getPendingTransactions(),
                  child: const Text('get PendingTransactions')),
              TextButton(
                  onPressed: () => getBalance(),
                  child: const Text('get Balance')),
              TextButton(
                  onPressed: () => getPublicDescriptor(),
                  child: const Text('get Public Key')),
            ],
          ),
        ),
      ),
    );
  }
}