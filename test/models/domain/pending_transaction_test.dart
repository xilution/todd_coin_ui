import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';

void main() {
  test('Should parse JSON', () {
    final pendingTransaction = PendingTransaction.fromJson(json.decode("""
    {
      "type": "pending-transaction",
      "id": "22816bc4-f68e-44ec-9f0b-628114956f0f",
      "links": {
        "self": "http://localhost:3000/pending-transactions/22816bc4-f68e-44ec-9f0b-628114956f0f"
      },
      "attributes": {
        "createdAt": "2022-05-12T01:49:03.055Z",
        "updatedAt": "2022-05-13T01:49:03.055Z",
        "description": "Mining reward",
        "type": "TIME",
        "details": {}
      },
      "relationships": {
        "fromParticipant": {
          "data": null
        },
        "fromOrganization": {
          "data": {
            "type": "organization",
            "id": "63315106-1d75-4c65-b4db-470c3ead3d00"
          },
          "links": {
            "related": "http://localhost:3000/organizations/63315106-1d75-4c65-b4db-470c3ead3d00"
          }
        },
        "toParticipant": {
          "data": {
            "type": "participant",
            "id": "f97303d9-1384-481b-82eb-bf0eaaa35c89"
          },
          "links": {
            "related": "http://localhost:3000/participants/f97303d9-1384-481b-82eb-bf0eaaa35c89"
          }
        },
        "toOrganization": {
          "data": null
        }
      }
    }
    """));

    expect(pendingTransaction.id, "22816bc4-f68e-44ec-9f0b-628114956f0f");
    expect(pendingTransaction.createdAt,
        DateTime.parse("2022-05-12T01:49:03.055Z"));
    expect(pendingTransaction.updatedAt,
        DateTime.parse("2022-05-13T01:49:03.055Z"));
  });
}
