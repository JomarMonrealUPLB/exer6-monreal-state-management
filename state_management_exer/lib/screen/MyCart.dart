import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_exer/provider/shoppingcart_provider.dart';

import '../model/Item.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

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
          computeCost(),
          const Divider(height: 4, color: Colors.black),
          Flexible(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ShoppingCart>().removeAll();
                  },
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/checkout");
                  },
                  child: const Text("Checkout"),
                )
              ],
            ),
          )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/products");
              },
              child: const Text("Go Back to Product Catalog"))
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productName = "";
    return products.isEmpty
        ? const Text("No items yet!")
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
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                productName = products[index].name;
                                context
                                    .read<ShoppingCart>()
                                    .removeItem(productName);

                                if (products.isNotEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("$productName removed!"),
                                    duration: const Duration(
                                        seconds: 1, milliseconds: 100),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Cart Empty!"),
                                    duration:
                                        Duration(seconds: 1, milliseconds: 100),
                                  ));
                                }
                              },
                            ));
                      })))
            ],
          ));
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(
      builder: (context, cart, child) {
        return Text("Total: ${cart.cartTotal}");
      },
    );
  }
}
