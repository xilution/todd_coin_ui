import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';

class AuthBroker {
  final http.Client client;
  final String baseUrl;
  final String accessToken;

  AuthBroker(this.client, this.baseUrl, this.accessToken);

  Future<Token> fetchToken(String email, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/auth/token'),
        body: '{"email": "$email", "password": "$password"}');

    if (response.statusCode == 200) {
      return Token.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch token');
    }
  }

  Future<Participant> fetchUserInfo() async {
    final response = await client
        .get(Uri.parse('$baseUrl/auth/userinfo'), headers: <String, String>{
      'authentication': accessToken,
    });

    if (response.statusCode == 200) {
      FetchOneResponse fetchOneResponse =
          FetchOneResponse.fromJson(json.decode(response.body));

      return Participant.fromJson(fetchOneResponse.data);
    } else {
      throw Exception('Failed to fetch user info');
    }
  }
}
