import 'dart:convert';

import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';

void main() {
  test('Should parse JSON', () {
    final signedTransaction = SignedTransaction.fromJson(json.decode("""
    {
			"type": "signed-transaction",
			"id": "76c87a20-c10f-491b-b52b-2e643a5c4df1",
			"links": {
				"self": "http://localhost:3000/signed-transactions/76c87a20-c10f-491b-b52b-2e643a5c4df1"
			},
			"attributes": {
				"createdAt": "2022-05-13T13:54:30.546Z",
				"updatedAt": "2022-05-14T02:30:22.003Z",
				"description": "judged spelling bee",
				"type": "TIME",
				"details": {
					"dateRanges": [
						{
							"to": "2022-05-13T13:54:22.000Z",
							"from": "2022-05-13T13:54:17.000Z"
						}
					]
				},
				"goodPoints": "10",
				"signature": "30450220437e5f4fd1dd8e54075749a511f9e7143743158ad2d575db785868a56f58acdc022100b41971aa3f69ebf5f3bf68788965973787d09dbe3cd190d476518d895bd7ae69"
			},
			"relationships": {
				"fromParticipant": {
					"data": {
						"type": "participant",
						"id": "630dfbe8-cdd8-4b7c-801d-907ea1b76d48"
					},
					"links": {
						"related": "http://localhost:3000/participants/630dfbe8-cdd8-4b7c-801d-907ea1b76d48"
					}
				},
				"fromOrganization": {
					"data": null
				},
				"toParticipant": {
					"data": {
						"type": "participant",
						"id": "81b97b2d-b5be-443f-996e-01687cb1b83a"
					},
					"links": {
						"related": "http://localhost:3000/participants/81b97b2d-b5be-443f-996e-01687cb1b83a"
					}
				},
				"toOrganization": {
					"data": null
				},
				"participantKey": {
					"data": {
						"type": "participant-key",
						"id": "7007b66e-e272-4eb8-badc-1cc825e2e326"
					},
					"links": {
						"related": "http://localhost:3000/participants/630dfbe8-cdd8-4b7c-801d-907ea1b76d48/7007b66e-e272-4eb8-badc-1cc825e2e326"
					}
				}
			}
		}
    """));

    expect(signedTransaction.id, "76c87a20-c10f-491b-b52b-2e643a5c4df1");
    expect(signedTransaction.createdAt,
        DateTime.parse("2022-05-13T13:54:30.546Z"));
    expect(signedTransaction.updatedAt,
        DateTime.parse("2022-05-14T02:30:22.003Z"));
  });
}
