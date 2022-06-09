import 'package:todd_coin_ui/models/domain/signed_transaction.dart';

String calculateTransactionHash(SignedTransaction signedTransaction) {
  return signedTransaction.hash();
}
