import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/brokers/signed_transaction_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';

class EditSignedTransaction extends StatefulWidget {
  final SignedTransaction? existingSignedTransaction;
  final void Function(SignedTransaction signedTransaction) onSubmit;
  const EditSignedTransaction(
      {Key? key,
      required this.existingSignedTransaction,
      required this.onSubmit})
      : super(key: key);

  @override
  State<EditSignedTransaction> createState() => _EditSignedTransactionState();
}

class _EditSignedTransactionState extends State<EditSignedTransaction> {
  final _formKey = GlobalKey<FormState>();

  String? _description;
  String? _fromParticipantId;
  String? _fromOrganizationId;
  String? _toParticipantId;
  String? _toOrganizationId;
  String? _transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit a Signed Transaction')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _description = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _fromParticipantId,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'From Participant ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _fromParticipantId = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _toParticipantId,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'To Participant ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _toParticipantId = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _fromOrganizationId,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'From Organization ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _fromOrganizationId = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _toOrganizationId,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'To Organization ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _toOrganizationId = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _transactionType,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Transaction Type',
                ),
                items: ["Time", "Treasure"]
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _transactionType = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (widget.existingSignedTransaction != null) {
                            NavigatorState navigator = Navigator.of(context);
                            ScaffoldMessengerState scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            String baseUrl =
                                await LocalStorageBroker.getBaseUrl();
                            Token token = await AppContext.getToken(navigator);
                            SignedTransaction updatedSignedTransaction =
                                widget.existingSignedTransaction?.copy();
                            updatedSignedTransaction.description = _description;

                            try {
                              await SignedTransactionBroker(Client(), baseUrl)
                                  .updateSignedTransaction(
                                      token.access, updatedSignedTransaction);

                              widget.onSubmit(updatedSignedTransaction);
                            } catch (error) {
                              scaffoldMessenger.showSnackBar(SnackBar(
                                content: Text(error.toString()),
                              ));
                            }
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
