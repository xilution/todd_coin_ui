import 'package:flutter/material.dart';

class Blocks extends StatelessWidget {
  const Blocks({
    Key? key,
    required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Blocks Yo',
      style: optionStyle,
    );
  }
}