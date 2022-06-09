import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/widgets/signed_transactions/list_signed_transactions.dart';

class ViewSignedTransactions extends StatefulWidget {
  final void Function(SignedTransaction signedTransaction) onSelect;

  const ViewSignedTransactions({Key? key, required this.onSelect})
      : super(key: key);

  @override
  State<ViewSignedTransactions> createState() => _ViewSignedTransactionsState();
}

class _ViewSignedTransactionsState extends State<ViewSignedTransactions> {
  ListSignedTransactionsController? _listSignedTransactionsController;

  @override
  void initState() {
    super.initState();

    LocalStorageBroker.getBaseUrl().then((String baseUrl) {
      setState(() {
        _listSignedTransactionsController =
            ListSignedTransactionsController(baseUrl: baseUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Signed Transactions')),
      body: ListSignedTransactions(
        onSelect: (SignedTransaction signedTransaction) {
          widget.onSelect(signedTransaction);
        },
        listSignedTransactionsController: _listSignedTransactionsController,
      ),
    );
  }
}
