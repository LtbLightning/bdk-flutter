import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter_example/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String displayText = "";
  int balance = 0;
  late Wallet bobWallet;
  late Wallet aliceWallet;
  Blockchain? blockchain;
  BdkRepository repository = BdkRepository();
  @override
  void initState() {
    restoreWallet();
    super.initState();
  }

  generateMnemonicKeys() async {
    final res = await repository.createMnemonic();
    setState(() {
      displayText = res.toString();
    });
    if (kDebugMode) {
      print(res.asString());
    }
  }

  restoreWallet() async {
    final descriptors = await createDescriptorSecret();
    bobWallet = await repository.restoreWallet(descriptors[0]);
    aliceWallet = await repository.restoreWallet(descriptors[1]);
    setState(() {
      displayText = "Wallet restored";
    });
  }

  Future<List<Descriptor>> createDescriptorSecret() async {
    final mnemonic1 = await Mnemonic.fromString(
        'thumb member wage display inherit music elevator need side setup tube panther broom giant auction banner split potato');
    final mnemonic2 = await Mnemonic.fromString(
        'puppy interest whip tonight dad never sudden response push zone pig patch');
    final bobDescriptor = await repository.createDescriptorSecret(mnemonic1);
    final aliceDescriptor = await repository.createDescriptorSecret(mnemonic2);
    return [bobDescriptor, aliceDescriptor];
  }

  initBlockchain(bool isElectrumBlockchain) async {
    blockchain = await repository.initializeBlockchain(isElectrumBlockchain);
  }

  sync() async {
    if (blockchain == null) {
      await initBlockchain(false);
    }
    await repository.sync(blockchain!, bobWallet);
    await repository.sync(blockchain!, aliceWallet);
  }

  getNewAddress() async {
    final res = await repository.getAddress(aliceWallet);
    debugPrint(res.address);
    setState(() {
      displayText = "Address: ${res.address} \n Index: ${res.index}";
    });
  }

  getUnConfirmedTransactions() async {
    final unConfirmed = await repository.getUnConfirmedTransactions(bobWallet);
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
        print(" output address: ${txOut.last.scriptPubkey.internal}");
        print("===========================");
      }
    }
  }

  getConfirmedTransactions() async {
    final confirmed = await repository.getConfirmedTransactions(bobWallet);
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
          print("         script: ${e.scriptPubkey.internal}");
          print("         value: ${e.value}");
        }
        print("========================================");
      }
    }
  }

  getBalance() async {
    final res = await repository.getBalance(bobWallet);
    final alice = await repository.getBalance(aliceWallet);
    debugPrint(alice.total.toString());
    setState(() {
      balance = res.total;
      displayText =
          "Total Balance: ${res.total} \n Immature Balance: ${res.immature}";
    });
  }

  listUnspent() async {
    final res = await repository.listUnspend(aliceWallet);
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
            "txout: { address:${e.txout.scriptPubkey.internal.toString()}, value: ${e.txout.value} }");
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
    final blockHash = await blockchain!.getBlockHash(height);
    setState(() {
      displayText = "BlockHash: $blockHash";
    });
    if (kDebugMode) {
      print(blockHash);
    }
  }

  sendBit() async {
    await repository.sendBitcoin(blockchain!, aliceWallet, bobWallet,
        "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
