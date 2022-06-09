import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/widgets/organizations/list_organizations.dart';

class ViewOrganizations extends StatefulWidget {
  final void Function(Organization organization) onSelect;
  final Participant? participant;

  const ViewOrganizations({Key? key, required this.onSelect, this.participant})
      : super(key: key);

  @override
  State<ViewOrganizations> createState() => _ViewOrganizationsState();
}

class _ViewOrganizationsState extends State<ViewOrganizations> {
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
      appBar: AppBar(title: const Text('View Organizations')),
      body: ListOrganizations(
        onSelect: (Organization organization) {
          widget.onSelect(organization);
        },
        listOrganizationsController: _listOrganizationsController,
      ),
    );
  }
}
