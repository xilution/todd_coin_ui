import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/organization_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/utilities/api_context.dart';

class EditOrganization extends StatefulWidget {
  final Organization? existingOrganization;
  final void Function(Organization? organization) onSubmit;

  const EditOrganization(
      {Key? key, this.existingOrganization, required this.onSubmit})
      : super(key: key);

  @override
  State<EditOrganization> createState() => _EditOrganizationState();
}

class _EditOrganizationState extends State<EditOrganization> {
  final _formKey = GlobalKey<FormState>();

  String? _name;

  @override
  void initState() {
    _name = widget.existingOrganization?.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit an Organization')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _name = text;
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
                              await ApiContext.getBaseUrl(navigator);
                          Token token =
                              await ApiContext.getToken(navigator, baseUrl);

                          if (widget.existingOrganization != null) {
                            Organization updatedOrganization =
                                widget.existingOrganization?.copy();
                            updatedOrganization.name = _name;

                            try {
                              await OrganizationBroker(Client(), baseUrl)
                                  .updateOrganization(
                                      token.access, updatedOrganization);

                              widget.onSubmit(updatedOrganization);
                            } catch (error) {
                              scaffoldMessenger.showSnackBar(SnackBar(
                                content: Text(error.toString()),
                              ));
                            }
                          } else {
                            Organization newOrganization =
                                Organization(name: _name, roles: ["CHARITY"]);

                            try {
                              await OrganizationBroker(Client(), baseUrl)
                                  .createOrganization(
                                      token.access, newOrganization);

                              widget.onSubmit(newOrganization);
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
