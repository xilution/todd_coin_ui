import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/brokers/participant_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';

class EditParticipant extends StatefulWidget {
  final Participant? existingParticipant;
  final void Function(Participant particpant) onSubmit;

  const EditParticipant(
      {Key? key, this.existingParticipant, required this.onSubmit})
      : super(key: key);

  @override
  State<EditParticipant> createState() => _EditParticipantState();
}

class _EditParticipantState extends State<EditParticipant> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit a Participant')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _email = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _password,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _password = text;
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
                          NavigatorState navigator = Navigator.of(context);
                          ScaffoldMessengerState scaffoldMessenger =
                              ScaffoldMessenger.of(context);
                          String baseUrl =
                              await LocalStorageBroker.getBaseUrl();

                          if (widget.existingParticipant != null) {
                            Token token = await AppContext.getToken(navigator);

                            Participant updatedParticipant =
                                widget.existingParticipant?.copy();
                            updatedParticipant.email = _email;
                            try {
                              await ParticipantBroker(Client(), baseUrl)
                                  .updateParticipant(
                                      token.access, updatedParticipant);

                              widget.onSubmit(updatedParticipant);
                            } catch (error) {
                              scaffoldMessenger.showSnackBar(SnackBar(
                                content: Text(error.toString()),
                              ));
                            }
                          } else {
                            Participant newParticipant = Participant(
                                email: _email,
                                password: _password,
                                roles: ["VOLUNTEER"]);
                            try {
                              await ParticipantBroker(Client(), baseUrl)
                                  .createParticipant(newParticipant);

                              widget.onSubmit(newParticipant);
                            } catch (error) {
                              scaffoldMessenger.showSnackBar(SnackBar(
                                content: Text(error.toString()),
                              ));
                            }
                          }
                        }
                      },
                      child: const Text('Create'),
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
