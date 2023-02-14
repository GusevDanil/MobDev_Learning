import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_app/shopping_model.dart';
import 'package:shopping_app/shopping_view.dart';

late Box<ShoppingModel> purchaseBox;

Future <void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ShoppingModelAdapter());
  purchaseBox = await Hive.openBox<ShoppingModel>('shopping');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ShoppingView(),
    );
  }
}

