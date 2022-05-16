import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todd_coin_ui/models/participant.dart';

class ParticipantBroker {
  final String baseUrl;

  ParticipantBroker(this.baseUrl);

  Future<Participant> fetchParticipant(String participantId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/participants/$participantId'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Participant.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load participant');
    }
  }
}
