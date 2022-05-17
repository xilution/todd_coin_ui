import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';

void main() {
  test('Should parse JSON', () {
    final blockTransaction = BlockTransaction.fromJson(json.decode("""
    {
      "type": "block-transaction",
      "id": "f7c8db41-c982-4db6-97a2-b40b3bb94e34",
      "links": {
        "self": "http://localhost:3000/blocks/3ad7e31b-9bee-4af1-beed-90dc4b505de1/transactions/f7c8db41-c982-4db6-97a2-b40b3bb94e34"
      },
      "attributes": {
        "createdAt": "2022-05-12T01:49:02.985Z",
        "updatedAt": "2022-05-12T02:49:03.051Z",
        "description": "Initial set up reward",
        "type": "TIME",
        "details": {
          "dateRanges": [
            {
              "to": "2022-05-12T01:49:02.977Z",
              "from": "2022-05-12T01:49:02.977Z"
            }
          ]
        },
        "goodPoints": "50",
        "signature": "3044022075e61a2d50cadfababd3066aac524e6f5b8468709ce72ff197fd155c2babc012022053148e6b5ad949905b987e8592f3c73b1b7bcf08062912bc9d3ba1ea44a6694a"
      },
      "relationships": {
        "fromParticipant": {
          "data": {
            "type": "participant",
            "id": "f97303d9-1384-481b-82eb-bf0eaaa35c89"
          },
          "links": {
            "related": "http://localhost:3000/participants/f97303d9-1384-481b-82eb-bf0eaaa35c89"
          }
        },
        "fromOrganization": {
          "data": null
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
        },
        "participantKey": {
          "data": {
            "type": "participant-key",
            "id": "839eabf9-5180-4206-8864-58151cbdb7c6"
          },
          "links": {
            "related": "http://localhost:3000/participants/f97303d9-1384-481b-82eb-bf0eaaa35c89/839eabf9-5180-4206-8864-58151cbdb7c6"
          }
        },
        "block": {
          "data": {
            "type": "block",
            "id": "3ad7e31b-9bee-4af1-beed-90dc4b505de1"
          },
          "links": {
            "related": "http://localhost:3000/blocks/3ad7e31b-9bee-4af1-beed-90dc4b505de1"
          }
        }
      }
    }
    """));

    expect(blockTransaction.id, "f7c8db41-c982-4db6-97a2-b40b3bb94e34");
    expect(blockTransaction.createdAt, DateTime.parse("2022-05-12T01:49:02.985Z"));
    expect(blockTransaction.updatedAt, DateTime.parse("2022-05-12T02:49:03.051Z"));
  });
}
