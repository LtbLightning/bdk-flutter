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
  late Wallet aliceWallet;

  late Blockchain blockchain;

  @override
  void initState() {
    restoreWallet();
    createDescriptorSecret();
    super.initState();
  }

  generateMnemonicKeys() async {
    final res = await Mnemonic.create(WordCount.Words12);
    if (kDebugMode) {
      print(res.asString());
    }
  }

  restoreWallet() async {
    aliceWallet = await Wallet.create(
        descriptor:
            "wpkh(tprv8ZgxMBicQKsPczV7D2zfMr7oUzHDhNPEuBUgrwRoWM3ijLRvhG87xYiqh9JFLPqojuhmqwMdo1oJzbe5GUpxCbDHnqyGhQa5Jg1Wt6rc9di/84'/1'/0'/1/*)",
        network: Network.Testnet,
        databaseConfig: const DatabaseConfig.memory());
    if (kDebugMode) {
      print("init Complete");
    }
  }

  createDescriptorSecret() async {
    final mnemonic = await Mnemonic.fromString(
        'puppy interest whip tonight dad never sudden response push zone pig patch');
    final descriptorSecretKey = await DescriptorSecretKey.create(
      network: Network.Testnet,
      mnemonic: mnemonic,
    );

    final path = await DerivationPath.create(path: "m/84'/1'/0'");
    final xprv = await descriptorSecretKey.asString();
    final sec = await descriptorSecretKey.secretBytes();
    final xpub = await descriptorSecretKey.asPublic();
    final xpubString = xpub.asString();
    final derivedXprv = await descriptorSecretKey.extend(path);
    final derivedXpub = await xpub.extend(path);
    final derivedXprvStr = await derivedXprv.asString();
    final derivedXpubStr = derivedXpub.asString();
    if (kDebugMode) {
      print("sec: $sec");
      print("xpub: $xpubString");
      print("xprv: $xprv");
      print("derivedXpub: $derivedXpubStr");
      print("derivedXprv: $derivedXprvStr");
    }
  }

  sync() async {
    blockchain = await Blockchain.create(
        config: BlockchainConfig.electrum(
            config: ElectrumConfig(
                stopGap: 10,
                timeout: 5,
                retry: 5,
                url: "ssl://electrum.blockstream.info:60002")));
    aliceWallet.sync(blockchain);
  }

  getNewAddress() async {
    final alice =
        await aliceWallet.getAddress(addressIndex: AddressIndex.LastUnused);
    if (kDebugMode) {
      print(alice.address);
      print(alice.index);
    }
  }

  getUnConfirmedTransactions() async {
    List<TransactionDetails> unConfirmed = [];
    final res = await aliceWallet.listTransactions();
    for (var e in res) {
      if (e.confirmationTime == null) unConfirmed.add(e);
    }
    for (var e in unConfirmed) {
      if (kDebugMode) {
        print(" txid: ${e.txid}");
        print(" fee: ${e.fee}");
        print(" received: ${e.received}");
        print(" send: ${e.sent}");
        print("===========================");
      }
    }
  }

  getConfirmedTransactions() async {
    List<TransactionDetails> confirmed = [];
    final res = await aliceWallet.listTransactions();
    for (var e in res) {
      if (e.confirmationTime != null) confirmed.add(e);
    }
    for (var e in confirmed) {
      if (kDebugMode) {
        print(" txid: ${e.txid}");
        print(" fee: ${e.fee}");
        print(" received: ${e.received}");
        print(" send: ${e.sent}");
        print(" confirmationTime: ${e.confirmationTime?.timestamp}");
        print(" confirmationTime Height: ${e.confirmationTime?.height}");
        print("===========================");
      }
    }
  }

  getBalance() async {
    final res = await aliceWallet.getBalance();
    if (kDebugMode) {
      print("alice ${res.total}");
    }
  }

  listUnspent() async {
    final res = await aliceWallet.listUnspent();
    for (var e in res) {
      if (kDebugMode) {
        print("isSpent: ${e.isSpent}");
        print(
            "outPoint: { txid:${e.outpoint.txid}, vout: ${e.outpoint.vout} } ");
        print("txout: { address:${e.txout.address}, value: ${e.txout.value} }");
        print("===========================");
      }
    }
  }

  Future<int> getBlockHeight() async {
    final res = await blockchain.getHeight();
    if (kDebugMode) {
      print(res);
    }
    return res;
  }

  getBlockHash() async {
    final height = await getBlockHeight();
    final blockHash = await blockchain.getBlockHash(height);
    if (kDebugMode) {
      print(blockHash);
    }
  }

  sendBit() async {
    final txBuilder = TxBuilder();
    final address = await Address.create(
        address: "tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt");
    final script = await address.scriptPubKey();
    final psbt = await txBuilder
        .addRecipient(script, 1000)
        .feeRate(1.1)
        .finish(aliceWallet);
    final res = await aliceWallet.sign(psbt);
    await blockchain.broadcast(res);
    sync();
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
                  child: const Text('Press to send 1200 satoshi')),
              TextButton(
                  onPressed: () => sync(), child: const Text('Press to  sync')),
              TextButton(
                  onPressed: () => getConfirmedTransactions(),
                  child: const Text('Get ConfirmedTransactions')),
              TextButton(
                  onPressed: () => getUnConfirmedTransactions(),
                  child: const Text('getPendingTransactions')),
              TextButton(
                  onPressed: () => getBalance(),
                  child: const Text('get Balance')),
              TextButton(
                  onPressed: () => listUnspent(),
                  child: const Text('list Unspent')),
              TextButton(
                  onPressed: () => getBlockHash(),
                  child: const Text('get BlockHash')),
              TextButton(
                  onPressed: () => generateMnemonicKeys(),
                  child: const Text('generate Mnemonic')),
            ],
          ),
        ),
      ),
    );
  }
}
