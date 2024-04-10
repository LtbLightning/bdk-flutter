import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter_example/tradeview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bdk_library.dart';

class SimpleWallet extends StatefulWidget {
  const SimpleWallet({super.key});

  @override
  State<SimpleWallet> createState() => _SimpleWalletState();
}

class _SimpleWalletState extends State<SimpleWallet> {
  String displayText = "";
  int balance = 0;
  late Wallet aliceWallet;
  Blockchain? blockchain;
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
      print(await res.asString());
    }
  }

  restoreWallet() async {
    final aliceMnemonic = await Mnemonic.fromString(
        'certain sense kiss guide crumble hint transfer crime much stereo warm coral');
    final aliceDescriptor = await lib.createDescriptor(aliceMnemonic);
    aliceWallet = await lib.restoreWallet(aliceDescriptor);
    setState(() {
      displayText = "Wallets restored";
    });
  }

  initBlockchain(bool isElectrumBlockchain) async {
    blockchain = await lib.initializeBlockchain(isElectrumBlockchain);
  }

  sync() async {
    if (blockchain == null) {
      await initBlockchain(false);
    }
    await lib.sync(blockchain!, aliceWallet);
  }

  getNewAddress() async {
    final res = await lib.getAddress(aliceWallet);
    final address = await res.address.asString();
    setState(() {
      displayText = "Address: $address \n Index: ${res.index}";
    });
  }

  getUnConfirmedTransactions() async {
    final unConfirmed = await lib.getUnConfirmedTransactions(aliceWallet);
    setState(() {
      displayText = "You have ${unConfirmed.length} unConfirmed transactions";
    });
    for (var e in unConfirmed) {
      final txOut = await e.transaction!.output();
      if (kDebugMode) {
        print(" txid: ${e.txid}");
        print(" fee: ${e.fee}");
        print(" received: ${e.received}");
        print(" send: ${e.sent}");
        print(" output address: ${txOut.last.scriptPubkey.bytes}");
        print("===========================");
      }
    }
  }

  getConfirmedTransactions() async {
    final confirmed = await lib.getConfirmedTransactions(aliceWallet);
    setState(() {
      displayText = "You have ${confirmed.length} confirmed transactions";
    });
    for (var e in confirmed) {
      if (kDebugMode) {
        print(" txid: ${e.txid}");
        print(" confirmationTime: ${e.confirmationTime?.timestamp}");
        print(" confirmationTime Height: ${e.confirmationTime?.height}");
        final txIn = await e.transaction!.input();
        final txOut = await e.transaction!.output();
        print("         =============TxIn==============");
        for (var e in txIn) {
          print("         previousOutout Txid: ${e.previousOutput.txid}");
          print("         previousOutout vout: ${e.previousOutput.vout}");
          print("         witness: ${e.witness}");
        }
        print("         =============TxOut==============");
        for (var e in txOut) {
          print("         script: ${e.scriptPubkey.bytes}");
          print("         value: ${e.value}");
        }
        print("========================================");
      }
    }
  }

  getBalance() async {
    final alice = await lib.getBalance(aliceWallet);
    setState(() {
      balance = alice.total;
      displayText =
          "Total Balance: ${alice.total} \n Immature Balance: ${alice.immature}";
    });
  }

  listUnspent() async {
    final res = await lib.listUnspend(aliceWallet);
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
            "txout: { script:${e.txout.scriptPubkey.bytes}, value: ${e.txout.value} }");
        print("===========================");
      }
    }
  }

  Future<int> getBlockHeight() async {
    final res = await blockchain!.getHeight();
    if (kDebugMode) {
      print(res);
    }
    setState(() {
      displayText = "Height: $res";
    });
    return res;
  }

  getBlockHash() async {
    final height = await getBlockHeight();
    final blockHash = await blockchain!.getBlockHash(height: height);
    setState(() {
      displayText = "BlockHash: $blockHash";
    });
    if (kDebugMode) {
      print(blockHash);
    }
  }

  sendBit() async {
    await lib.sendBitcoin(blockchain!, aliceWallet,
        "bcrt1q4ezz5hp9c0vfru9xd8frtj2xuzd78ym467skdu");
  }

  handleTradeView() async {
    final tradeview = TradeView();
    final trade1Destination = (await tradeview.getDestinationAddresses())[0];
    final trade2Destination = (await tradeview.getDestinationAddresses())[1];
    final trade3Destination = (await tradeview.getDestinationAddresses())[2];
    final platformAndChange = await tradeview.getPlatformAndChange(aliceWallet);

    final utxo = (await aliceWallet.listUnspent())
        .firstWhere((e) => e.txout.value > 36000);
    final step1 = await tradeview.openTrade([], [utxo], trade1Destination,
        platformAndChange.$1, platformAndChange.$2[0], 10000, aliceWallet);
    final step2 = await tradeview.openTrade(step1, [utxo], trade2Destination,
        platformAndChange.$1, platformAndChange.$2[1], 10000, aliceWallet);
    final step3 = await tradeview.openTrade(step2, [utxo], trade3Destination,
        platformAndChange.$1, platformAndChange.$2[2], 10000, aliceWallet);
    final step4 =
        await tradeview.closeTrade(step3, step3[0], aliceWallet, blockchain!);
    debugPrint("closed trade: ${step3[0].id.toString()}\n");

    final step5 =
        await tradeview.closeTrade(step4, step4[0], aliceWallet, blockchain!);
    debugPrint("closed trade: ${step4[0].id}\n");
    final step6 =
        await tradeview.closeTrade(step5, step5[0], aliceWallet, blockchain!);
    await lib.sync(blockchain!, aliceWallet);
    if (step6.isEmpty) {
      debugPrint("closed all trades \n");
    }
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
                    await sync();
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
                  onPressed: () => handleTradeView(),
                  child: const Text(
                    'handleTradeView',
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
                  onPressed: () => sendBit(),
                  child: const Text(
                    'Press to send 1200 satoshi',
                    style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w800),
                  )),
              TextButton(
                  onPressed: () => getBlockHash(),
                  child: const Text(
                    'get BlockHash',
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
