import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/create_or_update_one_request.dart';
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/meta.dart';
import 'package:todd_coin_ui/models/api/paginated_data.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';

class OrganizationBroker {
  final http.Client client;
  final String baseUrl;

  OrganizationBroker(this.client, this.baseUrl);

  Future<PaginatedData<Organization>> fetchOrganizations(
      int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/organizations?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Organization> organizations = (fetchManyResponse.data)
          .map((i) => Organization.fromJson(i))
          .toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, organizations);
    } else {
      throw Exception('Failed to fetch organizations');
    }
  }

  Future<PaginatedData<Organization>> fetchParticipantOrganizations(
      Participant participant, int pageNumber, int pageSize) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/participants/${participant.id}/organizations?page[number]=$pageNumber&page[size]=$pageSize'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      FetchManyResponse fetchManyResponse =
          FetchManyResponse.fromJson(json.decode(response.body));
      Meta meta = Meta.fromJson(fetchManyResponse.meta);
      List<Organization> organizations = (fetchManyResponse.data)
          .map((i) => Organization.fromJson(i))
          .toList();

      return PaginatedData(meta.itemsPerPage, meta.totalItems, meta.currentPage,
          meta.totalPages, organizations);
    } else {
      throw Exception('Failed to fetch organizations');
    }
  }

  Future<Organization> fetchOrganization(String organizationId) async {
    final response = await client.get(
        Uri.parse('$baseUrl/organizations/$organizationId'),
        headers: <String, String>{
          'content-type': 'application/json',
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Organization.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch a organization');
    }
  }

  Future<Organization> createOrganization(
      String accessToken, Organization newOrganization) async {
    final response = await client.post(
      Uri.parse('$baseUrl/organizations'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json.encode(CreateOrUpdateOneRequest(newOrganization.toJson())),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Organization.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to create a organization');
    }
  }

  Future<void> updateOrganization(
      String accessToken, Organization updatedOrganization) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/organizations/${updatedOrganization.id}'),
      headers: <String, String>{
        'content-type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: json.encode(CreateOrUpdateOneRequest(updatedOrganization.toJson())),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to update a organization');
    }
  }
}
