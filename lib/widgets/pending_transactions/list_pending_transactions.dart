import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/constants.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListPendingTransactions extends StatefulWidget {
  final ListPendingTransactionsController? listPendingTransactionsController;
  final void Function(PendingTransaction pendingTransaction) onSelect;

  const ListPendingTransactions(
      {Key? key,
      this.listPendingTransactionsController,
      required this.onSelect})
      : super(key: key);

  @override
  State<ListPendingTransactions> createState() =>
      _ListPendingTransactionsState();
}

class ListPendingTransactionsController {
  late PagewiseLoadController<PendingTransaction> pagewiseLoadController;
  String baseUrl;

  ListPendingTransactionsController({
    required this.baseUrl,
  }) {
    pagewiseLoadController = PagewiseLoadController<PendingTransaction>(
        pageSize: Constants.pageSize,
        pageFuture: (pageIndex) async {
          return loadPendingTransactions(
              baseUrl, pageIndex, Constants.pageSize);
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListPendingTransactionsState extends State<ListPendingTransactions> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listPendingTransactionsController?.reset();
      },
      child: PagewiseListView<PendingTransaction>(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, pendingTransaction, index) {
          return ListTile(
            title: Text(
              pendingTransaction.id!.substring(0, 8),
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(pendingTransaction);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return const Text('No pending transactions found.');
        },
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listPendingTransactionsController != null
            ? widget.listPendingTransactionsController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) =>
                    Future.value(<PendingTransaction>[]),
                pageSize: 0),
      ),
    );
  }
}
