import 'dart:convert';

import 'package:random_string/random_string.dart';
import 'package:test/test.dart';
import 'package:todd_coin_ui/models/api/fetch_one_response.dart';

void main() {
  test('Should parse JSON', () {
    final id = randomAlpha(10);
    final bar = randomAlpha(10);

    final manyResponse = FetchOneResponse.fromJson(json.decode("""
      {
        "data": {
          "id": "$id",
          "attributes": {
            "foo": "$bar"
          }
        }
      }
      """));

    expect(manyResponse.data.toString(), "{id: $id, attributes: {foo: $bar}}");
  });
}
