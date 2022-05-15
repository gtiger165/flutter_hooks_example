import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_example/controllers/item_list_controller.dart';
import 'package:flutter_hooks_example/models/item_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddItemDialog extends HookConsumerWidget {
  static void show(BuildContext context, Item item) => showDialog(
        context: context,
        builder: (context) => AddItemDialog(item: item),
      );

  final Item item;
  const AddItemDialog({Key? key, required this.item}) : super(key: key);

  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: item.name);
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(hintText: "Item Name"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  isUpdating
                      ? ref
                          .read(itemListControllerProvider.notifier)
                          .updateItem(
                            updatedItem: item.copyWith(
                              name: textController.text.trim(),
                              obtained: item.obtained,
                            ),
                          )
                      : ref
                          .read(itemListControllerProvider.notifier)
                          .addItem(name: textController.text.trim());

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: isUpdating
                      ? Colors.orange
                      : Theme.of(context).primaryColor,
                ),
                child: Text(isUpdating ? "Update" : "Add"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
