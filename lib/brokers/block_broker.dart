import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/block.dart';

class BlockBroker {
  final http.Client client;
  final String baseUrl;

  BlockBroker(this.client, this.baseUrl);

  Future<PaginatedData<Block>> fetchBlocks(int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/blocks?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Block> blocks =
          (fetchManyResponse.data).map((i) => Block.fromJson(i)).toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, blocks);
    } else {
      throw Exception('Failed to fetch blocks');
    }
  }

  Future<Block> fetchBlock(String blockId) async {
    final response = await client
        .get(Uri.parse('$baseUrl/blocks/$blockId'), headers: <String, String>{
      'content-type': 'application/json',
    });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Block.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a block');
    }
  }
}
