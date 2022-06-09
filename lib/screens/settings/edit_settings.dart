import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:validators/validators.dart';

class EditSettings extends StatefulWidget {
  final void Function(String baseUrl) onSave;

  const EditSettings({Key? key, required this.onSave}) : super(key: key);

  @override
  State<EditSettings> createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  final _formKey = GlobalKey<FormState>();

  String _baseUrl = "";

  @override
  void initState() {
    LocalStorageBroker.getBaseUrl().then((String? baseUrl) {
      setState(() {
        _baseUrl = baseUrl ?? "http://localhost:3000";
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Settings')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: TextEditingController(text: _baseUrl),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Todd Coin Base URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  if (!isURL(value)) {
                    return 'Not a valid URL';
                  }
                  return null;
                },
                onChanged: (text) {
                  _baseUrl = text;
                },
                autofocus: true,
                autocorrect: false,
                autofillHints: const [AutofillHints.url],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessengerState scaffoldMessenger =
                        ScaffoldMessenger.of(context);

                    try {
                      await LocalStorageBroker.setBaseUrl(_baseUrl);

                      widget.onSave(_baseUrl);
                    } catch (error) {
                      scaffoldMessenger.showSnackBar(SnackBar(
                        content: Text(error.toString()),
                      ));
                    }
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
