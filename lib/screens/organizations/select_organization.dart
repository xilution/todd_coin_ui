import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/widgets/organizations/list_organizations.dart';

import '../../models/domain/organization.dart';

class SelectOrganization extends StatefulWidget {
  final void Function(Organization organization) onSelect;
  final Participant? participant;

  const SelectOrganization({Key? key, required this.onSelect, this.participant})
      : super(key: key);

  @override
  State<SelectOrganization> createState() => _SelectOrganizationState();
}

class _SelectOrganizationState extends State<SelectOrganization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Organization')),
      body: ListOrganizations(
        onSelect: (Organization organization) {
          widget.onSelect(organization);
        },
        participant: widget.participant,
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      )),
    );
  }
}
