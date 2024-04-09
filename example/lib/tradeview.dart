import 'dart:math';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/foundation.dart';

class AssignedTrade {
  final Address buyerSettlementAddress;
  final Address platformFeeAddress;
  final Address changeAddress;
  int? buyerSettlementFeeRate;
  final int value;
  final int feeAmount;
  final String id;
  TxTree? txTree;
  final List<ChildTrade> child;

  AssignedTrade(
      {required this.value,
      required this.platformFeeAddress,
      required this.changeAddress,
      required this.buyerSettlementAddress,
      this.buyerSettlementFeeRate,
      required this.feeAmount,
      required this.id,
      this.txTree,
      required this.child});
}

class ChildTrade {
  final Address parentUtxoChangeAddress;
  final Address buyerSettlementAddress;
  final Address platformFeeAddress;
  final int value;
  final int feeAmount;
  final String id;
  int? buyerSettlementFeeRate;

  ChildTrade(
      {required this.value,
      required this.buyerSettlementAddress,
      required this.parentUtxoChangeAddress,
      required this.platformFeeAddress,
      required this.feeAmount,
      this.buyerSettlementFeeRate,
      required this.id});
}

class TxTree {
  final PartiallySignedTransaction parentTx;
  final List<PartiallySignedTransaction> childTxs;
  TxTree({required this.parentTx, required this.childTxs});
}

class TradeView {
  Future<List<Address>> getDestinationAddresses() async {
    final trade1DestinationAddress = await Address.fromString(
        s: "bcrt1qvym2hzrtfdnlnmkg7dk5rw0ykmdr6n7f0w4hu9",
        network: Network.regtest);
    final trade2DestinationAddress = await Address.fromString(
        s: "bcrt1qc2thfuugj50e07pnegpdu5ztyvgymuz99t2t2n",
        network: Network.regtest);
    final trade3DestinationAddress = await Address.fromString(
        s: "bcrt1q5v5c5kheq4mj8xwnqluhv27gxptvxrfqd948wv",
        network: Network.regtest);
    return [
      trade1DestinationAddress,
      trade2DestinationAddress,
      trade3DestinationAddress
    ];
  }

  Future<(Address, List<Address>)> getPlatformAndChange(Wallet wallet) async {
    final tradePlatformAddress = await Address.fromString(
        s: "bcrt1qt9en66tcv5qn259s7vneyutkcw9sl2nfezvmms",
        network: Network.regtest);

    final trade1PlatformChangeAddress = await wallet.getInternalAddress(
        addressIndex: const AddressIndex.peek(index: 41));
    final trade2PlatformChangeAddress = await wallet.getInternalAddress(
        addressIndex: const AddressIndex.peek(index: 42));
    final trade3PlatformChangeAddress = await wallet.getInternalAddress(
        addressIndex: const AddressIndex.peek(index: 43));
    return (
      tradePlatformAddress,
      [
        trade1PlatformChangeAddress.address,
        trade2PlatformChangeAddress.address,
        trade3PlatformChangeAddress.address
      ]
    );
  }

  Future<List<AssignedTrade>> openTrade(
      List<AssignedTrade> available,
      List<LocalUtxo> assignedUtxos,
      Address destination,
      Address platform,
      Address change,
      int tradeValue,
      Wallet wallet) async {
    final List<ChildTrade> newChildTrades = [];
    final newTradeId = Random.secure().nextDouble().toString();
    for (var e in available) {
      newChildTrades.add(ChildTrade(
          value: e.value,
          buyerSettlementAddress: e.buyerSettlementAddress,
          parentUtxoChangeAddress: e.changeAddress,
          platformFeeAddress: e.platformFeeAddress,
          feeAmount: e.feeAmount,
          buyerSettlementFeeRate: e.buyerSettlementFeeRate,
          id: e.id));
    }

    final AssignedTrade newTrade = AssignedTrade(
        value: tradeValue,
        platformFeeAddress: platform,
        buyerSettlementAddress: destination,
        feeAmount: 2000,
        id: newTradeId,
        buyerSettlementFeeRate: 500,
        changeAddress: change,
        child: newChildTrades);

    final List<AssignedTrade> availableTrades = [];
    for (var e in available) {
      final child = e.child;
      child.add(ChildTrade(
          value: tradeValue,
          platformFeeAddress: platform,
          buyerSettlementAddress: destination,
          feeAmount: 2000,
          buyerSettlementFeeRate: 500,
          id: newTradeId,
          parentUtxoChangeAddress: change));
      availableTrades.add(AssignedTrade(
          value: e.value,
          platformFeeAddress: e.platformFeeAddress,
          buyerSettlementAddress: e.buyerSettlementAddress,
          feeAmount: e.feeAmount,
          id: e.id,
          changeAddress: e.changeAddress,
          child: child));
    }
    availableTrades.add(newTrade);
    final List<AssignedTrade> updated = [];
    for (var e in availableTrades) {
      final updatedTrade = await handleTrades(assignedUtxos, e, wallet);
      updated.add(updatedTrade);
    }
    return updated;
  }

