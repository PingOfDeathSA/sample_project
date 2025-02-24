import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';

TextStyle saletextstyle(double font_size, bool show_text_shadow) {
  return TextStyle(
    fontSize: font_size,
    color: BGColor,
    fontWeight: FontWeight.bold,
    shadows: show_text_shadow == true
        ? <Shadow>[
            Shadow(
              offset: Offset(-1.0, 0.0),
              blurRadius: 1.0,
              color: Color.fromARGB(255, 141, 141, 141),
            ),
          ]
        : <Shadow>[],
  );
}

TextStyle saletextstyle2() {
  return TextStyle(
      fontSize: 25,
      color: Color.fromARGB(255, 100, 100, 100),
      fontWeight: FontWeight.w700);
}

TextStyle viewButtonStyle() {
  return TextStyle(
      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey);
}
