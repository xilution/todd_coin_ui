import 'package:flutter/material.dart';
import 'package:todd_coin_ui/screens/blocks.dart';
import 'package:todd_coin_ui/screens/edit_pending_transaction.dart';
import 'package:todd_coin_ui/screens/settings.dart';
import 'package:todd_coin_ui/screens/transactions.dart';

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

  static const List<Widget> _widgetOptions = <Widget>[
    Transactions(optionStyle: optionStyle),
    Blocks(optionStyle: optionStyle),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horizontal_circle),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dataset),
            label: 'Blocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
          visible: _selectedIndex == 0,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Center(
                    child: Column(
                      children: const <Widget>[
                        EditPendingTransaction()
                        // const Text('Modal BottomSheet'),
                        // ElevatedButton(
                        //   child: const Text('Close BottomSheet'),
                        //   onPressed: () => Navigator.pop(context),
                        // )
                      ],
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          )),
    );
  }
}
