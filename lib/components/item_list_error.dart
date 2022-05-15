import 'package:flutter/material.dart';
import 'package:flutter_hooks_example/controllers/item_list_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemListError extends HookConsumerWidget {
  final String message;

  const ItemListError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => ref
                .read(itemListControllerProvider.notifier)
                .retrieveItems(isRefreshing: true),
            child: Text("Retry"),
          )
        ],
      ),
    );
  }
}
