import 'package:todd_coin_ui/models/domain/date_range.dart';

class ParticipantKey {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  String? publicKey;
  String? privateKey;
  DateRange? effective;

  ParticipantKey({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.publicKey,
    this.privateKey,
    this.effective,
  });

  ParticipantKey.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['attributes']['createdAt'] != null
            ? DateTime.parse(json['attributes']['createdAt'])
            : null,
        updatedAt = json['attributes']['updatedAt'] != null
            ? DateTime.parse(json['attributes']['updatedAt'])
            : null,
        publicKey = json['attributes']['public'],
        privateKey = json['attributes']['private'],
        effective = DateRange.fromJson(json['attributes']['effective']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> base = {
      'type': 'participant-key',
      'attributes': {
        'public': publicKey,
        'effective': effective?.toJson(),
      }
    };

    if (id != null) {
      base.addAll({
        'id': id,
      });
    }

    if (privateKey != null) {
      base['attributes'].addAll({
        'private': privateKey,
      });
    }

    return base;
  }
}
