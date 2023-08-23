import 'package:flutter/material.dart';
import '../feature/shopping/Model/ShoppingList.dart';
import '../utility/database_helper.dart';

class CartItemsProvider extends ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<ShoppingList> _cartItems = [];

  List<ShoppingList> get cartItems => _cartItems;

  void addToCart(ShoppingList item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(ShoppingList item) {
    if (_cartItems.contains(item)) {
      _cartItems.remove(item);
      notifyListeners();
    }
  }

  Map<int, List<ShoppingList>> getCartObject() {
    Map<int, List<ShoppingList>> groupedProducts = {};

    for (var product in _cartItems) {
      if (!groupedProducts.containsKey(product.id)) {
        groupedProducts[product.id] = [];
      }
      groupedProducts[product.id]?.add(product);
    }
    return groupedProducts;
  }
}