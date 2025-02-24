import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

Widget shopping_cart(String cartItemsNumber, Color iconcolor) {
  return badges.Badge(
    badgeAnimation: badges.BadgeAnimation.slide(
        toAnimate: true, animationDuration: Duration(seconds: 1)),
    badgeContent: Text(
      cartItemsNumber.toString(),
      style: TextStyle(color: Colors.white),
    ),
    child: Icon(
      Icons.shopping_cart_outlined,
      size: 30,
      color: iconcolor,
    ),
  );
}

Widget pay_with_google_pay(String cartItemsNumber, Color iconcolor) {
  return badges.Badge(
    badgeAnimation: badges.BadgeAnimation.slide(
        toAnimate: true, animationDuration: Duration(seconds: 1)),
    badgeContent: Text(
      cartItemsNumber.toString(),
      style: TextStyle(color: Colors.white),
    ),
    child: Icon(
      Icons.payment_outlined,
      size: 30,
      color: iconcolor,
    ),
  );
}
