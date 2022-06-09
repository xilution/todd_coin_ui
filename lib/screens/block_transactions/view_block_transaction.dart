import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';

class ViewBlockTransaction extends StatefulWidget {
  final BlockTransaction blockTransaction;

  const ViewBlockTransaction({Key? key, required this.blockTransaction})
      : super(key: key);

  @override
  State<ViewBlockTransaction> createState() => _ViewBlockTransactionState();
}

class _ViewBlockTransactionState extends State<ViewBlockTransaction> {
  @override
  Widget build(BuildContext context) {
    BlockTransaction blockTransaction = widget.blockTransaction;

    return Scaffold(
      appBar: AppBar(title: const Text('View a Block Transaction')),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(blockTransaction.id ?? "Unknown")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
