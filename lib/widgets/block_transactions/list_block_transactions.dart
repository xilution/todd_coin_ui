import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

import '../../models/domain/block_transaction.dart';

class ListBlockTransactions extends StatefulWidget {
  final Block block;
  final void Function(BlockTransaction blockTransaction) onSelect;

  const ListBlockTransactions(
      {Key? key, required this.onSelect, required this.block})
      : super(key: key);

  @override
  State<ListBlockTransactions> createState() => _ListBlockTransactionsState();
}

class _ListBlockTransactionsState extends State<ListBlockTransactions> {
  @override
  Widget build(BuildContext context) {
    return PagewiseListView<BlockTransaction>(
        pageSize: 10,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, blockTransaction, index) {
          return ListTile(
            title: Text(
              blockTransaction.id,
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(blockTransaction);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return const Text('No blockTransactions found.');
        },
        pageFuture: (pageIndex) {
          return loadBlockTransactions(widget.block, pageIndex, 10);
        });
  }
}
