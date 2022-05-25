import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/widgets/participants/list_participants.dart';

class ViewParticipants extends StatefulWidget {
  final void Function(Participant participant) onSelect;

  const ViewParticipants({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<ViewParticipants> createState() => _ViewParticipantsState();
}

class _ViewParticipantsState extends State<ViewParticipants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Participants')),
      body: ListParticipants(
        onSelect: (Participant participant) {
          widget.onSelect(participant);
        },
      ),
    );
  }
}
