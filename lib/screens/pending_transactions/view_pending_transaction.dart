import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/screens/pending_transactions/sign_pending_transaction.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';

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
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      NavigatorState navigator = Navigator.of(context);
                      ScaffoldMessengerState scaffoldMessenger =
                          ScaffoldMessenger.of(context);
                      Participant user = await AppContext.getUser(navigator);
                      navigator.push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return SignPendingTransaction(
                            onSign: (SignedTransaction signedTransaction) {
                              navigator.pop();
                              scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text('Pending Transaction Signed'),
                              ));
                            },
                            participant: user,
                            pendingTransaction: widget.pendingTransaction,
                          );
                        },
                      ));
                    },
                    child: const Text('Sign Transaction'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
