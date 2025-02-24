import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  double price;
  int numberOfItems;
  final availableItems_instore;

  CartItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.numberOfItems,
      required this.availableItems_instore});
}
