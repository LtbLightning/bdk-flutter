import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';

class BdkLibrary {
  Future<Mnemonic> createMnemonic() async {
    final res = await Mnemonic.create(WordCount.words12);
    return res;
  }

  Future<List<Descriptor>> createDescriptor(Mnemonic mnemonic) async {
    final descriptorSecretKey = await DescriptorSecretKey.create(
      network: Network.signet,
      mnemonic: mnemonic,
    );
    final descriptor = await Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: Network.signet,
        keychain: KeychainKind.externalChain);
    final changeDescriptor = await Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: Network.signet,
        keychain: KeychainKind.internalChain);
    return [descriptor, changeDescriptor];
  }

  Future<EsploraClient> initializeBlockchain() async {
    return EsploraClient.createMutinynet();
  }

  Future<Wallet> crateOrLoadWallet(Descriptor descriptor,
      Descriptor changeDescriptor, Connection connection) async {
    try {
      final wallet = await Wallet.create(
          descriptor: descriptor,
          changeDescriptor: changeDescriptor,
          network: Network.signet,
          connection: connection);
      return wallet;
    } on CreateWithPersistException catch (e) {
      if (e.code == "DatabaseExists") {
        final res = await Wallet.load(
            descriptor: descriptor,
            changeDescriptor: changeDescriptor,
            connection: connection);
        return res;
      } else {
        rethrow;
      }
    }
  }

  Future<void> sync(
      EsploraClient esploraClient, Wallet wallet, bool fullScan) async {
    try {
      if (fullScan) {
        final fullScanRequestBuilder = await wallet.startFullScan();
        final fullScanRequest = await (await fullScanRequestBuilder
                .inspectSpksForAllKeychains(inspector: (e, f, g) {
          debugPrint(
              "Syncing: index: ${f.toString()}, script: ${g.toString()}");
        }))
            .build();
        final update = await esploraClient.fullScan(
            request: fullScanRequest,
            stopGap: BigInt.from(1),
            parallelRequests: BigInt.from(1));
        await wallet.applyUpdate(update: update);
      } else {
        final syncRequestBuilder = await wallet.startSyncWithRevealedSpks();
        final syncRequest = await (await syncRequestBuilder.inspectSpks(
                inspector: (script, progress) {
          debugPrint(
              "syncing spk: ${(progress.spksConsumed / (progress.spksConsumed + progress.spksRemaining)) * 100} %");
        }))
            .build();
        final update = await esploraClient.sync(
            request: syncRequest, parallelRequests: BigInt.from(1));
        await wallet.applyUpdate(update: update);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  AddressInfo revealNextAddress(Wallet wallet) {
    return wallet.revealNextAddress(keychainKind: KeychainKind.externalChain);
  }

  List<CanonicalTx> getUnConfirmedTransactions(Wallet wallet) {
    List<CanonicalTx> unConfirmed = [];
    final res = wallet.transactions();
    for (var e in res) {
      if (e.chainPosition
          .maybeMap(orElse: () => false, unconfirmed: (_) => true)) {
        unConfirmed.add(e);
      }
    }
    return unConfirmed;
  }

  List<CanonicalTx> getConfirmedTransactions(Wallet wallet) {
    List<CanonicalTx> confirmed = [];
    final res = wallet.transactions();
    for (var e in res) {
      if (e.chainPosition
          .maybeMap(orElse: () => false, confirmed: (_) => true)) {
        confirmed.add(e);
      }
    }
    return confirmed;
  }

  Future<Balance> getBalance(Wallet wallet) async {
    return wallet.getBalance();
  }

  List<LocalOutput> listUnspent(Wallet wallet) {
    return wallet.listUnspent();
  }

  sendBitcoin(EsploraClient blockchain, Wallet wallet, String receiverAddress,
      int amountSat) async {
    try {
      final txBuilder = TxBuilder();
      final address = await Address.fromString(
          s: receiverAddress, network: wallet.network());
      final unspentUtxo =
          wallet.listUnspent().firstWhere((e) => e.isSpent == false);
      final psbt = await txBuilder
          .addRecipient(address.script(), BigInt.from(amountSat))
          .addUtxo(unspentUtxo.outpoint)
          .finish(wallet);
      final isFinalized = await wallet.sign(psbt: psbt);
      if (isFinalized) {
        final tx = psbt.extractTx();
        await blockchain.broadcast(transaction: tx);
        debugPrint(tx.computeTxid());
      } else {
        debugPrint("psbt not finalized!");
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
