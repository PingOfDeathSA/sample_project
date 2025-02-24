import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> ErrorffMessenger(
  BuildContext context,
  String Message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Message),
          Icon(
            Icons.check_circle,
            color: lightblue,
          )
        ],
      )),
      backgroundColor: redcolor,
      elevation: 0,
      dismissDirection: DismissDirection.up,
      duration: Duration(seconds: 10),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
