import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bdk_library.dart';

class BdkWallet extends StatefulWidget {
  const BdkWallet({super.key});

  @override
  State<BdkWallet> createState() => _BdkWalletState();
}

class _BdkWalletState extends State<BdkWallet> {
  String displayText = "";
  BigInt balance = BigInt.zero;
  late Wallet wallet;
  EsploraClient? blockchain;
  Connection? connection;
  BdkLibrary lib = BdkLibrary();
  @override
  void initState() {
    restoreWallet();
    super.initState();
  }

  generateMnemonicKeys() async {
    final res = await lib.createMnemonic();
    setState(() {
      displayText = res.toString();
    });
    if (kDebugMode) {
      print(res.toString());
    }
  }

  restoreWallet() async {
    final aliceMnemonic = await Mnemonic.fromString(
        'give rate trigger race embrace dream wish column upon steel wrist rice');
    final aliceDescriptor = await lib.createDescriptor(aliceMnemonic);
    final connection = await Connection.createInMemory();
    wallet = await lib.crateOrLoadWallet(
        aliceDescriptor[0], aliceDescriptor[1], connection);
    setState(() {
      displayText = "Wallets restored";
    });
    await sync(fullScan: true);
    setState(() {
      displayText = "Full scan complete ";
    });
    await getBalance();
  }

  sync({required bool fullScan}) async {
    blockchain ??= await lib.initializeBlockchain();
    await lib.sync(blockchain!, wallet, fullScan);
  }

  getNewAddress() async {
    final addressInfo = lib.revealNextAddress(wallet);
    debugPrint(addressInfo.address.toString());

    setState(() {
      displayText =
          "Address: ${addressInfo.address.toString()} \n Index: ${addressInfo.index}";
    });
  }

  getUnConfirmedTransactions() async {
    final unConfirmed = lib.getUnConfirmedTransactions(wallet);
    setState(() {
      displayText = "You have ${unConfirmed.length} unConfirmed transactions";
    });
    for (var e in unConfirmed) {
      final txOut = e.transaction.output();
      final tx = e.transaction;
      if (kDebugMode) {
        print(" txid: ${tx.computeTxid()}");
        print(" output address: ${txOut.last.scriptPubkey.bytes}");
        print("===========================");
      }
    }
  }

  getConfirmedTransactions() async {
    final confirmed = lib.getConfirmedTransactions(wallet);
    setState(() {
      displayText = "You have ${confirmed.length} confirmed transactions";
    });
    for (var e in confirmed) {
      if (kDebugMode) {
        print(" txid: ${e.transaction.computeTxid()}");
        final txIn = e.transaction.input();
        final txOut = e.transaction.output();
        print("=============TxIn==============");
        for (var e in txIn) {
          print("         script: ${e.scriptSig}");
          print("         previousOutout Txid: ${e.previousOutput.txid}");
          print("         previousOutout vout: ${e.previousOutput.vout}");
          print("         witness: ${e.witness}");
        }
        print("=============TxOut==============");
        for (var e in txOut) {
          print("         script: ${e.scriptPubkey.bytes}");
          print("         value: ${e.value}");
        }
        print("========================================");
      }
    }
  }

  getBalance() async {
    final alice = await lib.getBalance(wallet);
    setState(() {
      balance = alice.total;
      displayText =
          "Total Balance: ${alice.total} \n Immature Balance: ${alice.immature}";
    });
  }

  listUnspent() async {
    final res = lib.listUnspent(wallet);
    for (var e in res) {
      setState(() {
        displayText =
            " OutPoint: { txid:${res.first.outpoint.txid}, vout: ${res.first.outpoint.vout} }";
      });
      if (kDebugMode) {
        print("isSpent: ${e.isSpent}");
        print(
            "outPoint: { txid:${e.outpoint.txid}, vout: ${e.outpoint.vout} } ");
        print(
            "txout: { address:${e.txout.scriptPubkey.bytes}, value: ${e.txout.value} }");
        print("===========================");
      }
    }
  }

  sendBit(int amountSat) async {
    await lib.sendBitcoin(blockchain!, wallet,
        "tb1qyhssajdx5vfxuatt082m9tsfmxrxludgqwe52f", amountSat);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: false,
          title: const Text('Bdk Wallet',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Colors.white)), // Set this heigh
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Response: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    Expanded(
                      child: SelectableText(
                        displayText,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    balance.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: Colors.blue),
                  ),
                  const Text(
                    " sats",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () => getNewAddress(),
                  child: const Text(
                    'Press to create new Address',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () async {
                    await sync(fullScan: false);
                  },
                  child: const Text(
                    'Press to  sync',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => getConfirmedTransactions(),
                  child: const Text(
                    'Get ConfirmedTransactions',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => getUnConfirmedTransactions(),
                  child: const Text(
                    'getPendingTransactions',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => getBalance(),
                  child: const Text(
                    'get Balance',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => listUnspent(),
                  child: const Text(
                    'list Unspent',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => sendBit(100000),
                  child: const Text(
                    'Press to send 1200 satoshi',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => generateMnemonicKeys(),
                  child: const Text(
                    'generate Mnemonic',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
