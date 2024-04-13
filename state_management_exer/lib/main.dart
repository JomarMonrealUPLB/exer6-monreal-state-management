import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_exer/provider/shoppingcart_provider.dart';

import 'screen/MyCart.dart';
import 'screen/MyCatalog.dart';
import 'screen/MyCheckout.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ShoppingCart())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/cart": (context) => const MyCart(),
        "/products": (context) => const MyCatalog(),
        "/checkout": (context) => const MyCheckout(),
      },
      home: const MyCatalog(),
    );
  }
}
