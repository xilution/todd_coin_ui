import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/utilities/data_helpers.dart';

class ListBlocks extends StatefulWidget {
  final ListBlocksController? listBlocksController;
  final void Function(Block block) onSelect;

  const ListBlocks(
      {Key? key, this.listBlocksController, required this.onSelect})
      : super(key: key);

  @override
  State<ListBlocks> createState() => _ListBlocksState();
}

class ListBlocksController {
  late PagewiseLoadController<Block> pagewiseLoadController;
  String baseUrl;

  ListBlocksController({
    required this.baseUrl,
  }) {
    pagewiseLoadController = PagewiseLoadController<Block>(
        pageSize: 10,
        pageFuture: (pageIndex) async {
          var loadBlocks2 = loadBlocks(baseUrl, pageIndex, 10);
          return loadBlocks2;
        });
  }

  void reset() {
    pagewiseLoadController.reset();
  }
}

class _ListBlocksState extends State<ListBlocks> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.listBlocksController?.reset();
      },
      child: PagewiseListView<Block>(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, block, index) {
          return ListTile(
            title: Text(
              block.id.substring(0, 8),
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
        errorBuilder: (context, error) {
          return Text('Error: $error');
        },
        showRetry: false,
        pageLoadController: widget.listBlocksController != null
            ? widget.listBlocksController?.pagewiseLoadController
            : PagewiseLoadController(
                pageFuture: (int? pageSize) => Future.value(<Block>[]),
                pageSize: 0),
      ),
    );
  }
}
