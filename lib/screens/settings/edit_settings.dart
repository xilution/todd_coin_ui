import 'package:flutter/material.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';
import 'package:validators/validators.dart';

class EditSettings extends StatefulWidget {
  const EditSettings({Key? key}) : super(key: key);

  @override
  State<EditSettings> createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  final _formKey = GlobalKey<FormState>();

  String _baseUrl = "";

  @override
  void initState() {
    AppContext.getBaseUrl().then((String? baseUrl) {
      setState(() {
        _baseUrl = baseUrl ?? "";
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
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  if (_formKey.currentState!.validate()) {
                    await AppContext.setBaseUrl(_baseUrl);
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Settings Saved')),
                    );
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
