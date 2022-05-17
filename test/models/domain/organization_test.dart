import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';

void main() {
  test('Should parse JSON', () {
    final organization = Organization.fromJson(json.decode("""
    {
      "type": "organization",
      "id": "fd78a087-ddc0-495b-a24b-500dd26044c2",
      "links": {
        "self": "http://localhost:3000/organizations/fd78a087-ddc0-495b-a24b-500dd26044c2"
      },
      "attributes": {
        "createdAt": "2022-05-12T12:51:12.636Z",
        "updatedAt": "2022-05-12T13:51:12.636Z",
        "email": "vodje@ikabo.eu",
        "name": "Gentek Inc.",
        "roles": [
          "CHARITY"
        ],
        "domains": null
      },
      "relationships": {
        "participants": {
          "data": [],
          "links": {
            "related": "http://localhost:3000/organizations/fd78a087-ddc0-495b-a24b-500dd26044c2/participants?page[number]=0&page[size]=10"
          }
        },
        "administrators": {
          "data": [],
          "links": {
            "related": "http://localhost:3000/organizations/fd78a087-ddc0-495b-a24b-500dd26044c2/administrators?page[number]=0&page[size]=10"
          }
        },
        "authorizedSigners": {
          "data": [],
          "links": {
            "related": "http://localhost:3000/organizations/fd78a087-ddc0-495b-a24b-500dd26044c2/authorized-signers?page[number]=0&page[size]=10"
          }
        }
      }
    }
    """));

    expect(organization.id, "fd78a087-ddc0-495b-a24b-500dd26044c2");
    expect(organization.createdAt, DateTime.parse("2022-05-12T12:51:12.636Z"));
    expect(organization.updatedAt, DateTime.parse("2022-05-12T13:51:12.636Z"));
  });
}
