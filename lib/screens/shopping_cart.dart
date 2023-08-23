import 'package:flutter/material.dart';
import 'package:shopping_app/feature/shopping/Model/ShoppingList.dart';
import 'package:shopping_app/providers/cart_items_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = Provider.of<CartItemsProvider>(context);
    final cart = cartNotifier.getCartObject();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          int groupId = cart.keys.elementAt(index);
          List<ShoppingList> products = cart[groupId] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 160,
                      child: Image.network('${products.first.image}',
                          fit: BoxFit.fill),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${products.first.title}',
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('QTY: ${products.length}')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
