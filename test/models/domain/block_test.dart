import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/block.dart';

void main() {
  test('Should parse JSON', () {
    final block = Block.fromJson(json.decode("""
    {
      "type": "block",
      "id": "3ad7e31b-9bee-4af1-beed-90dc4b505de1",
      "links": {
        "self": "http://localhost:3000/blocks/3ad7e31b-9bee-4af1-beed-90dc4b505de1"
      },
      "attributes": {
        "createdAt": "2022-05-12T01:49:03.046Z",
        "updatedAt": "2022-05-12T02:49:03.046Z",
        "sequenceId": 0,
        "nonce": 1,
        "previousHash": "0000000000000000000000000000000000000000000000000000000000000000",
        "hash": "292e149e0e07ad88d46910a8a17e55b5857fe9f57d2781249ecfb39d7e333f04"
      },
      "relationships": {
        "transactions": {
          "data": [
            {
              "type": "transaction",
              "id": "f7c8db41-c982-4db6-97a2-b40b3bb94e34"
            }
          ],
          "links": {
            "related": "http://localhost:3000/blocks/3ad7e31b-9bee-4af1-beed-90dc4b505de1/transactions?page[number]=0&page[size]=10"
          }
        }
      }
    }
    """));

    expect(block.id, "3ad7e31b-9bee-4af1-beed-90dc4b505de1");
    expect(block.createdAt, DateTime.parse("2022-05-12T01:49:03.046Z"));
    expect(block.updatedAt, DateTime.parse("2022-05-12T02:49:03.046Z"));
    expect(block.sequenceId, 0);
    expect(block.nonce, 1);
    expect(block.previousHash, "0000000000000000000000000000000000000000000000000000000000000000");
    expect(block.hash, "292e149e0e07ad88d46910a8a17e55b5857fe9f57d2781249ecfb39d7e333f04");
  });
}