  Future<AssignedTrade> handleTrades(
    List<LocalUtxo> assignedUtxos,
    AssignedTrade parent,
    Wallet wallet,
  ) async {
    /* CREATE ROOT TX */
    final rootTxBuilder = TxBuilder();
    // Outputs of the tx we're creating.
    final parentTargets = [
      // Received by the buyer
      {
        'address': parent.buyerSettlementAddress,
        'value': parent.value,
      },
      // Received by the platform (fee) in sata
      {
        'address': parent.platformFeeAddress,
        'value': parent.feeAmount,
      },
    ];
    for (var e in parent.child) {
      // Use pre-generated change address for child tx, TODO; create an algorithm to handle change addresses
      debugPrint(
          'Child trade ${e.id} -  parent output address ${e.parentUtxoChangeAddress}');
      parentTargets.add({
        'address': e.parentUtxoChangeAddress,
        'value': (e.value + e.feeAmount + 500),
      });
    }
    debugPrint('Parent trade targets ${parentTargets.toString()}');

    for (var e in parentTargets) {
      final script = await (e['address'] as Address).scriptPubkey();
      rootTxBuilder.addRecipient(script, e['value'] as int);
    }

    for (var e in assignedUtxos) {
      rootTxBuilder.addUtxo(e.outpoint);
    }
    final (parentPsbt, _) =
        await rootTxBuilder.manuallySelectedOnly().finish(wallet);
    final parentTx = await parentPsbt.extractTx();
    debugPrint('Parent trade psbt ${await parentTx.serialize()}');
    final List<PartiallySignedTransaction> childPsbts = [];
    for (var e in parent.child) {
      final childTargets = [
        {
          'address': e.buyerSettlementAddress,
          'value': e.value,
        },
        {
          'address': e.platformFeeAddress,
          'value': e.feeAmount,
        },
      ];

      final parentChangeAddressScript =
          (await e.parentUtxoChangeAddress.scriptPubkey()).bytes;
      final childTxInVout = (await parentTx.output()).indexWhere(
          (a) => listEquals(a.scriptPubkey.bytes, parentChangeAddressScript));
      final childTxin = TxIn(
          previousOutput:
              OutPoint(txid: (await parentTx.txid()), vout: childTxInVout),
          scriptSig: await ScriptBuf.empty(),
          sequence: 0xFFFFFFFF,
          witness: []);
      final List<TxOut> txout = [];
      debugPrint(
          'Child trade input- previousOutput: {${childTxin.previousOutput.txid}: ${childTxin.previousOutput.vout}}');
      for (var e in childTargets) {
        final script = await (e['address'] as Address).scriptPubkey();
        txout.add(TxOut(value: e['value'] as int, scriptPubkey: script));
      }

      final childTx = await Transaction.create(
          version: await parentTx.version(),
          lockTime: await parentTx.lockTime(),
          input: [childTxin],
          output: txout);

      final childPsbt =
          await PartiallySignedTransaction.fromUnsignedTransaction(childTx);
      debugPrint('Child trade psbt ${await childPsbt.serialize()}');
      childPsbts.add(childPsbt);
    }
    parent.txTree = TxTree(parentTx: parentPsbt, childTxs: childPsbts);
    return parent;
  }

  Future<List<AssignedTrade>> closeTrade(List<AssignedTrade> available,
      AssignedTrade target, Wallet wallet, Blockchain blockchain) async {
    try {
      final parentPsbt = target.txTree?.parentTx;
      await wallet.sign(psbt: parentPsbt!);
      final txid = await blockchain.broadcast(
          transaction: (await parentPsbt.extractTx()));
      print("trade patentTx broadcast $txid");
      wallet.sync(blockchain: blockchain);
      available.remove(target);
      final List<LocalUtxo> selectedUtxos = [];
      final List<LocalUtxo> availableUtxos = (await wallet.listUnspent())
          .where((e) => e.outpoint.txid == txid)
          .toList();
      final List<AssignedTrade> availableTrades = [];

      for (var e in available) {
        e.child.removeWhere((e) => e.id == target.id);
        availableTrades.add(AssignedTrade(
            value: e.value,
            platformFeeAddress: e.platformFeeAddress,
            buyerSettlementAddress: e.buyerSettlementAddress,
            feeAmount: e.feeAmount,
            id: e.id,
            changeAddress: e.changeAddress,
            child: e.child));
        selectedUtxos.add(availableUtxos.firstWhere((e) => listEquals(
            e.txout.scriptPubkey.bytes, e.txout.scriptPubkey.bytes)));
      }
      print("Available utxos");
      for (var e in selectedUtxos) {
        print(e.txout.value);
        print(e.outpoint.txid);
      }
      final List<AssignedTrade> updated = [];

      for (var e in availableTrades) {
        final updatedTrade = await handleTrades(availableUtxos, e, wallet);
        updated.add(updatedTrade);
      }
      return updated;
    } catch (e) {
      rethrow;
    }
  }
}
