import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/create_or_update_one_request.dart';
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';

class ParticipantKeyBroker {
  final http.Client client;
  final String baseUrl;
  final String accessToken;

  ParticipantKeyBroker(this.client, this.baseUrl, this.accessToken);

  Future<PaginatedData<ParticipantKey>> fetchParticipantKeys(
      Participant participant, int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/participants/${participant.id}/participant-keys?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<ParticipantKey> participantKeys = (fetchManyResponse.data)
          .map((i) => ParticipantKey.fromJson(i))
          .toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, participantKeys);
    } else {
      throw Exception('Failed to fetch participant keys');
    }
  }

  Future<ParticipantKey> fetchParticipantKey(
      Participant participant, String participantKeyId) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/participants/${participant.id}/participant-keys/$participantKeyId'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return ParticipantKey.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a participantKey');
    }
  }

  Future<ParticipantKey> createParticipantKey(
      Participant participant, ParticipantKey newParticipantKey) async {
    final response = await client.post(
      Uri.parse('$baseUrl/participants/${participant.id}/participant-keys'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json.encode(CreateOrUpdateOneRequest(newParticipantKey.toJson())),
    );

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return ParticipantKey.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to create a participantKey');
    }
  }

  Future<void> updateParticipantKey(
      Participant participant, ParticipantKey updatedParticipantKey) async {
    final response = await client.patch(
      Uri.parse(
          '$baseUrl/participants/${participant.id}/participant-keys/${updatedParticipantKey.id}'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body:
          json.encode(CreateOrUpdateOneRequest(updatedParticipantKey.toJson())),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update a participantKey');
    }
  }
}