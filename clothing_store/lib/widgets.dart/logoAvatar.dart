import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';

Widget logoAavatar() {
  return CircleAvatar(
    backgroundColor: BGColor,
    radius: 22, // Image radius
    backgroundImage: AssetImage('assets/logo.png'),
  );
}
