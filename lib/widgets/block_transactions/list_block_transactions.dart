import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/constants.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListBlockTransactions extends StatefulWidget {
  final ListBlockTransactionsController? listBlockTransactionsController;
  final void Function(BlockTransaction blockTransaction) onSelect;

  const ListBlockTransactions(
      {Key? key, this.listBlockTransactionsController, required this.onSelect})
      : super(key: key);

  @override
  State<ListBlockTransactions> createState() => _ListBlockTransactionsState();
}

class ListBlockTransactionsController {
  late PagewiseLoadController<BlockTransaction> pagewiseLoadController;
  String baseUrl;
  Block block;

  ListBlockTransactionsController({
    required this.baseUrl,
    required this.block,
  }) {
    pagewiseLoadController = PagewiseLoadController<BlockTransaction>(
        pageSize: Constants.pageSize,
        pageFuture: (pageIndex) async {
          return loadBlockTransactions(
              baseUrl, block, pageIndex, Constants.pageSize);
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListBlockTransactionsState extends State<ListBlockTransactions> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listBlockTransactionsController?.reset();
      },
      child: PagewiseListView<BlockTransaction>(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, blockTransaction, index) {
          return ListTile(
            title: Text(
              blockTransaction.id!.substring(0, 8),
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(blockTransaction);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return widget.listBlockTransactionsController?.block == null
              ? const Text('No block transactions found.')
              : Text(
                  'No block transactions found for ${widget.listBlockTransactionsController?.block.id}');
        },
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listBlockTransactionsController != null
            ? widget.listBlockTransactionsController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) =>
                    Future.value(<BlockTransaction>[]),
                pageSize: 0),
      ),
    );
  }
}
