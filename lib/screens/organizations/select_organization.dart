import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/screens/organizations/edit_organization.dart';
import 'package:todd_coin_ui/widgets/organizations/list_organizations.dart';

class SelectOrganization extends StatefulWidget {
  final void Function(Organization organization) onSelect;
  final Participant? participant;

  const SelectOrganization({Key? key, required this.onSelect, this.participant})
      : super(key: key);

  @override
  State<SelectOrganization> createState() => _SelectOrganizationState();
}

class _SelectOrganizationState extends State<SelectOrganization> {
  ListOrganizationsController? _listOrganizationsController;

  @override
  void initState() {
    super.initState();

    LocalStorageBroker.getBaseUrl().then((String baseUrl) {
      setState(() {
        _listOrganizationsController =
            ListOrganizationsController(baseUrl: baseUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Organization')),
      body: ListOrganizations(
        onSelect: (Organization organization) {
          widget.onSelect(organization);
        },
        listOrganizationsController: _listOrganizationsController,
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: () {
          NavigatorState navigator = Navigator.of(context);
          navigator.push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return EditOrganization(
                onSubmit: (Organization organization) {
                  setState(() {
                    _listOrganizationsController?.reset();
                  });
                  navigator.pop();
                },
              );
            },
          ));
        },
        child: const Icon(Icons.add),
      )),
    );
  }
}
