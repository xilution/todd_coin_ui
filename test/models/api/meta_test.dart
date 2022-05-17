import 'dart:convert';

import 'package:random_string/random_string.dart';
import 'package:test/test.dart';
import 'package:todd_coin_ui/models/api/meta.dart';

void main() {
  test('Should parse JSON', () {
    final totalPages = randomBetween(0, 10);
    final currentPage = randomBetween(0, 10);
    final totalItems = randomBetween(0, 10);
    final itemsPerPage = randomBetween(0, 10);

    final meta = Meta.fromJson(json.decode("""
      {
        "totalPages": $totalPages,
        "currentPage": $currentPage,
        "totalItems": $totalItems,
        "itemsPerPage": $itemsPerPage
      }
      """));

    expect(meta.totalPages, totalPages);
    expect(meta.currentPage, currentPage);
    expect(meta.totalItems, totalItems);
    expect(meta.itemsPerPage, itemsPerPage);
  });
}
