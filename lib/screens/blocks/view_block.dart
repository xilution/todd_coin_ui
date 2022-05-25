import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/block.dart';

class ViewBlock extends StatefulWidget {
  final Block block;

  const ViewBlock({Key? key, required this.block}) : super(key: key);

  @override
  State<ViewBlock> createState() => _ViewBlockState();
}

class _ViewBlockState extends State<ViewBlock> {
  @override
  Widget build(BuildContext context) {
    Block block = widget.block;

    return Scaffold(
      appBar: AppBar(title: const Text('View a Block')),
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
                  Text(block.id)
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Sequence ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(block.sequenceId.toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
