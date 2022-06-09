import 'package:todd_coin_ui/models/domain/date_range.dart';
import 'package:todd_coin_ui/models/domain/enums.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/transaction_details.dart';

class BlockTransaction {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Participant? fromParticipant;
  Organization? fromOrganization;
  Participant? toParticipant;
  Organization? toOrganization;
  TransactionType? type;
  String? description;
  TimeTransactionDetails? details;

  BlockTransaction({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.fromParticipant,
    this.fromOrganization,
    this.toParticipant,
    this.toOrganization,
    this.type,
    this.description,
    this.details,
  });

  BlockTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        fromParticipant =
            json['relationships']['fromParticipant']['data']?['id'] != null
                ? Participant(
                    id: json['relationships']['fromParticipant']['data']['id'])
                : null,
        fromOrganization =
            json['relationships']['fromOrganization']['data']?['id'] != null
                ? Organization(
                    id: json['relationships']['fromOrganization']['data']['id'])
                : null,
        toParticipant =
            json['relationships']['toParticipant']['data']?['id'] != null
                ? Participant(
                    id: json['relationships']['toParticipant']['data']['id'])
                : null,
        toOrganization =
            json['relationships']['toOrganization']['data']?['id'] != null
                ? Organization(
                    id: json['relationships']['toOrganization']['data']['id'])
                : null,
        type = transactionTypeStrMap[json['attributes']['type']],
        description = json['attributes']['description'],
        details = TimeTransactionDetails(
            dateRanges:
                (json['attributes']['details']['dateRanges'] as List<dynamic>)
                    .map((dynamic dateRange) => DateRange(
                        from: DateTime.parse(dateRange['from']),
                        to: DateTime.parse(dateRange['to'])))
                    .toList());

  Map<String, dynamic> toJson() {
    Map<String, dynamic> base = {
      'type': 'pending-transaction',
      'attributes': {
        'type': transactionTypeMap[type],
        'description': description,
        'details': {
          'dateRanges': details?.dateRanges
              .map((DateRange dateRange) => {
                    'from': dateRange.from?.toIso8601String(),
                    'to': dateRange.to?.toIso8601String()
                  })
              .toList(),
        }
      },
    };

    if (id != null) {
      base.addAll({
        'id': id,
      });
    }

    Map<String, dynamic> relationships = {};

    if (fromParticipant != null) {
      relationships.addAll({
        'fromParticipant': {
          'data': {
            'type': 'participant',
            'id': fromParticipant?.id,
          },
        },
      });
    }

    if (fromOrganization != null) {
      relationships.addAll({
        'fromOrganization': {
          'data': {
            'type': 'organization',
            'id': fromOrganization?.id,
          },
        },
      });
    }

    if (toParticipant != null) {
      relationships.addAll({
        'toParticipant': {
          'data': {
            'type': 'participant',
            'id': toParticipant?.id,
          },
        },
      });
    }

    if (toOrganization != null) {
      relationships.addAll({
        'toOrganization': {
          'data': {
            'type': 'organization',
            'id': toOrganization?.id,
          },
        },
      });
    }

    base.addAll({'relationships': relationships});

    return base;
  }

  copy() {
    return BlockTransaction(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fromParticipant: fromParticipant,
      fromOrganization: fromOrganization,
      toParticipant: toParticipant,
      toOrganization: toOrganization,
      type: type,
      description: description,
      details: details,
    );
  }
}
