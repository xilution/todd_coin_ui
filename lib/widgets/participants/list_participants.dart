import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListParticipants extends StatefulWidget {
  final ListParticipantsController? listParticipantsController;
  final void Function(Participant participant) onSelect;

  const ListParticipants(
      {Key? key, this.listParticipantsController, required this.onSelect})
      : super(key: key);

  @override
  State<ListParticipants> createState() => _ListParticipantsState();
}

class ListParticipantsController {
  late PagewiseLoadController<Participant> pagewiseLoadController;
  String baseUrl;
  Organization? organization;

  ListParticipantsController({
    required this.baseUrl,
    this.organization,
  }) {
    pagewiseLoadController = PagewiseLoadController<Participant>(
        pageSize: 10,
        pageFuture: (pageIndex) async {
          return loadParticipants(baseUrl, organization, pageIndex, 10);
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListParticipantsState extends State<ListParticipants> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listParticipantsController?.reset();
      },
      child: PagewiseListView<Participant>(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, participant, index) {
          return ListTile(
            title: Text(
              participant.email ?? "Unknown",
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(participant);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return widget.listParticipantsController?.organization == null
              ? const Text('No participants found.')
              : Text(
                  'No participants found for ${widget.listParticipantsController?.organization?.name}');
        },
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listParticipantsController != null
            ? widget.listParticipantsController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) => Future.value(<Participant>[]),
                pageSize: 0),
      ),
    );
  }
}
