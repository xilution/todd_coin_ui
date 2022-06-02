import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';

class ViewPendingTransaction extends StatefulWidget {
  final PendingTransaction pendingTransaction;

  const ViewPendingTransaction({Key? key, required this.pendingTransaction})
      : super(key: key);

  @override
  State<ViewPendingTransaction> createState() => _ViewPendingTransactionState();
}

class _ViewPendingTransactionState extends State<ViewPendingTransaction> {
  @override
  Widget build(BuildContext context) {
    PendingTransaction pendingTransaction = widget.pendingTransaction;

    return Scaffold(
      appBar: AppBar(title: const Text('View a Pending Transaction')),
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
                  Text(pendingTransaction.id ?? "Unknown")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
