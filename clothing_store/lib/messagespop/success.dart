import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> SuccessscaffMessenger(
    BuildContext context, String Message, int timeinsec) {
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
      backgroundColor: Color(0XFF82C9D2),
      elevation: 0,
      dismissDirection: DismissDirection.up,
      duration: Duration(seconds: timeinsec),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    SuccessscaffMessengerPayment(
        BuildContext context, String Message, int timeinsec) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Message),
          Image(
            image: AssetImage('assets/success.png'),
            height: 100,
          ),
        ],
      )),
      backgroundColor: Color(0XFF82C9D2),
      elevation: 0,
      dismissDirection: DismissDirection.up,
      duration: Duration(seconds: timeinsec),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
