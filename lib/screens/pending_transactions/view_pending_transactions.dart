import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/widgets/pending_transactions/list_pending_transactions.dart';

class ViewPendingTransactions extends StatefulWidget {
  final void Function(PendingTransaction pendingTransaction) onSelect;

  const ViewPendingTransactions({Key? key, required this.onSelect})
      : super(key: key);

  @override
  State<ViewPendingTransactions> createState() =>
      _ViewPendingTransactionsState();
}

class _ViewPendingTransactionsState extends State<ViewPendingTransactions> {
  ListPendingTransactionsController? _listPendingTransactionsController;

  @override
  void initState() {
    super.initState();

    LocalStorageBroker.getBaseUrl().then((String baseUrl) {
      setState(() {
        _listPendingTransactionsController =
            ListPendingTransactionsController(baseUrl: baseUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Pending Transactions')),
      body: ListPendingTransactions(
        onSelect: (PendingTransaction pendingTransaction) {
          widget.onSelect(pendingTransaction);
        },
        listPendingTransactionsController: _listPendingTransactionsController,
      ),
    );
  }
}
