import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListParticipantKeys extends StatefulWidget {
  final ListParticipantKeysController? listParticipantKeysController;
  final void Function(ParticipantKey participant) onSelect;

  const ListParticipantKeys(
      {Key? key, this.listParticipantKeysController, required this.onSelect})
      : super(key: key);

  @override
  State<ListParticipantKeys> createState() => _ListParticipantKeysState();
}

class ListParticipantKeysController {
  late PagewiseLoadController<ParticipantKey> pagewiseLoadController;
  String baseUrl;
  Participant participant;

  ListParticipantKeysController({
    required this.baseUrl,
    required this.participant,
  }) {
    pagewiseLoadController = PagewiseLoadController<ParticipantKey>(
        pageSize: 10,
        pageFuture: (pageIndex) async {
          return loadParticipantKeys(baseUrl, participant, pageIndex, 10);
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListParticipantKeysState extends State<ListParticipantKeys> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listParticipantKeysController?.reset();
      },
      child: PagewiseListView<ParticipantKey>(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, participant, index) {
          return ListTile(
            title: Text(
              participant.id!.substring(0, 8),
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(participant);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return widget.listParticipantKeysController?.participant == null
              ? const Text('No participant keys found.')
              : Text(
                  'No participant keys found for ${widget.listParticipantKeysController?.participant.id}');
        },
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listParticipantKeysController != null
            ? widget.listParticipantKeysController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) => Future.value(<ParticipantKey>[]),
                pageSize: 0),
      ),
    );
  }
}
