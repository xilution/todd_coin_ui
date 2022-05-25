import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/widgets/organizations/list_organizations.dart';

class ViewOrganizations extends StatefulWidget {
  final void Function(Organization organization) onSelect;

  const ViewOrganizations({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<ViewOrganizations> createState() => _ViewOrganizationsState();
}

class _ViewOrganizationsState extends State<ViewOrganizations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Organizations')),
      body: ListOrganizations(
        onSelect: (Organization organization) {
          widget.onSelect(organization);
        },
      ),
    );
  }
}
