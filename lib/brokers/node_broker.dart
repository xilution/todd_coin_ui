import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/node.dart';

class NodeBroker {
  final http.Client client;
  final String baseUrl;

  NodeBroker(this.client, this.baseUrl);

  Future<PaginatedData<Node>> fetchNodes(int pageNumber, int pageSize) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/nodes?page[number]=$pageNumber&page[size]=$pageSize'));

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Node> nodes =
          (fetchManyResponse.data).map((i) => Node.fromJson(i)).toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, nodes);
    } else {
      throw Exception('Failed to load node');
    }
  }

  Future<Node> fetchNode(String nodeId) async {
    final response = await client.get(Uri.parse('$baseUrl/nodes/$nodeId'));

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Node.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to load node');
    }
  }
}
