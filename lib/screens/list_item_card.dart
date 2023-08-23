import 'package:flutter/material.dart';
import 'package:shopping_app/providers/cart_items_provider.dart';
import 'package:shopping_app/providers/qty_provider.dart';
import 'package:shopping_app/screens/stepper.dart';
import 'package:provider/provider.dart';
import '../feature/shopping/Model/ShoppingList.dart';
import '../utility/database_helper.dart';

class ListItemCard extends StatefulWidget {
  final ShoppingList listItem;
  final List<ShoppingList> cartItems;

  const ListItemCard(
      {super.key, required this.listItem, required this.cartItems});

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productQuantityNotifier = Provider.of<QuantityProvider>(context);
    final quantity =
        productQuantityNotifier.quantities[widget.listItem.id] ?? 0;

    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 100,
              height: 140,
              child:
                  Image.network('${widget.listItem.image}', fit: BoxFit.fill),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('${widget.listItem.title}'),
                subtitle: Text('${widget.listItem.category}'),
                trailing: Icon(Icons.favorite),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text('data'),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      color: Colors.blue,
                      child: Consumer<CartItemsProvider>(
                          builder: (context, cartProvider, _) {
                        return (quantity == 0)
                            ? TextButton(
                                onPressed: () async {
                                  productQuantityNotifier.updateQuantity(
                                      widget.listItem.id, quantity + 1);
                                  cartProvider.addToCart(widget.listItem);
                                  // print(await dbHelper.retrieveShoppingObject());
                                  print(cartProvider.cartItems);
                                  print(quantity);
                                },
                                child: Text(
                                  'ADD',
                                  style: TextStyle(color: Colors.white),
                                ))
                            : Icon(Icons.check_circle_outline_outlined);
                      }),
                    ),
                    StepperWidget(
                      listItem: widget.listItem,
                    )
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
