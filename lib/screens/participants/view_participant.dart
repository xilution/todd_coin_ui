import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';

class ViewParticipant extends StatefulWidget {
  final Participant participant;

  const ViewParticipant({Key? key, required this.participant})
      : super(key: key);

  @override
  State<ViewParticipant> createState() => _ViewParticipantState();
}

class _ViewParticipantState extends State<ViewParticipant> {
  @override
  Widget build(BuildContext context) {
    Participant participant = widget.participant;

    return Scaffold(
      appBar: AppBar(title: const Text('View a Participant')),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(participant.id ?? "Unknown")
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(participant.email ?? "Unknown")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
