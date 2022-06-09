import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';

ParticipantKey generateParticipantKey() {
  EllipticCurve ec = getSecp256k1() as EllipticCurve;
  PrivateKey privateKey = ec.generatePrivateKey();
  PublicKey publicKey = privateKey.publicKey;

  DateTime now = DateTime.now();
  ParticipantKey newParticipantKey = ParticipantKey(
    publicKey: publicKey.toHex(),
    privateKey: privateKey.toHex(),
    effective: DateRange(
      from: now,
      to: now.add(const Duration(days: 365)),
    ),
  );

  return newParticipantKey;
}

String getSignature(String hashHex, String privateKey) {
  EllipticCurve ec = getSecp256k1() as EllipticCurve;
  var hash = List<int>.generate(hashHex.length ~/ 2,
      (i) => int.parse(hashHex.substring(i * 2, i * 2 + 2), radix: 16));

  Signature sig = signature(PrivateKey.fromHex(ec, privateKey), hash);

  return sig.toDERHex();
}
