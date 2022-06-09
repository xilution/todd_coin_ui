import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';
import 'package:todd_coin_ui/widgets/block_transactions/list_block_transactions.dart';

class ViewBlockTransactions extends StatefulWidget {
  final void Function(BlockTransaction blockTransaction) onSelect;
  final Block block;

  const ViewBlockTransactions(
      {Key? key, required this.onSelect, required this.block})
      : super(key: key);

  @override
  State<ViewBlockTransactions> createState() => _ViewBlockTransactionsState();
}

class _ViewBlockTransactionsState extends State<ViewBlockTransactions> {
  ListBlockTransactionsController? _listBlockTransactionsController;

  @override
  void initState() {
    super.initState();

    LocalStorageBroker.getBaseUrl().then((String baseUrl) {
      setState(() {
        _listBlockTransactionsController = ListBlockTransactionsController(
            baseUrl: baseUrl, block: widget.block);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Block Transactions')),
      body: ListBlockTransactions(
        onSelect: (BlockTransaction blockTransaction) {
          widget.onSelect(blockTransaction);
        },
        listBlockTransactionsController: _listBlockTransactionsController,
      ),
    );
  }
}
