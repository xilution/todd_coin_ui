import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/auth_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/utilities/api_context.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  final String baseUrl;
  final void Function(Participant user, Token token) onLogin;

  const Login({Key? key, required this.baseUrl, required this.onLogin})
      : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: TextEditingController(text: _email),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  if (!isEmail(value)) {
                    return 'Not a valid email';
                  }
                  return null;
                },
                onChanged: (text) {
                  _email = text;
                },
                autofocus: true,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: TextEditingController(text: _password),
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
                  _password = text;
                },
                autofocus: true,
                autocorrect: false,
                autofillHints: const [AutofillHints.password],
                obscureText: true,
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
                              await ApiContext.getBaseUrl(navigator);
                          AuthBroker authBroker = AuthBroker(Client(), baseUrl);

                          try {
                            Token token =
                                await authBroker.fetchToken(_email, _password);
                            await AppContext.setToken(token);
                            Participant user =
                                await authBroker.fetchUserInfo(token.access);
                            await AppContext.setUser(user);

                            widget.onLogin(user, token);
                          } catch (error) {
                            scaffoldMessenger.showSnackBar(SnackBar(
                              content: Text(error.toString()),
                            ));
                          }
                        }
                      },
                      child: const Text('Login'),
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
