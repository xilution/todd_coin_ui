import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListOrganizations extends StatefulWidget {
  final ListOrganizationsController? listOrganizationsController;
  final void Function(Organization organization) onSelect;

  const ListOrganizations(
      {Key? key, this.listOrganizationsController, required this.onSelect})
      : super(key: key);

  @override
  State<ListOrganizations> createState() => _ListOrganizationsState();
}

class ListOrganizationsController {
  late PagewiseLoadController<Organization> pagewiseLoadController;
  String baseUrl;
  Participant? participant;

  ListOrganizationsController({
    required this.baseUrl,
    this.participant,
  }) {
    pagewiseLoadController = PagewiseLoadController<Organization>(
        pageSize: 10,
        pageFuture: (pageIndex) async {
          return loadOrganizations(baseUrl, participant, pageIndex, 10);
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListOrganizationsState extends State<ListOrganizations> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listOrganizationsController?.reset();
      },
      child: PagewiseListView<Organization>(
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
          return widget.listOrganizationsController?.participant == null
              ? const Text('No organizations found.')
              : Text(
                  'No organizations found for ${widget.listOrganizationsController?.participant?.email}');
        },
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listOrganizationsController != null
            ? widget.listOrganizationsController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) => Future.value(<Organization>[]),
                pageSize: 0),
      ),
    );
  }
}
