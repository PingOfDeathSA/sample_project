import 'package:flutter/material.dart';

Widget categoryAavator(bool is_sale_on, String imaglink) {
  return CircleAvatar(
    radius: 30,
    backgroundColor: is_sale_on == true
        ? Color.fromARGB(255, 224, 190, 139).withOpacity(0)
        : Color.fromARGB(255, 109, 109, 109).withOpacity(0),
    child: Padding(
      padding: EdgeInsets.all(0),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(30),
          child: Image.asset(
            imaglink,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
