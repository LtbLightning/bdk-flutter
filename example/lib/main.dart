import 'package:flutter/material.dart';
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
  late Wallet aliceWallet;
  late Blockchain blockchain;
  @override
  void initState() {
    restoreWallet();
    createDescriptorSecret();
    super.initState();
  }

  generateMnemonicKeys() async {
    final res = await generateMnemonic(wordCount: WordCount.WORDS18);
    print(res);
  }

  restoreWallet() async {
    aliceWallet = await Wallet().create(
        descriptor:
            "wpkh(tprv8ZgxMBicQKsPczV7D2zfMr7oUzHDhNPEuBUgrwRoWM3ijLRvhG87xYiqh9JFLPqojuhmqwMdo1oJzbe5GUpxCbDHnqyGhQa5Jg1Wt6rc9di/84'/1'/0'/1/*)",
        network: Network.TESTNET,
        databaseConfig: DatabaseConfig.memory());
    print("init Complete");
  }

  createDescriptorSecret() async {
    //TODO  key and derived should be similar
    final descriptorSecretKey = DescriptorSecretKey(
      network: Network.TESTNET,
      mnemonic:
          'puppy interest whip tonight dad never sudden response push zone pig patch',
    );
    final secretBytes = await descriptorSecretKey.secretBytes();
    final xpub = await descriptorSecretKey.asPublic();
    final xprv = await descriptorSecretKey.asString();
    final path = await DerivationPath().create(path: DEFAULT_DERIVATION_PATH);
    final derivedXprv = await descriptorSecretKey.derive(path);
    final derivedPublicKey = await derivedXprv.asPublic();
    final derivedXprvStr = await derivedXprv.asString();
    print("xpub: ${xpub.asString()}");
    print("derivedXpub: ${derivedPublicKey.asString()}");
    print("xprv: $xprv");
    print("derivedXprv: $derivedXprvStr");
    print("secretBytes: ${secretBytes.join(",")}");
  }

  sync() async {
    blockchain = await Blockchain().create(config: defaultConfig);
    aliceWallet.sync(blockchain);
  }

  getNewAddress() async {
    final alice = await aliceWallet.getAddress(addressIndex: AddressIndex.New);
    print(alice.address);
    print(alice.index);
  }

  getUnConfirmedTransactions() async {
    List<TransactionDetails> unConfirmed = [];
    final res = await aliceWallet.listTransactions();
    for (var e in res) {
      if (e.confirmationTime == null) unConfirmed.add(e);
    }
    for (var e in unConfirmed) {
      print(" txid: ${e.txid}");
      print(" fee: ${e.fee}");
      print(" received: ${e.received}");
      print(" send: ${e.sent}");
      print("===========================");
    }
  }

  getConfirmedTransactions() async {
    List<TransactionDetails> confirmed = [];
    final res = await aliceWallet.listTransactions();
    for (var e in res) {
      if (e.confirmationTime != null) confirmed.add(e);
    }
    for (var e in confirmed) {
      print(" txid: ${e.txid}");
      print(" fee: ${e.fee}");
      print(" received: ${e.received}");
      print(" send: ${e.sent}");
      print(" confirmationTime: ${e.confirmationTime?.timestamp}");
      print(" confirmationTime Height: ${e.confirmationTime?.height}");
      print("===========================");
    }
  }

  getBalance() async {
    final res = await aliceWallet.getBalance();
    print("alice ${res.total}");
  }

  Future<int> getBlockHeight() async {
    final res = await blockchain.getHeight();
    print(res);
    return res;
  }

  getBlockHash() async {
    final height = await getBlockHeight();
    final blockhash = await blockchain.getBlockHash(height);
    print(blockhash);
  }

  sendBit() async {
    final txBuilder = TxBuilder();
    final address = await Address()
        .create(address: "tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt");
    final script = await address.scriptPubKey();
    final res = await txBuilder
        .addRecipient(script, 1200)
        .feeRate(1.2)
        .finish(aliceWallet);
    final res2 = await aliceWallet.sign(res);
    await blockchain
        .broadcast(PartiallySignedBitcoinTransaction(psbtBase64: res2));
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
