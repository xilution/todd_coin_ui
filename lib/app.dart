import 'package:flutter/material.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';
import 'package:todd_coin_ui/screens/blocks/view_block.dart';
import 'package:todd_coin_ui/screens/organizations/view_organization.dart';
import 'package:todd_coin_ui/screens/participants/view_participant.dart';
import 'package:todd_coin_ui/screens/pending_transactions/create_pending_transaction.dart';
import 'package:todd_coin_ui/screens/pending_transactions/view_pending_transaction.dart';
import 'package:todd_coin_ui/screens/settings/edit_settings.dart';
import 'package:todd_coin_ui/screens/signed_transactions/view_signed_transaction.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';
import 'package:todd_coin_ui/widgets/blocks/list_blocks.dart';
import 'package:todd_coin_ui/widgets/organizations/list_organizations.dart';
import 'package:todd_coin_ui/widgets/participants/list_participants.dart';
import 'package:todd_coin_ui/widgets/pending_transactions/list_pending_transactions.dart';
import 'package:todd_coin_ui/widgets/signed_transactions/list_signed_transactions.dart';

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

class _AppHomeState extends State<AppHome> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  ListPendingTransactionsController? _listPendingTransactionsController;
  ListSignedTransactionsController? _listSignedTransactionsController;
  ListBlocksController? _listBlocksController;
  ListParticipantsController? _listParticipantsController;
  ListOrganizationsController? _listOrganizationsController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    LocalStorageBroker.getBaseUrl().then((String baseUrl) {
      setState(() {
        _listPendingTransactionsController =
            ListPendingTransactionsController(baseUrl: baseUrl);
        _listSignedTransactionsController =
            ListSignedTransactionsController(baseUrl: baseUrl);
        _listBlocksController = ListBlocksController(baseUrl: baseUrl);
        _listParticipantsController =
            ListParticipantsController(baseUrl: baseUrl);
        _listOrganizationsController =
            ListOrganizationsController(baseUrl: baseUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        bottom: _selectedIndex == 0
            ? TabBar(controller: _tabController, tabs: const <Widget>[
                Tab(
                  text: 'Pending Txs',
                ),
                Tab(
                  text: 'Signed Txs',
                ),
                Tab(
                  text: 'Blocks',
                ),
              ])
            : null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                final navigator = Navigator.of(context);
                navigator.push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return EditSettings(
                      onSave: (String baseUrl) {},
                    );
                  },
                ));
              }),
          IconButton(
              icon: const Icon(Icons.person),
              onPressed: () async {
                final navigator = Navigator.of(context);
                Participant user = await AppContext.getUser(navigator);
                navigator.push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return ViewParticipant(participant: user);
                  },
                ));
              }),
        ],
      ),
      body: Center(
        child: <Widget>[
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListPendingTransactions(
                onSelect: (PendingTransaction pendingTransaction) {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return ViewPendingTransaction(
                        pendingTransaction: pendingTransaction,
                      );
                    },
                  ));
                },
                listPendingTransactionsController:
                    _listPendingTransactionsController,
              ),
              ListSignedTransactions(
                onSelect: (SignedTransaction signedTransaction) {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return ViewSignedTransaction(
                        signedTransaction: signedTransaction,
                      );
                    },
                  ));
                },
                listSignedTransactionsController:
                    _listSignedTransactionsController,
              ),
              ListBlocks(
                onSelect: (Block block) {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return ViewBlock(
                        block: block,
                      );
                    },
                  ));
                },
                listBlocksController: _listBlocksController,
              ),
            ],
          ),
          ListParticipants(
            onSelect: (Participant participant) {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ViewParticipant(
                    participant: participant,
                  );
                },
              ));
            },
            listParticipantsController: _listParticipantsController,
          ),
          ListOrganizations(
            onSelect: (Organization organization) {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ViewOrganization(
                    organization: organization,
                  );
                },
              ));
            },
            listOrganizationsController: _listOrganizationsController,
          ),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Goodness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Participants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Organizations',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
          visible: _selectedIndex == 0,
          child: FloatingActionButton(
            onPressed: () async {
              if (_selectedIndex == 0) {
                NavigatorState navigator = Navigator.of(context);
                ScaffoldMessengerState scaffoldMessenger =
                    ScaffoldMessenger.of(context);
                Participant user = await AppContext.getUser(navigator);
                navigator.push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return CreatePendingTransaction(
                      onCreate: (PendingTransaction pendingTransaction) {
                        navigator.pop();
                        _listPendingTransactionsController?.reset();
                        scaffoldMessenger.showSnackBar(const SnackBar(
                          content: Text('Pending Transaction Created'),
                        ));
                      },
                      participant: user,
                    );
                  },
                ));
              }
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
