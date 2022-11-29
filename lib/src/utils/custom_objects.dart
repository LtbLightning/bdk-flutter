import 'package:bdk_flutter/bdk_flutter.dart';

class TxBuilderResult {
  PartiallySignedTransaction psbt;
  TransactionDetails transactionDetails;
  TxBuilderResult(this.psbt, this.transactionDetails);
}
