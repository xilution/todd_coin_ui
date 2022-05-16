import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/organization.dart';

class OrganizationBroker {
  final String baseUrl;

  OrganizationBroker(this.baseUrl);

  Future<Organization> fetchOrganization(String organizationId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/organizations/$organizationId'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Organization.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load organization');
    }
  }
}