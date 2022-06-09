import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';
import 'package:todd_coin_ui/models/domain/enums.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/models/domain/transaction_details.dart';

class SignedTransaction {
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
  int? goodPoints;
  String? signature;
  ParticipantKey? participantKey;

  SignedTransaction({
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
    this.goodPoints,
    this.signature,
    this.participantKey,
  });

  SignedTransaction.fromPendingTransaction(
      PendingTransaction pendingTransaction)
      : id = pendingTransaction.id,
        createdAt = pendingTransaction.createdAt,
        updatedAt = pendingTransaction.updatedAt,
        type = pendingTransaction.type,
        description = pendingTransaction.description,
        details = pendingTransaction.details,
        fromParticipant = pendingTransaction.fromParticipant,
        fromOrganization = pendingTransaction.fromOrganization,
        toParticipant = pendingTransaction.toParticipant,
        toOrganization = pendingTransaction.toOrganization;

  SignedTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['attributes']['createdAt']),
        updatedAt = DateTime.parse(json['attributes']['updatedAt']),
        type = transactionTypeStrMap[json['attributes']['type']],
        description = json['attributes']['description'],
        details = TimeTransactionDetails(
            dateRanges:
                (json['attributes']['details']['dateRanges'] as List<dynamic>)
                    .map((dynamic dateRange) => DateRange(
                        from: DateTime.parse(dateRange['from']),
                        to: DateTime.parse(dateRange['to'])))
                    .toList()),
        goodPoints = int.parse(json['attributes']['goodPoints']),
        signature = json['attributes']['signature'],
        participantKey =
            json['relationships']['participantKey']['data']?['id'] != null
                ? ParticipantKey(
                    id: json['relationships']['participantKey']['data']['id'])
                : null,
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
                : null;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> base = {
      'type': 'signed-transaction',
      'attributes': {
        'goodPoints': goodPoints,
        'signature': signature,
      },
    };

    if (id != null) {
      base.addAll({
        'id': id,
      });
    }

    if (type != null) {
      base.addAll({
        'type': transactionTypeMap[type],
      });
    }

    if (description != null) {
      base.addAll({
        'description': description,
      });
    }

    if (details != null) {
      base.addAll({
        'details': {
          'dateRanges': details?.dateRanges
              .map((DateRange dateRange) => {
                    'from': dateRange.from?.toIso8601String(),
                    'to': dateRange.to?.toIso8601String()
                  })
              .toList(),
        },
      });
    }

    Map<String, dynamic> relationships = {};

    if (participantKey != null) {
      relationships.addAll({
        'participantKey': {
          'data': {
            'type': 'participant-key',
            'id': participantKey?.id,
          },
        },
      });
    }

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
    return SignedTransaction(
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
      goodPoints: goodPoints,
      signature: signature,
    );
  }

  hash() {
    List<String> parts = [
      id ?? "",
      fromParticipant?.id ?? "",
      toParticipant?.id ?? "",
      fromOrganization?.id ?? "",
      toOrganization?.id ?? "",
      goodPoints.toString(),
      description ?? "",
      transactionTypeMap[type] ?? "",
      details?.hash() ?? "",
    ];

    String joinedParts = parts.join();

    return sha256.convert(utf8.encode(joinedParts)).toString();
  }
}
