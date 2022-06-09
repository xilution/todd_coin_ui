import 'package:test/test.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';
import 'package:todd_coin_ui/models/domain/enums.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/models/domain/transaction_details.dart';
import 'package:todd_coin_ui/utilities/hash_utils.dart';

void main() {
  group('calculateTransactionHash', () {
    group('when transaction type is TIME', () {
      group('when minimum amount of data is set', () {
        test('should return the correct response', () {
          SignedTransaction signedTransaction = SignedTransaction(
              description: "The quick red fox jumped over the lazy brown dog.",
              details: TimeTransactionDetails(dateRanges: [
                DateRange(
                  from: DateTime.parse("2022-06-06T10:57:28.055Z"),
                  to: DateTime.parse("2022-06-06T11:57:28.055Z"),
                ),
                DateRange(
                  from: DateTime.parse("2022-06-06T11:57:28.055Z"),
                  to: DateTime.parse("2022-06-06T12:57:28.055Z"),
                )
              ]),
              goodPoints: 1234,
              type: TransactionType.time);

          expect(calculateTransactionHash(signedTransaction),
              "30fe75f211bfea7a4051c4f19fc6897c7380b5790f31da88b9c1c801a66e0543");
        });
      });

      group('when id is present', () {
        test('should return the correct response', () {
          SignedTransaction signedTransaction = SignedTransaction(
              id: "852a592a-ed11-4082-9f3e-57559227351a",
              description: "The quick red fox jumped over the lazy brown dog.",
              details: TimeTransactionDetails(dateRanges: [
                DateRange(
                  from: DateTime.parse("2022-06-06T10:57:28.055Z"),
                  to: DateTime.parse("2022-06-06T11:57:28.055Z"),
                ),
                DateRange(
                  from: DateTime.parse("2022-06-06T11:57:28.055Z"),
                  to: DateTime.parse("2022-06-06T12:57:28.055Z"),
                )
              ]),
              goodPoints: 1234,
              type: TransactionType.time);

          expect(calculateTransactionHash(signedTransaction),
              "e1d23ac22e54ce05dd3d78a5f834f707a0bd55ab85a83bc0cbd224a8c5af5444");
        });
      });

      group('when participants and organizations are present', () {
        test('should return the correct response', () {
          SignedTransaction signedTransaction = SignedTransaction(
              id: "852a592a-ed11-4082-9f3e-57559227351a",
              fromParticipant:
                  Participant(id: "09cbccd1-b974-4b95-9929-8af02833d584"),
              toParticipant:
                  Participant(id: "b871e4af-5329-47be-8922-47638de3bddd"),
              fromOrganization:
                  Organization(id: "ea75c11a-2a16-4ff6-b81a-e4721ca265c1"),
              toOrganization:
                  Organization(id: "28631269-144f-4d11-83fe-92875b742e5d"),
              description: "The quick red fox jumped over the lazy brown dog.",
              details: TimeTransactionDetails(dateRanges: [
                DateRange(
                  from: DateTime.parse("2022-06-06T10:57:28.055Z"),
                  to: DateTime.parse("2022-06-06T11:57:28.055Z"),
                ),
                DateRange(
                  from: DateTime.parse("2022-06-06T11:57:28.055Z"),
                  to: DateTime.parse("2022-06-06T12:57:28.055Z"),
                )
              ]),
              goodPoints: 1234,
              type: TransactionType.time);

          expect(calculateTransactionHash(signedTransaction),
              "bb7a7710e689f2ccb16d6bc00279a49d8226dd4c78e20fb6fdd2d8ed69863f17");
        });
      });
    });
  });
}
