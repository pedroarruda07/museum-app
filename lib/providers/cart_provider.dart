import 'package:flutter/material.dart';
import '../data/product.dart';

class Cart extends ChangeNotifier {
 Map<Product, int> cartMap = {};
 int itemsInCart = 0;

  void addToCart(Product product) {
    if (cartMap.containsKey(product)) {
      cartMap[product] = cartMap[product]! + 1;
    } else {
      cartMap[product] = 1;
    }
    itemsInCart++;
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (cartMap.containsKey(product)) {
      if (cartMap[product] == 1) {
        cartMap.remove(product);
      } else {
        cartMap[product] = cartMap[product]! - 1;
      }
    }
    itemsInCart--;
    notifyListeners();
  }

  void clearCart() {
    cartMap.clear();
    notifyListeners();
  }

  int get cartCount {
    return itemsInCart;
  }

  bool get isCartEmpty {
    return cartMap.isEmpty;
  }

  double get cartTotal {
    double total = 0;
    cartMap.forEach((key, value) {
      total += key.price * value;
    });
    return total;
  }

  Map<Product, int> get cart {
    return cartMap;
  }
}