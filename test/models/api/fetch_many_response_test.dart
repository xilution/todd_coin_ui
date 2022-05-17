import 'dart:convert';

import 'package:random_string/random_string.dart';
import 'package:test/test.dart';
import 'package:todd_coin_ui/models/api/fetch_many_response.dart';

void main() {
  test('Should parse JSON', () {
    final baz = randomAlpha(10);
    final id1 = randomAlpha(10);
    final bar1 = randomAlpha(10);
    final id2 = randomAlpha(10);
    final bar2 = randomAlpha(10);

    final manyResponse = FetchManyResponse.fromJson(json.decode("""
      {
        "meta": {
          "boo": "$baz"
        },
        "data": [
          {
            "id": "$id1",
            "attributes": {
              "foo": "$bar1"
            }
          },
          {
            "id": "$id2",
            "attributes": {
              "foo": "$bar2"
            }
          }
        ]
      }
      """));

    expect(manyResponse.meta.toString(), "{boo: $baz}");
    expect(manyResponse.data[0].toString(),
        "{id: $id1, attributes: {foo: $bar1}}");
    expect(manyResponse.data[1].toString(),
        "{id: $id2, attributes: {foo: $bar2}}");
  });
}
