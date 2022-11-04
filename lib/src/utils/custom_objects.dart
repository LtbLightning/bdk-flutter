import 'package:bdk_flutter/bdk_flutter.dart';

import '../generated/bindings.dart';


class TxBuilderResult {
  PartiallySignedBitcoinTransaction psbt;
  TransactionDetails transactionDetails;
  TxBuilderResult(this.psbt, this.transactionDetails);
}



