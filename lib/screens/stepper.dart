import 'package:flutter/material.dart';
import 'package:shopping_app/providers/qty_provider.dart';
import 'package:provider/provider.dart';
import '../providers/cart_items_provider.dart';
import '../feature/shopping/Model/ShoppingList.dart';

class StepperWidget extends StatefulWidget {
  final ShoppingList listItem;

  const StepperWidget({super.key, required this.listItem});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    final productQuantityNotifier = Provider.of<QuantityProvider>(context);
    final quantity =
        productQuantityNotifier.quantities[widget.listItem.id] ?? 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Consumer<CartItemsProvider>(builder: (context, cartProvider, _) {
            return GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Icon(Icons.add)),
              onTap: () {
                productQuantityNotifier.updateQuantity(
                    widget.listItem.id, quantity + 1);
                cartProvider.addToCart(widget.listItem);
                print(cartProvider.cartItems);
                print(quantity);
              },
            );
          }),
          SizedBox(
            width: 5,
          ),
          Text('${quantity.toString()}'),
          SizedBox(
            width: 5,
          ),
          Consumer<CartItemsProvider>(builder: (context, cartProvider, _) {
            return GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Icon(Icons.remove)),
              onTap: () {
                if (quantity > 0) {
                  productQuantityNotifier.updateQuantity(
                      widget.listItem.id, quantity - 1);
                  cartProvider.removeFromCart(widget.listItem);
                  print(cartProvider.cartItems);
                  print(quantity);
                }
              },
            );
          })
        ],
      ),
    );
  }
}
