import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';

void main() {
  test('Should parse JSON', () {
    final participantKey = ParticipantKey.fromJson(json.decode("""
     {
      "type": "participant-key",
      "id": "90dc2ec6-b1c0-4bbb-9a3f-86343846f10e",
      "links": {
        "self": "http://localhost:3000/participants/fffa0fae-5501-4b54-a848-42f480559a7d/keys/90dc2ec6-b1c0-4bbb-9a3f-86343846f10e"
      },
      "attributes": {
        "createdAt": "2022-05-10T02:55:07.219Z",
        "updatedAt": "2022-05-10T02:57:07.219Z",
        "public": "042d630d0cc69c5b1ea4052c709827e0b1b10531454f32226f0082d885ba817c92655cf536811fe885a7819782c6ec9f10b29eaaa95d39a0c933723e3dc9c1cb1e",
        "effective": {
          "from": "2022-05-10T02:54:41.648Z",
          "to": "2023-05-10T02:54:41.648Z"
        }
      },
      "relationships": {
        "participant": {
          "data": {
            "type": "participant",
            "id": "fffa0fae-5501-4b54-a848-42f480559a7d"
          },
          "links": {
            "related": "http://localhost:3000/participants/90dc2ec6-b1c0-4bbb-9a3f-86343846f10e"
          }
        }
      }
    }
    """));

    expect(participantKey.id, "90dc2ec6-b1c0-4bbb-9a3f-86343846f10e");
    expect(
        participantKey.createdAt, DateTime.parse("2022-05-10T02:55:07.219Z"));
    expect(
        participantKey.updatedAt, DateTime.parse("2022-05-10T02:57:07.219Z"));
  });
}
