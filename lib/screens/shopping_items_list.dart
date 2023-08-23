import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/shopping/bloc/get_shopping_list_bloc.dart';
import 'package:shopping_app/screens/list_item_card.dart';
import 'package:shopping_app/screens/shopping_cart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_app/providers/cart_items_provider.dart';
import 'package:provider/provider.dart';

class ShoppingItemsList extends StatefulWidget {
  const ShoppingItemsList({super.key});

  @override
  State<ShoppingItemsList> createState() => _ShoppingItemsListState();
}

class _ShoppingItemsListState extends State<ShoppingItemsList> {
  final GetShoppingListBloc shopBloc = GetShoppingListBloc();

  @override
  void initState() {
    shopBloc.add(GetShoppingListInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = Provider.of<CartItemsProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Shopping app'),
            ),
            ListTile(
              title: const Text('Orders'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('Shopping List'), actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8),
          child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -8, end: -4),
              badgeContent: Text('${cartNotifier.cartItems.length}'),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShoppingCart()));
                  })),
        ),
      ]),
      body: BlocConsumer<GetShoppingListBloc, GetShoppingListState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          bloc: shopBloc,
          buildWhen: (prev, curr) => curr is! GetShoppingListActionState,
          listenWhen: (prev, curr) => curr is GetShoppingListActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case GetShoppingListSuccessState:
                final successState = state as GetShoppingListSuccessState;
                print(successState.shoppingLists);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: successState.shoppingLists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListItemCard(
                              listItem: successState.shoppingLists[index],
                              cartItems: [],
                            );
                          })),
                );
              default:
                return Center(child: SizedBox());
            }
          }),
    );
  }
}
