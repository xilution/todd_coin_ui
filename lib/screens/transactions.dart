import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({
    Key? key,
    required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Transactions Yo',
      style: optionStyle,
    );
  }
}