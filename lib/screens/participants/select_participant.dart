import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/widgets/participants/list_participants.dart';

import '../../models/domain/participant.dart';

class SelectParticipant extends StatefulWidget {
  final void Function(Participant participant) onSelect;
  final Organization? organization;

  const SelectParticipant({Key? key, required this.onSelect, this.organization})
      : super(key: key);

  @override
  State<SelectParticipant> createState() => _SelectParticipantState();
}

class _SelectParticipantState extends State<SelectParticipant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Participant')),
      body: ListParticipants(
        onSelect: (Participant participant) {
          widget.onSelect(participant);
        },
        organization: widget.organization,
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      )),
    );
  }
}
