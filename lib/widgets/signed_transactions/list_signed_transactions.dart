import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/constants.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListSignedTransactions extends StatefulWidget {
  final ListSignedTransactionsController? listSignedTransactionsController;
  final void Function(SignedTransaction signedTransaction) onSelect;

  const ListSignedTransactions(
      {Key? key, this.listSignedTransactionsController, required this.onSelect})
      : super(key: key);

  @override
  State<ListSignedTransactions> createState() => _ListSignedTransactionsState();
}

class ListSignedTransactionsController {
  late PagewiseLoadController<SignedTransaction> pagewiseLoadController;
  String baseUrl;

  ListSignedTransactionsController({
    required this.baseUrl,
  }) {
    pagewiseLoadController = PagewiseLoadController<SignedTransaction>(
        pageSize: Constants.pageSize,
        pageFuture: (pageIndex) async {
          return loadSignedTransactions(baseUrl, pageIndex, Constants.pageSize);
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListSignedTransactionsState extends State<ListSignedTransactions> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listSignedTransactionsController?.reset();
      },
      child: PagewiseListView<SignedTransaction>(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, signedTransaction, index) {
          return ListTile(
            title: Text(
              signedTransaction.id!.substring(0, 8),
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(signedTransaction);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return const Text('No signed transactions found.');
        },
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listSignedTransactionsController != null
            ? widget.listSignedTransactionsController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) =>
                    Future.value(<SignedTransaction>[]),
                pageSize: 0),
      ),
    );
  }
}
