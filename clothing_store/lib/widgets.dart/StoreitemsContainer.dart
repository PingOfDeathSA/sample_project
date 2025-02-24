import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/widgets.dart/BigSale.dart';

Widget StoreItemContainer(String Imageling, String FormatedName, String Price,
    String WasPrice, String Checksale, String ImageSalelink) {
  return Container(
    margin: EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      border: Border.all(
          width: 1.0, color: const Color.fromARGB(255, 221, 221, 221)),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    ),
    child: Stack(
      children: <Widget>[
        

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              child: Image.asset(
                Imageling,
                fit: BoxFit.contain,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  FormatedName,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      WasPrice,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Checksale == 'Clearance'
                        ? Container(
                            height: 15,
                            child: Image.asset(ImageSalelink),
                          )
                        : Text('')
                  ],
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          left: 105,
          child: Text(
            Price,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

Widget sections(String sectionName, Widget ContainerButton) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: EdgeInsets.all(10),
        child: Text(
          sectionName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            ContainerButton,
          ],
        ),
      ),
    ],
  );
}
