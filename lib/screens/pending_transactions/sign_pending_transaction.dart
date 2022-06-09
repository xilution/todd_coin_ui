import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/brokers/signed_transaction_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/screens/participant_keys/select_participant_key.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';
import 'package:todd_coin_ui/utilities/hash_utils.dart';
import 'package:todd_coin_ui/utilities/key_utils.dart';

class SignPendingTransaction extends StatefulWidget {
  final void Function(SignedTransaction signedTransaction) onSign;
  final PendingTransaction pendingTransaction;
  final Participant participant;

  const SignPendingTransaction(
      {Key? key,
      required this.onSign,
      required this.pendingTransaction,
      required this.participant})
      : super(key: key);

  @override
  State<SignPendingTransaction> createState() => _SignPendingTransactionState();
}

class _SignPendingTransactionState extends State<SignPendingTransaction> {
  final _formKey = GlobalKey<FormState>();
  final stepCount = 3;

  int _index = 0;
  ParticipantKey? _participantKey;
  double _goodPoints = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign a Pending Transaction')),
      body: Stepper(
        currentStep: _index,
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          if (details.currentStep == 0) {
            return Row(
              children: <TextButton>[
                TextButton(
                  onPressed: () {
                    if (_index < stepCount) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  child: const Icon(Icons.navigate_next),
                ),
              ],
            );
          } else if (details.currentStep == stepCount) {
            return Row(
              children: <TextButton>[
                TextButton(
                  onPressed: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  child: const Icon(Icons.navigate_before),
                ),
                TextButton(
                  onPressed: () async {
                    NavigatorState navigator = Navigator.of(context);
                    ScaffoldMessengerState scaffoldMessenger =
                        ScaffoldMessenger.of(context);
                    String baseUrl = await LocalStorageBroker.getBaseUrl();
                    Token token = await AppContext.getToken(navigator);

                    ParticipantKey? storedParticipantKey =
                        await LocalStorageBroker.getKey(_participantKey?.id);

                    String privateKey =
                        storedParticipantKey?.privateKey as String;

                    print("***** private key *****");
                    print(privateKey);

                    String publicKey =
                        storedParticipantKey?.publicKey as String;

                    print("***** public key *****");
                    print(publicKey);

                    SignedTransaction signedTransaction = SignedTransaction(
                      id: widget.pendingTransaction.id,
                      fromParticipant:
                          widget.pendingTransaction.fromParticipant,
                      toParticipant: widget.pendingTransaction.toParticipant,
                      fromOrganization:
                          widget.pendingTransaction.fromOrganization,
                      toOrganization: widget.pendingTransaction.toOrganization,
                      goodPoints: _goodPoints.round(),
                      description: widget.pendingTransaction.description,
                      type: widget.pendingTransaction.type,
                      details: widget.pendingTransaction.details,
                    );

                    print("***** signed transaction *****");
                    print(json.encode(signedTransaction.toJson()));

                    String hashHex =
                        calculateTransactionHash(signedTransaction);

                    print("***** hashHex *****");
                    print(hashHex);

                    String signature = getSignature(hashHex, privateKey);

                    SignedTransaction newSignedTransaction = SignedTransaction(
                      id: widget.pendingTransaction.id,
                      goodPoints: _goodPoints.round(),
                      signature: signature,
                      participantKey: _participantKey,
                    );

                    try {
                      SignedTransaction createdPendingTransaction =
                          await SignedTransactionBroker(Client(), baseUrl)
                              .createSignedTransaction(
                                  token.access, newSignedTransaction);

                      widget.onSign(createdPendingTransaction);
                    } catch (error) {
                      scaffoldMessenger.showSnackBar(SnackBar(
                        content: Text(error.toString()),
                      ));
                    }
                  },
                  child: const Icon(Icons.done),
                ),
              ],
            );
          } else {
            return Row(
              children: <TextButton>[
                TextButton(
                  onPressed: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  child: const Icon(Icons.navigate_before),
                ),
                TextButton(
                  onPressed: () {
                    if (_index < stepCount) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  child: const Icon(Icons.navigate_next),
                ),
              ],
            );
          }
        },
        steps: <Step>[
          Step(
            title: const Text('Summary'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                    'Here\'s a brief summary of the pending transaction')),
          ),
          Step(
            title: const Text('Point'),
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                      'Please kindly assign good points to this transaction.'),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _goodPoints,
                    label: '${_goodPoints.round()}',
                    onChanged: (value) {
                      setState(() {
                        _goodPoints = value;
                      });
                    },
                  ),
                  Text('${_goodPoints.round()}'),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Select Signing Key'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Which key do you want to use?'),
                Row(
                  children: _participantKey == null
                      ? [
                          const Icon(Icons.key),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            color: Colors.blue,
                            onPressed: () {
                              NavigatorState navigator = Navigator.of(context);
                              navigator.push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SelectParticipantKey(
                                    onSelect: (ParticipantKey participantKey) {
                                      setState(() {
                                        _participantKey = participantKey;
                                      });
                                      navigator.pop();
                                    },
                                    participant: widget.participant,
                                  );
                                },
                              ));
                            },
                          ),
                        ]
                      : [
                          const Icon(Icons.key),
                          Text(_participantKey?.id!.substring(0, 8) ?? ""),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _participantKey = null;
                              });
                            },
                          ),
                        ],
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Sign'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Thank you.')),
          ),
        ],
      ),
    );
  }
}
