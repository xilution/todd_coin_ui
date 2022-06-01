import 'package:todd_coin_ui/models/domain/date_range.dart';

class TimeTransactionDetails {
  final List<DateRange> dateRanges;
  // todo - add other properties

  TimeTransactionDetails({required this.dateRanges});
}

class TreasureTransactionDetails {
  final int amount;
  // todo - add other properties

  TreasureTransactionDetails({required this.amount});
}
