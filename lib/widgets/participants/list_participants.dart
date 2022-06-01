import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/utilities/api_context.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

import '../../models/domain/participant.dart';

class ListParticipants extends StatefulWidget {
  final void Function(Participant participant) onSelect;
  final Organization? organization;

  const ListParticipants({Key? key, required this.onSelect, this.organization})
      : super(key: key);

  @override
  State<ListParticipants> createState() => _ListParticipantsState();
}

class _ListParticipantsState extends State<ListParticipants> {
  @override
  Widget build(BuildContext context) {
    return PagewiseListView<Participant>(
        pageSize: 10,
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
          return widget.organization == null
              ? const Text('No participants found.')
              : Text('No participants found for ${widget.organization?.name}');
        },
        pageFuture: (pageIndex) async {
          NavigatorState navigator = Navigator.of(context);
          String baseUrl = await ApiContext.getBaseUrl(navigator);

          return loadParticipants(baseUrl, widget.organization, pageIndex, 10);
        });
  }
}
