import 'package:flutter/material.dart';
import 'package:todd_coin_ui/random_words.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Todd Coin';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}
