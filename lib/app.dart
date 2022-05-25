import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/screens/auth/login.dart';
import 'package:todd_coin_ui/screens/pending_transactions/create_pending_transaction.dart';
import 'package:todd_coin_ui/screens/settings/edit_settings.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';
import 'package:todd_coin_ui/widgets/organizations/list_organizations.dart';
import 'package:todd_coin_ui/widgets/participants/list_participants.dart';

import 'screens/blocks/view_block.dart';
import 'widgets/blocks/list_blocks.dart';

const String _title = 'Todd Coin';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _getWidgetOptions(BuildContext context) {
    return <Widget>[
      ListBlocks(onSelect: (Block block) {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return ViewBlock(
              block: block,
            );
          },
        ));
      }),
      ListOrganizations(onSelect: (Organization organization) {}),
      ListParticipants(onSelect: (Participant participant) {}),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    AppContext.getBaseUrl().then((String? baseUrl) {
      if (baseUrl == null) {
        AppContext.setBaseUrl("http://localhost:3000");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                final navigator = Navigator.of(context);
                navigator.push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const EditSettings();
                  },
                ));
              }),
        ],
      ),
      body: Center(
        child: _getWidgetOptions(context).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Goodness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Organizations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Participants',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          Participant? user = await AppContext.getUser();

          navigator.push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return const CreatePendingTransaction();
            },
          ));

          if (user == null) {
            navigator.push(MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return const Login();
              },
            ));
          }
        },
        child: const Icon(Icons.add),
      )),
    );
  }
}
