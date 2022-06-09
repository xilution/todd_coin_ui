import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';

class BlockTransactionBroker {
  final http.Client client;
  final String baseUrl;

  BlockTransactionBroker(this.client, this.baseUrl);

  Future<PaginatedData<BlockTransaction>> fetchBlockTransactions(
      Block block, int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/blocks/${block.id}/transactions?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<BlockTransaction> blockTransactions = (fetchManyResponse.data)
          .map((i) => BlockTransaction.fromJson(i))
          .toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, blockTransactions);
    } else {
      throw Exception('Failed to fetch blockTransactions');
    }
  }

  Future<BlockTransaction> fetchBlockTransaction(
      Block block, String blockTransactionId) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/blocks/${block.id}/transactions/$blockTransactionId'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return BlockTransaction.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a blockTransaction');
    }
  }
}
