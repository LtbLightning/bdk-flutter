import 'dart:typed_data';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final address =
      await Address.create(address: "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");
  group('Address', () {
    test('verify network()', () async {
      final res = await address.network();
      expect(res, Network.Testnet);
    });
    test('verify payload()', () async {
      final res = await address.payload();
      expect(res, isA<Payload>());
    });
    test('verify scriptPubKey()', () async {
      final res = await address.scriptPubKey();
      expect(res.internal, isA<Uint8List>());
    });
  });
}
