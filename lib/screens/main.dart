import 'package:flutter/material.dart';
import 'package:shopping_app/providers/qty_provider.dart';
import 'package:shopping_app/screens/shopping_items_list.dart';
import 'package:provider/provider.dart';
import '../providers/cart_items_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemsProvider()),
        ChangeNotifierProvider(create: (context) => QuantityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShoppingItemsList(),
    );
  }
}
