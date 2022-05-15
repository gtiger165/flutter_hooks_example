import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks_example/components/add_item_dialog.dart';
import 'package:flutter_hooks_example/components/item_list.dart';
import 'package:flutter_hooks_example/controllers/auth_controller.dart';
import 'package:flutter_hooks_example/controllers/item_list_controller.dart';
import 'package:flutter_hooks_example/firebase_options.dart';
import 'package:flutter_hooks_example/models/item_model.dart';
import 'package:flutter_hooks_example/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authControllerState =
        ref.watch(authControllerProvider.notifier).state;

    debugPrint("auth controller state -> $_authControllerState");

    ref.listen<CustomException?>(itemListExceptionProvider, (previous, next) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            next?.message ??
                "Opps something terrible happen, please try again later!",
          ),
        ),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
        leading: _authControllerState != null
            ? IconButton(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                icon: Icon(Icons.logout),
              )
            : null,
      ),
      body: const ItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
