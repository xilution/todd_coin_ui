import 'dart:convert';

import 'package:crypto/crypto.dart';

class DateRange {
  final DateTime? from;
  final DateTime? to;

  DateRange({this.from, this.to});

  DateRange.fromJson(Map<String, dynamic> json)
      : from = DateTime.parse(json['from']),
        to = DateTime.parse(json['to']);

  Map<String, dynamic> toJson() => {
        'from': from?.toIso8601String(),
        'to': to?.toIso8601String(),
      };

  String hash() {
    List<String> parts = [
      from?.toIso8601String() ?? "",
      to?.toIso8601String() ?? "",
    ];

    String joinedParts = parts.join();

    return sha256.convert(utf8.encode(joinedParts)).toString();
  }
}
