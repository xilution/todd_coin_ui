import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';

class TimeTransactionDetails {
  final List<DateRange> dateRanges;

  // todo - add other properties

  TimeTransactionDetails({required this.dateRanges});

  Map<String, dynamic> toJson() => {
        'dateRanges': dateRanges
            .map((DateRange dateRange) => dateRange.toJson())
            .toList(),
      };

  copy() {
    return TimeTransactionDetails(
      dateRanges: dateRanges,
    );
  }

  String hash() {
    TimeTransactionDetails copy = this.copy();

    copy.dateRanges.sort((DateRange dateRange1, DateRange dateRange2) {
      int fromDiff = (dateRange1.from?.millisecondsSinceEpoch ?? 0) - (dateRange2.from?.millisecondsSinceEpoch ?? 0);

      if (fromDiff != 0) {
        return fromDiff;
      }

      return (dateRange1.to?.millisecondsSinceEpoch ?? 0) - (dateRange2.to?.millisecondsSinceEpoch ?? 0);
    });

    String joinedParts = copy.dateRanges.map((DateRange dateRange) => dateRange.hash()).toList().join();

    return sha256.convert(utf8.encode(joinedParts)).toString();
  }
}

class TreasureTransactionDetails {
  final int amount;

  // todo - add other properties

  TreasureTransactionDetails({required this.amount});

  Map<String, dynamic> toJson() => {
        'amount': amount,
      };
}
