import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/node.dart';

void main() {
  test('Should parse JSON', () {
    final node = Node.fromJson(json.decode("""
    {
      "type": "node",
      "id": "0b964c17-20ba-40d8-a993-4ae8a9a4d21b",
      "links": {
        "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
      },
      "attributes": {
        "createdAt": "2022-05-12T01:53:29.970Z",
        "updatedAt": "2022-05-12T01:54:29.970Z",
        "baseUrl": "https://example.com/todd-coin"
      }
    }
    """));

    expect(node.id, "0b964c17-20ba-40d8-a993-4ae8a9a4d21b");
    expect(node.createdAt, DateTime.parse("2022-05-12T01:53:29.970Z"));
    expect(node.updatedAt, DateTime.parse("2022-05-12T01:54:29.970Z"));
    expect(node.baseUrl, "https://example.com/todd-coin");
  });
}
