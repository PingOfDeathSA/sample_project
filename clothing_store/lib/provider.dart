import 'package:flutter/material.dart';
import 'package:webmax_store/models.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void incrementItemQuantity(String id) {
    for (var item in _cartItems) {
      if (item.id == id) {
        _cartItems[_cartItems.indexOf(item)] = CartItem(
          id: item.id,
          name: item.name,
          image: item.image,
          price: item.price,
          availableItems_instore: item.availableItems_instore,
          numberOfItems: item.numberOfItems + 1,
        );
        notifyListeners();
        break;
      }
    }
  }

  void decrementItemQuantity(String id) {
    for (var item in _cartItems) {
      if (item.id == id && item.numberOfItems > 1) {
        _cartItems[_cartItems.indexOf(item)] = CartItem(
          id: item.id,
          name: item.name,
          image: item.image,
          price: item.price,
          availableItems_instore: item.availableItems_instore,
          numberOfItems: item.numberOfItems - 1,
        );
        notifyListeners();
        break;
      }
    }
  }

  // Method to aggregate items by ID
  List<CartItem> get aggregatedCartItems {
    final Map<String, CartItem> aggregatedMap = {};

    for (var item in _cartItems) {
      if (aggregatedMap.containsKey(item.id)) {
        final existingItem = aggregatedMap[item.id]!;
        final newNumberOfItems =
            existingItem.numberOfItems + item.numberOfItems;
        final newTotalPrice =
            existingItem.price + (item.price * item.numberOfItems);

        aggregatedMap[item.id] = CartItem(
          id: item.id,
          name: item.name,
          image: item.image,
          price: newTotalPrice,
          availableItems_instore: item.availableItems_instore,
          numberOfItems: newNumberOfItems,
        );
      } else {
        aggregatedMap[item.id] = CartItem(
          id: item.id,
          name: item.name,
          image: item.image,
          price: item.price * item.numberOfItems,
          availableItems_instore: item.availableItems_instore,
          numberOfItems: item.numberOfItems,
        );
      }
    }

    return aggregatedMap.values.toList();
  }

  // Method to calculate the total price of all items
  double get totalPrice {
    return aggregatedCartItems.fold(0.0, (total, item) => total + item.price);
  }

  // Method to calculate the total quantity of all items
  int get totalQuantity {
    return aggregatedCartItems.fold(
        0, (total, item) => total + item.numberOfItems);
  }

  // Method to get a list of item names and their total quantities
  Map<String, int> get itemNamesWithQuantities {
    final Map<String, int> itemNames = {};

    for (var item in aggregatedCartItems) {
      itemNames[item.name] = item.numberOfItems;
    }

    return itemNames;
  }
}
