import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

import '../../models/domain/block.dart';

class ListBlocks extends StatefulWidget {
  final void Function(Block block) onSelect;

  const ListBlocks({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<ListBlocks> createState() => _ListBlocksState();
}

class _ListBlocksState extends State<ListBlocks> {
  @override
  Widget build(BuildContext context) {
    return PagewiseListView<Block>(
        pageSize: 10,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, block, index) {
          return ListTile(
            title: Text(
              block.id,
              style: const TextStyle(fontSize: 18),
            ),
            onTap: () {
              widget.onSelect(block);
            },
          );
        },
        noItemsFoundBuilder: (context) {
          return const Text('No blocks found.');
        },
        pageFuture: (pageIndex) {
          return loadBlocks(pageIndex, 10);
        });
  }
}
