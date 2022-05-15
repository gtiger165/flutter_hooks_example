import 'package:flutter/material.dart';
import 'package:flutter_hooks_example/components/add_item_dialog.dart';
import 'package:flutter_hooks_example/components/item_list.dart';
import 'package:flutter_hooks_example/controllers/item_list_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemTile extends HookConsumerWidget {
  const ItemTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItem);
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.name),
      trailing: Checkbox(
        value: item.obtained,
        onChanged: (val) =>
            ref.read(itemListControllerProvider.notifier).updateItem(
                  updatedItem: item.copyWith(obtained: !item.obtained),
                ),
      ),
      onTap: () => AddItemDialog.show(context, item),
      onLongPress: () => ref
          .watch(itemListControllerProvider.notifier)
          .deleteItem(itemId: item.id!),
    );
  }
}
