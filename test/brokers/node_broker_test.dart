import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:random_string/random_string.dart';
import 'package:test/test.dart';
import 'package:todd_coin_ui/brokers/node_broker.dart';
import 'package:todd_coin_ui/models/api/create_or_update_one_request.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/node.dart';

import 'node_broker_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchNodes', () {
    test('returns PaginatedData if the http call completes successfully',
        () async {
      final client = MockClient();

      const String baseUrl = 'http://localhost:3000';
      final int pageNumber = randomBetween(0, 10);
      final int pageSize = randomBetween(0, 10);
      final NodeBroker nodeBroker = NodeBroker(client, baseUrl);

      when(client.get(
          Uri.parse(
              '$baseUrl/nodes?page[number]=$pageNumber&page[size]=$pageSize'),
          headers: <String, String>{
            'content-type': 'application/json',
          })).thenAnswer((_) async => http.Response("""
          {
            "jsonapi": {
              "version": "1.0"
            },
            "links": {
              "self": "http://localhost:3000/nodes",
              "first": "http://localhost:3000/nodes?page[number]=0&page[size]=10",
              "last": "http://localhost:3000/nodes?page[number]=1&page[size]=10",
              "next": "http://localhost:3000/nodes?page[number]=1&page[size]=10"
            },
            "meta": {
              "itemsPerPage": 10,
              "totalItems": 1,
              "currentPage": 0,
              "totalPages": 3
            },
            "data": [
              {
                "type": "node",
                "id": "0b964c17-20ba-40d8-a993-4ae8a9a4d21b",
                "links": {
                  "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
                },
                "attributes": {
                  "createdAt": "2022-05-12T01:53:29.970Z",
                  "updatedAt": "2022-05-12T02:53:29.970Z",
                  "baseUrl": "https://example.com/todd-coin"
                }
              }
            ]
          }
          """, 200));

      PaginatedData paginatedData =
          await nodeBroker.fetchNodes(pageNumber, pageSize);

      expect(paginatedData.itemsPerPage, 10);
      expect(paginatedData.totalItems, 1);
      expect(paginatedData.currentPage, 0);
      expect(paginatedData.totalPages, 3);
      expect(paginatedData.rows.length, 1);
      expect(paginatedData.rows.first, isA<Node>());
      Node firstNode = paginatedData.rows.first;
      expect(firstNode.id, "0b964c17-20ba-40d8-a993-4ae8a9a4d21b");
      expect(firstNode.createdAt, DateTime.parse("2022-05-12T01:53:29.970Z"));
      expect(firstNode.updatedAt, DateTime.parse("2022-05-12T02:53:29.970Z"));
      expect(firstNode.baseUrl, "https://example.com/todd-coin");
    });
  });

  group('fetchNode', () {
    test('returns a node if the http call completes successfully', () async {
      final client = MockClient();

      const String baseUrl = 'http://localhost:3000';
      final String nodeId = randomAlpha(32);
      final NodeBroker nodeBroker = NodeBroker(client, baseUrl);

      when(client
          .get(Uri.parse('$baseUrl/nodes/$nodeId'), headers: <String, String>{
        'content-type': 'application/json',
      })).thenAnswer((_) async => http.Response("""
          {
            "jsonapi": {
              "version": "1.0"
            },
            "links": {
              "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
            },
            "data": {
              "type": "node",
              "id": "0b964c17-20ba-40d8-a993-4ae8a9a4d21b",
              "links": {
                "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
              },
              "attributes": {
                "createdAt": "2022-05-12T01:53:29.970Z",
                "updatedAt": "2022-05-12T01:55:29.970Z",
                "baseUrl": "https://example.com/todd-coin"
              }
            }
          }
          """, 200));

      Node node = await nodeBroker.fetchNode(nodeId);

      expect(node.id, "0b964c17-20ba-40d8-a993-4ae8a9a4d21b");
      expect(node.createdAt, DateTime.parse("2022-05-12T01:53:29.970Z"));
      expect(node.updatedAt, DateTime.parse("2022-05-12T01:55:29.970Z"));
      expect(node.baseUrl, "https://example.com/todd-coin");
    });
  });

  group('createNode', () {
    test('returns a node if the http call completes successfully', () async {
      final client = MockClient();

      const String baseUrl = 'http://localhost:3000';
      final String accessToken = randomAlpha(10);
      final String id = randomAlpha(10);
      final DateTime createdAt = DateTime.parse("2022-05-12T01:53:29.970Z");
      final DateTime updatedAt = DateTime.parse("2022-05-12T01:54:29.970Z");
      final Node newNode = Node(
          id: id, createdAt: createdAt, updatedAt: updatedAt, baseUrl: baseUrl);
      final NodeBroker nodeBroker = NodeBroker(client, baseUrl);

      when(client.post(Uri.parse('$baseUrl/nodes'),
              headers: <String, String>{
                'content-type': 'application/json',
                'authorization': 'Bearer $accessToken',
              },
              body: json.encode(CreateOrUpdateOneRequest(newNode.toJson()))))
          .thenAnswer((_) async => http.Response("""
          {
            "jsonapi": {
              "version": "1.0"
            },
            "links": {
              "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
            },
            "data": {
              "type": "node",
              "id": "$id",
              "links": {
                "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
              },
              "attributes": {
                "createdAt": "${createdAt.toIso8601String()}",
                "updatedAt": "${updatedAt.toIso8601String()}",
                "baseUrl": "$baseUrl"
              }
            }
          }
          """, 200));

      Node createdNode = await nodeBroker.createNode(accessToken, newNode);

      expect(createdNode.id, id);
      expect(createdNode.createdAt, createdAt);
      expect(createdNode.updatedAt, updatedAt);
      expect(createdNode.baseUrl, baseUrl);
    });
  });

  group('updateNode', () {
    test('returns void if the http call completes successfully', () async {
      final client = MockClient();

      const String baseUrl = 'http://localhost:3000';
      final String accessToken = randomAlpha(10);
      final String id = randomAlpha(10);
      final DateTime createdAt = DateTime.parse("2022-05-12T01:53:29.970Z");
      final DateTime updatedAt = DateTime.parse("2022-05-12T01:54:29.970Z");
      final Node updatedNode = Node(
          id: id, createdAt: createdAt, updatedAt: updatedAt, baseUrl: baseUrl);
      final NodeBroker nodeBroker = NodeBroker(client, baseUrl);

      when(client.patch(Uri.parse('$baseUrl/nodes/${updatedNode.id}'),
              headers: <String, String>{
                'content-type': 'application/json',
                'authorization': 'Bearer $accessToken',
              },
              body:
                  json.encode(CreateOrUpdateOneRequest(updatedNode.toJson()))))
          .thenAnswer((_) async => http.Response("""
          {
            "jsonapi": {
              "version": "1.0"
            },
            "links": {
              "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
            },
            "data": {
              "type": "node",
              "id": "$id",
              "links": {
                "self": "http://localhost:3000/nodes/0b964c17-20ba-40d8-a993-4ae8a9a4d21b"
              },
              "attributes": {
                "createdAt": "${createdAt.toIso8601String()}",
                "updatedAt": "${updatedAt.toIso8601String()}",
                "baseUrl": "$baseUrl"
              }
            }
          }
          """, 200));

      await nodeBroker.updateNode(accessToken, updatedNode);
    });
  });
}
