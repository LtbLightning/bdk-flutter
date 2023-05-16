import 'dart:convert';
import 'dart:developer';

import 'package:bdk_flutter/bdk_flutter.dart';
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
  late Wallet bdkWallet;
  Descriptor? aliceDescriptor;
  late Descriptor aliceChangeDescriptor;
  Blockchain? blockchain;

  @override
  void initState() {
    restoreWallet();
    super.initState();
  }

  generateMnemonicKeys() async {
    final res = await Mnemonic.create(WordCount.Words12);
    setState(() {
      displayText = res.toString();
    });
    if (kDebugMode) {
      print(res.asString());
    }
  }

  restoreWallet() async {
    await createDescriptorSecret();
    bdkWallet = await Wallet.create(
        descriptor: aliceDescriptor!,
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
    final address =
        await bdkWallet.getAddress(addressIndex: const AddressIndex());

    setState(() {
      displayText = "Wallet restored with address: ${address.address} ";
    });
  }

  createDescriptorSecret() async {
    final mnemonic = await Mnemonic.fromString(
        'puppy interest whip tonight dad never sudden response push zone pig patch');
    final descriptorSecretKey = await DescriptorSecretKey.create(
      network: Network.Testnet,
      mnemonic: mnemonic,
    );
    final descriptor = await Descriptor.newBip44(
        secretKey: descriptorSecretKey,
        network: Network.Testnet,
        keychain: KeychainKind.External);

    setState(() {
      aliceDescriptor = descriptor;
    });
  }

  initBlockchain(bool isElectrumBlockchain) async {
    if (blockchain == null) {
      if (!isElectrumBlockchain) {
        blockchain = await Blockchain.create(
            config: const BlockchainConfig.esplora(
                config: EsploraConfig(
                    baseUrl: 'https://blockstream.info/testnet/api',
                    stopGap: 10)));
      } else {
        blockchain = await Blockchain.create(
            config: const BlockchainConfig.electrum(
                config: ElectrumConfig(
                    stopGap: 10,
                    timeout: 5,
                    retry: 5,
                    url: "ssl://electrum.blockstream.info:60002",
                    validateDomain: true)));
      }
    }
  }

  sync() async {
    if (blockchain == null) {
      await initBlockchain(true);
    }
    bdkWallet.sync(blockchain!);
    setState(() {
      displayText = "Syncing completed";
    });
  }

  getNewAddress() async {
    final res = await bdkWallet.getAddress(addressIndex: const AddressIndex());
    if (kDebugMode) {
      print(res.address);
    }
    setState(() {
      displayText = "Address: ${res.address} \n Index: ${res.index}";
    });
  }

  getUnConfirmedTransactions() async {
    List<TransactionDetails> unConfirmed = [];
    final res = await bdkWallet.listTransactions(true);
    for (var e in res) {
      if (e.confirmationTime == null) unConfirmed.add(e);
    }
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
    List<TransactionDetails> confirmed = [];
    final res = await bdkWallet.listTransactions(true);
    for (var e in res) {
      if (e.confirmationTime != null) confirmed.add(e);
    }
    setState(() {
      displayText = "You have ${confirmed.length} confirmed transactions";
    });
    for (var e in confirmed) {
      final txOut = await e.transaction!.output();
      if (kDebugMode) {
        print(" txid: ${e.txid}");
        print(" fee: ${e.fee}");
        print(" received: ${e.received}");
        print(" send: ${e.sent}");
        print(" confirmationTime: ${e.confirmationTime?.timestamp}");
        print(" confirmationTime Height: ${e.confirmationTime?.height}");
        print(" output address: ${txOut.last.scriptPubkey.internal}");
        print("===========================");
      }
    }
  }

  getBalance() async {
    final res = await bdkWallet.getBalance();
    setState(() {
      balance = res.total;
      displayText =
          "Total Balance: ${res.total} \n Immature Balance: ${res.immature}";
    });
  }

  listUnspent() async {
    final res = await bdkWallet.listUnspent();
    setState(() {
      displayText =
          " OutPoint: { txid:${res.first.outpoint.txid}, vout: ${res.first.outpoint.vout} }";
    });
    for (var e in res) {
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

  Future<FeeRate> estimateFeeRate(int blocks) async {
    final feeRate = await blockchain!.estimateFee(blocks);
    setState(() {
      displayText = "feeRate: ${feeRate.asSatPerVb()}";
    });
    return feeRate;
  }

  getInputOutPuts(TxBuilderResult txBuilderResult) async {
    final serializedPsbtTx = await txBuilderResult.psbt.jsonSerialize();
    final jsonObj = json.decode(serializedPsbtTx);
    final outputs = jsonObj["unsigned_tx"]["output"] as List;
    final inputs = jsonObj["inputs"][0]["non_witness_utxo"]["output"] as List;
    debugPrint("=========Inputs=====");
    for (var e in inputs) {
      debugPrint("amount: ${e["value"]}");
      debugPrint("script_pubkey: ${e["script_pubkey"]}");
    }
    debugPrint("=========Outputs=====");
    for (var e in outputs) {
      debugPrint("amount: ${e["value"]}");
      debugPrint("script_pubkey: ${e["script_pubkey"]}");
    }
  }

  getTransactionDetails(TxBuilderResult txBuilderResult) async {
    final serializedPsbtTx = await txBuilderResult.psbt.jsonSerialize();
    final txid = await txBuilderResult.psbt.txId();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    if (kDebugMode) {
      print("received: ${txBuilderResult.txDetails.received}");
      print("send: ${txBuilderResult.txDetails.sent}");
      print("confirmation time: ${txBuilderResult.txDetails.confirmationTime}");
      print("fee: ${txBuilderResult.txDetails.fee}");
      print("===================");
      print("txid: $txid");
      log("serializedPsbtTx: ${encoder.convert(json.decode(serializedPsbtTx))}");
    }
  }

  sendBit() async {
    final txBuilder = TxBuilder();
    final address =
        await Address.create(address: "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");
    final script = await address.scriptPubKey();
    final feeRate = await estimateFeeRate(25);
    final txBuilderResult = await txBuilder
        .addRecipient(script, 1500)
        .feeRate(feeRate.asSatPerVb())
        .finish(bdkWallet);
    getInputOutPuts(txBuilderResult);
    final sbt = await bdkWallet.sign(
        psbt: txBuilderResult.psbt,
        signOptions: const SignOptions(
            trustWitnessUtxo: true,
            allowAllSighashes: true,
            removePartialSigs: false,
            tryFinalize: true,
            signWithTapInternalKey: false,
            allowGrinding: false));
    final tx = await sbt.extractTx();
    await blockchain!.broadcast(tx);
    sync();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight * 2),
          child: Container(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            color: Colors.blue,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Bdk Wallet',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      height: 2.5,
                      color: Colors.white)),
              const SizedBox(
                height: 5,
              ),
              Row(
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
            ]),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  onPressed: () => sync(),
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
