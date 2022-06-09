import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/create_or_update_one_request.dart';
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';

class PendingTransactionBroker {
  final http.Client client;
  final String baseUrl;

  PendingTransactionBroker(this.client, this.baseUrl);

  Future<PaginatedData<PendingTransaction>> fetchPendingTransactions(
      int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/pending-transactions?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<PendingTransaction> pendingTransactions = (fetchManyResponse.data)
          .map((i) => PendingTransaction.fromJson(i))
          .toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, pendingTransactions);
    } else {
      throw Exception('Failed to fetch pendingTransactions');
    }
  }

  Future<PendingTransaction> fetchPendingTransaction(
      String pendingTransactionId) async {
    final response = await client.get(
        Uri.parse('$baseUrl/pending-transactions/$pendingTransactionId'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return PendingTransaction.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a pendingTransaction');
    }
  }

  Future<PendingTransaction> createPendingTransaction(
      String accessToken, PendingTransaction newPendingTransaction) async {
    final response = await client.post(
      Uri.parse('$baseUrl/pending-transactions'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body:
          json.encode(CreateOrUpdateOneRequest(newPendingTransaction.toJson())),
    );

    if (response.statusCode == 201) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return PendingTransaction.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to create a pendingTransaction');
    }
  }

  Future<void> updatePendingTransaction(
      String accessToken, PendingTransaction updatedPendingTransaction) async {
    final response = await client.patch(
      Uri.parse(
          '$baseUrl/pending-transactions/${updatedPendingTransaction.id}'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json
          .encode(CreateOrUpdateOneRequest(updatedPendingTransaction.toJson())),
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to update a pendingTransaction');
    }
  }

  Future<void> deletePendingTransaction(
      String accessToken, PendingTransaction existingPendingTransaction) async {
    final response = await client.delete(
      Uri.parse(
          '$baseUrl/pending-transactions/${existingPendingTransaction.id}'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to update a pendingTransaction');
    }
  }
}
