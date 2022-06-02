import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';

void main() {
  test('Should parse JSON', () {
    final participant = Participant.fromJson(json.decode("""
    {
      "type": "participant",
      "id": "a7dd88da-f3bd-4f02-b50e-d9938bc1355c",
      "links": {
        "self": "http://localhost:3000/participants/a7dd88da-f3bd-4f02-b50e-d9938bc1355c"
      },
      "attributes": {
        "createdAt": "2022-05-13T13:27:31.789Z",
        "updatedAt": "2022-05-14T13:27:31.789Z",
        "email": "educator@example.com",
        "firstName": null,
        "lastName": null,
        "phone": null,
        "roles": [
          "VOLUNTEER"
        ]
      },
      "relationships": {
        "keys": {
          "data": [
            {
              "type": "participant-key",
              "id": "f7c793c4-3d95-4b8c-b4d2-f3d409327fe3"
            }
          ],
          "links": {
            "related": "http://localhost:3000/participants/a7dd88da-f3bd-4f02-b50e-d9938bc1355c/keys?page[number]=0&page[size]=10"
          }
        },
        "organizations": {
          "data": [],
          "links": {
            "related": "http://localhost:3000/participants/a7dd88da-f3bd-4f02-b50e-d9938bc1355c/organizations?page[number]=0&page[size]=10"
          }
        }
      }
    }
    """));

    expect(participant.id, "a7dd88da-f3bd-4f02-b50e-d9938bc1355c");
    expect(participant.createdAt, DateTime.parse("2022-05-13T13:27:31.789Z"));
    expect(participant.updatedAt, DateTime.parse("2022-05-14T13:27:31.789Z"));
    expect(participant.email, "educator@example.com");
    expect(participant.firstName, null);
    expect(participant.lastName, null);
    expect(participant.phone, null);
    expect(participant.roles, ["VOLUNTEER"]);
  });
}
