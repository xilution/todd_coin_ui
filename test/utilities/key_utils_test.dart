import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:test/test.dart';
import 'package:todd_coin_ui/utilities/key_utils.dart';

void main() {
  group('getSignature', () {
    test('should return the correct signature', () {
      String hashHex = sha256.convert(utf8.encode("Try not. Do or do not. There is no try.")).toString();
      String privateKey = "8299b123b5eea7032d6183d3bde46be37a9b39a12deee10945263af59d89b2cc";
      String publicKey = "044958ab8c3a4e8c018a574ed99f5bb34b5e95d6a68b8c690308b40de7ed583bb5eb21d554f7ef2b562682678fb136fe799d08eda183da909df7821e4ec9a32f0e";

      String signature = getSignature(hashHex, privateKey);
      EllipticCurve ec = getSecp256k1() as EllipticCurve;
      var hash = List<int>.generate(hashHex.length ~/ 2,
              (i) => int.parse(hashHex.substring(i * 2, i * 2 + 2), radix: 16));

      expect(verify(PublicKey.fromHex(ec, publicKey), hash, Signature.fromDERHex(signature)), true);
    });
  });
}
