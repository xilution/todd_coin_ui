import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/utilities/api_context.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

import '../../models/domain/organization.dart';

class ListOrganizations extends StatefulWidget {
  final void Function(Organization organization) onSelect;
  final Participant? participant;

  const ListOrganizations({Key? key, required this.onSelect, this.participant})
      : super(key: key);

  @override
  State<ListOrganizations> createState() => _ListOrganizationsState();
}

class _ListOrganizationsState extends State<ListOrganizations> {
  @override
  Widget build(BuildContext context) {
    return PagewiseListView<Organization>(
        pageSize: 10,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, organization, index) {
          return ListTile(
            title: Text(
              organization.name ?? "Unknown",
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(organization);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return widget.participant == null
              ? const Text('No organizations found.')
              : Text('No organizations found for ${widget.participant?.email}');
        },
        pageFuture: (pageIndex) async {
          NavigatorState navigator = Navigator.of(context);
          String baseUrl = await ApiContext.getBaseUrl(navigator);

          return loadOrganizations(baseUrl, widget.participant, pageIndex, 10);
        });
  }
}
