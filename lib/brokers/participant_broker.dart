import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/create_or_update_one_request.dart';
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';

class ParticipantBroker {
  final http.Client client;
  final String baseUrl;
  final String accessToken;

  ParticipantBroker(this.client, this.baseUrl, this.accessToken);

  Future<PaginatedData<Participant>> fetchParticipants(
      int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/participants?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Participant> participants =
          (fetchManyResponse.data).map((i) => Participant.fromJson(i)).toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, participants);
    } else {
      throw Exception('Failed to fetch participants');
    }
  }

  Future<PaginatedData<Participant>> fetchOrganizationParticipants(
      Organization organization, int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/organizations/${organization.id}/participants?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Participant> participants =
          (fetchManyResponse.data).map((i) => Participant.fromJson(i)).toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, participants);
    } else {
      throw Exception('Failed to fetch participants');
    }
  }

  Future<PaginatedData<Participant>> fetchOrganizationAuthorizedSigners(
      Organization organization, int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/organizations/${organization.id}/authorized-signers?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Participant> participants =
          (fetchManyResponse.data).map((i) => Participant.fromJson(i)).toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, participants);
    } else {
      throw Exception('Failed to fetch participants');
    }
  }

  Future<PaginatedData<Participant>> fetchOrganizationAdministrators(
      Organization organization, int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/organizations/${organization.id}/administrators?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Participant> participants =
          (fetchManyResponse.data).map((i) => Participant.fromJson(i)).toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, participants);
    } else {
      throw Exception('Failed to fetch participants');
    }
  }

  Future<Participant> fetchParticipant(String participantId) async {
    final response = await client.get(
        Uri.parse('$baseUrl/participants/$participantId'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Participant.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a participant');
    }
  }

  Future<Participant> createParticipant(Participant newParticipant) async {
    final response = await client.post(
      Uri.parse('$baseUrl/participants'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json.encode(CreateOrUpdateOneRequest(newParticipant.toJson())),
    );

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Participant.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to create a participant');
    }
  }

  Future<void> updateParticipant(Participant updatedParticipant) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/participants/${updatedParticipant.id}'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json.encode(CreateOrUpdateOneRequest(updatedParticipant.toJson())),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update a participant');
    }
  }
}
