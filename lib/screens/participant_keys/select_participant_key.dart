import 'package:elliptic/elliptic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/brokers/participant_key_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';
import 'package:todd_coin_ui/utilities/key_utils.dart';
import 'package:todd_coin_ui/widgets/participant_keys/list_participant_keys.dart';

class SelectParticipantKey extends StatefulWidget {
  final void Function(ParticipantKey participant) onSelect;
  final Participant participant;

  const SelectParticipantKey(
      {Key? key, required this.onSelect, required this.participant})
      : super(key: key);

  @override
  State<SelectParticipantKey> createState() => _SelectParticipantKeyState();
}

class _SelectParticipantKeyState extends State<SelectParticipantKey> {
  ListParticipantKeysController? _listParticipantKeysController;

  @override
  void initState() {
    super.initState();

    LocalStorageBroker.getBaseUrl().then((String baseUrl) {
      setState(() {
        _listParticipantKeysController = ListParticipantKeysController(
            baseUrl: baseUrl, participant: widget.participant);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Participant Key')),
      body: ListParticipantKeys(
        onSelect: (ParticipantKey participant) {
          widget.onSelect(participant);
        },
        listParticipantKeysController: _listParticipantKeysController,
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: () async {
          NavigatorState navigator = Navigator.of(context);

          ParticipantKey newParticipantKey = generateParticipantKey();

          String baseUrl = await LocalStorageBroker.getBaseUrl();
          Token token = await AppContext.getToken(navigator);
          ParticipantKey createdParticipantKey =
              await ParticipantKeyBroker(Client(), baseUrl)
                  .createParticipantKey(
                      token.access, widget.participant, newParticipantKey);
          createdParticipantKey.privateKey = newParticipantKey.privateKey;
          await LocalStorageBroker.addKey(createdParticipantKey);

          _listParticipantKeysController?.reset();
        },
        child: const Icon(Icons.add),
      )),
    );
  }
}
