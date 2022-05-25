import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/widgets/blocks/list_blocks.dart';

class ViewBlocks extends StatefulWidget {
  final void Function(Block block) onSelect;

  const ViewBlocks({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<ViewBlocks> createState() => _ViewBlocksState();
}

class _ViewBlocksState extends State<ViewBlocks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Blocks')),
      body: ListBlocks(
        onSelect: (Block block) {
          widget.onSelect(block);
        },
      ),
    );
  }
}
