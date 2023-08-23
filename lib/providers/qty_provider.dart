import 'package:flutter/foundation.dart';

class QuantityProvider extends ChangeNotifier {
  Map<int, int> _quantities = {};

  Map<int, int> get quantities => _quantities;

  void updateQuantity(int productId, int quantity) {
    _quantities[productId] = quantity;
    notifyListeners();
  }
}