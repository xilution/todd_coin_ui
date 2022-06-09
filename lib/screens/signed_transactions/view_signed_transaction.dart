import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';

class ViewSignedTransaction extends StatefulWidget {
  final SignedTransaction signedTransaction;

  const ViewSignedTransaction({Key? key, required this.signedTransaction})
      : super(key: key);

  @override
  State<ViewSignedTransaction> createState() => _ViewSignedTransactionState();
}

class _ViewSignedTransactionState extends State<ViewSignedTransaction> {
  @override
  Widget build(BuildContext context) {
    SignedTransaction signedTransaction = widget.signedTransaction;

    return Scaffold(
      appBar: AppBar(title: const Text('View a Signed Transaction')),
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
                  Text(signedTransaction.id ?? "Unknown")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
