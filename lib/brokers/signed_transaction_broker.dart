import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/create_or_update_one_request.dart';
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';

class SignedTransactionBroker {
  final http.Client client;
  final String baseUrl;

  SignedTransactionBroker(this.client, this.baseUrl);

  Future<PaginatedData<SignedTransaction>> fetchSignedTransactions(
      int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/signed-transactions?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<SignedTransaction> signedTransactions = (fetchManyResponse.data)
          .map((i) => SignedTransaction.fromJson(i))
          .toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, signedTransactions);
    } else {
      throw Exception('Failed to fetch signedTransactions');
    }
  }

  Future<SignedTransaction> fetchSignedTransaction(
      String signedTransactionId) async {
    final response = await client.get(
        Uri.parse('$baseUrl/signed-transactions/$signedTransactionId'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return SignedTransaction.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a signedTransaction');
    }
  }

  Future<SignedTransaction> createSignedTransaction(
      String accessToken, SignedTransaction newSignedTransaction) async {
    final response = await client.post(
      Uri.parse('$baseUrl/signed-transactions'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body:
          json.encode(CreateOrUpdateOneRequest(newSignedTransaction.toJson())),
    );

    if (response.statusCode == 201) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return SignedTransaction.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to create a signedTransaction');
    }
  }

  Future<void> updateSignedTransaction(
      String accessToken, SignedTransaction updatedSignedTransaction) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/signed-transactions/${updatedSignedTransaction.id}'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json
          .encode(CreateOrUpdateOneRequest(updatedSignedTransaction.toJson())),
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to update a signedTransaction');
    }
  }
}
