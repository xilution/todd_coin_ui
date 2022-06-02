import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:todd_coin_ui/brokers/pending_transaction_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';
import 'package:todd_coin_ui/models/domain/enums.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/models/domain/transaction_details.dart';
import 'package:todd_coin_ui/screens/date_ranges/select_date_range.dart';
import 'package:todd_coin_ui/screens/organizations/select_organization.dart';
import 'package:todd_coin_ui/screens/participants/select_participant.dart';
import 'package:todd_coin_ui/utilities/api_context.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';

class CreatePendingTransaction extends StatefulWidget {
  final void Function(PendingTransaction pendingTransaction) onCreate;

  const CreatePendingTransaction({Key? key, required this.onCreate})
      : super(key: key);

  @override
  State<CreatePendingTransaction> createState() =>
      _CreatePendingTransactionState();
}

class _CreatePendingTransactionState extends State<CreatePendingTransaction> {
  final _formKey = GlobalKey<FormState>();

  int _index = 0;
  String? _description;
  Participant? _toParticipant;
  Organization? _toOrganization;
  Participant? _fromParticipant;
  Organization? _fromOrganization;
  String? _transactionType = "TIME";
  DateRange? _dateRange;

  void _loadToParticipant() {
    AppContext.getUser().then((Participant? participant) {
      if (participant != null) {
        _toParticipant = participant;
      }
    });
  }

  @override
  void initState() {
    _loadToParticipant();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create a Pending Transaction')),
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
                    if (_index < 5) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  child: const Icon(Icons.navigate_next),
                ),
              ],
            );
          } else if (details.currentStep == 5) {
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
                    String baseUrl = await AppContext.getBaseUrl();
                    Token token = await ApiContext.getToken(navigator, baseUrl);

                    PendingTransaction newPendingTransaction =
                        PendingTransaction(
                      fromParticipant: _fromParticipant,
                      fromOrganization: _fromOrganization,
                      toParticipant: _toParticipant,
                      toOrganization: _toOrganization,
                      type: transactionTypeStrMap[_transactionType],
                      description: _description,
                      details: TimeTransactionDetails(
                          dateRanges: [_dateRange as DateRange]),
                    );

                    try {
                      PendingTransaction createdPendingTransaction =
                          await PendingTransactionBroker(Client(), baseUrl)
                              .createPendingTransaction(
                                  token.access, newPendingTransaction);

                      widget.onCreate(createdPendingTransaction);
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
                    if (_index < 5) {
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
            title: const Text('Description'),
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                      'Please kindly share a brief description of the goodness you shared.'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      initialValue: _description,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Beneficiary'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Who benefitted from your good deed?'),
                Row(
                  children: _fromOrganization == null
                      ? [
                          const Icon(Icons.business),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            color: Colors.blue,
                            onPressed: () {
                              NavigatorState navigator = Navigator.of(context);
                              navigator.push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SelectOrganization(
                                    onSelect: (Organization organization) {
                                      setState(() {
                                        _fromOrganization = organization;
                                      });
                                      navigator.pop();
                                    },
                                    participant: _fromParticipant,
                                  );
                                },
                              ));
                            },
                          ),
                        ]
                      : [
                          const Icon(Icons.business),
                          Text(_fromOrganization?.name ?? ""),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _fromOrganization = null;
                              });
                            },
                          ),
                        ],
                ),
                Row(
                  children: _fromParticipant == null
                      ? [
                          const Icon(Icons.person),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            color: Colors.blue,
                            onPressed: () {
                              NavigatorState navigator = Navigator.of(context);
                              navigator.push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SelectParticipant(
                                    onSelect: (Participant participant) {
                                      setState(() {
                                        _fromParticipant = participant;
                                      });
                                      navigator.pop();
                                    },
                                    organization: _fromOrganization,
                                  );
                                },
                              ));
                            },
                          ),
                        ]
                      : [
                          const Icon(Icons.person),
                          const Icon(Icons.business),
                          Text(_fromParticipant?.email ?? ""),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _fromParticipant = null;
                              });
                            },
                          ),
                        ],
                )
              ],
            ),
          ),
          Step(
            title: const Text('Benefactor'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                    'Are you a solo benefactor or are you contributing on behalf of an organization?'),
                Row(
                  children: _toOrganization == null
                      ? [
                          const Icon(Icons.business),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            color: Colors.blue,
                            onPressed: () {
                              NavigatorState navigator = Navigator.of(context);
                              navigator.push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SelectOrganization(
                                    onSelect: (Organization organization) {
                                      setState(() {
                                        _toOrganization = organization;
                                      });
                                      navigator.pop();
                                    },
                                    participant: _toParticipant,
                                  );
                                },
                              ));
                            },
                          ),
                        ]
                      : [
                          const Icon(Icons.business),
                          Text(_toOrganization?.name ?? ""),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _fromOrganization = null;
                              });
                            },
                          ),
                        ],
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Type'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Did you share time or treasure?'),
                ListTile(
                  title: const Text("Time"),
                  leading: Radio<String>(
                    value: "TIME",
                    groupValue: _transactionType,
                    onChanged: (value) {
                      setState(() {
                        _transactionType = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  title: const Text("Treasure"),
                  leading: Radio<String>(
                    value: "TREASURE",
                    groupValue: _transactionType,
                    onChanged: (value) {
                      setState(() {
                        _transactionType = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('When did you share your time?'),
                Row(
                  children: _dateRange == null
                      ? [
                          const Icon(Icons.schedule),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            color: Colors.blue,
                            onPressed: () {
                              NavigatorState navigator = Navigator.of(context);
                              navigator.push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SelectDateRange(
                                    onSelect: (DateRange dateRange) {
                                      setState(() {
                                        _dateRange = dateRange;
                                      });
                                      navigator.pop();
                                    },
                                  );
                                },
                              ));
                            },
                          ),
                        ]
                      : [
                          const Icon(Icons.schedule),
                          Text(
                              '${DateFormat().format(_dateRange?.from as DateTime)} ->\n${DateFormat().format(_dateRange?.to as DateTime)}'),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _dateRange = null;
                              });
                            },
                          ),
                        ],
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Submit'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Thank you for sharing the goodness.')),
          ),
        ],
      ),
    );
  }
}
