import 'package:flutter/material.dart';
import 'package:todd_coin_ui/widgets/random_words.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
