import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Item.dart';
import '../provider/shoppingcart_provider.dart';

class MyCheckout extends StatelessWidget {
  const MyCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Item Details"),
          const Divider(height: 4, color: Colors.black),
          getItems(context),
          const Divider(height: 4, color: Colors.black),
          computeCost(context),
          Flexible(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                showPayNowButton(context),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Text("No items to checkout!")
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                            leading: const Icon(Icons.food_bank),
                            title: Text(products[index].name),
                            trailing: Text("${products[index].price}"));
                      })))
            ],
          ));
  }

  Widget computeCost(BuildContext context) {
    List<Item> products = context.read<ShoppingCart>().cart;
    return products.isNotEmpty
        ? Consumer<ShoppingCart>(
            builder: (context, cart, child) {
              return Text("Total: ${cart.cartTotal}");
            },
          )
        : const Text("");
  }

  Widget showPayNowButton(BuildContext context) {
    List<Item> products = context.read<ShoppingCart>().cart;
    return products.isNotEmpty
        ? ElevatedButton(
            onPressed: () {
              context.read<ShoppingCart>().removeAll();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Payment Successful!"),
                duration: Duration(seconds: 1, milliseconds: 100),
              ));
              Navigator.pushNamed(context, "/");
            },
            child: const Text("Pay Now!"),
          )
        : const Text("");
  }
}
