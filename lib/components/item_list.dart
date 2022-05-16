import 'package:flutter/material.dart';
import 'package:flutter_hooks_example/components/item_list_error.dart';
import 'package:flutter_hooks_example/components/item_tile.dart';
import 'package:flutter_hooks_example/controllers/item_list_controller.dart';
import 'package:flutter_hooks_example/models/item_model.dart';
import 'package:flutter_hooks_example/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentItem = Provider<Item>((_) => throw UnimplementedError());

class ItemList extends HookConsumerWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListControllerProvider);

    return itemListState.when(
      data: (items) {
        debugPrint("item is empty ? ${items.isEmpty}");

        return items.isEmpty
            ? const Center(
                child: Text(
                  "Tap + to add an item",
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ProviderScope(
                    overrides: [currentItem.overrideWithValue(item)],
                    child: ItemTile(),
                  );
                },
              );
      },
      error: (error, _) => ItemListError(
        message:
            error is CustomException ? error.message! : "Something went wrong!",
      ),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
