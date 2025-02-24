import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/data/BigSaleData.dart';
import 'package:webmax_store/widgets.dart/styles.dart';

Widget big_Sale(BuildContext context, Color customcolor) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Container(
    decoration: BoxDecoration(
        color: customcolor,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 220,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(0),
    width: screenWidth,
    child: Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        final bigSaleData = bigSaleList[index];
        return Stack(children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 10,
            child: Image.asset(
              bigSaleData['image'].toString(),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
              top: 30,
              left: 10,
              right: 0,
              bottom: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Big Sale',
                    style: saletextstyle2(),
                  ),
                  Text(
                    '${bigSaleData['discount'].toString()}% OFF',
                    style: saletextstyle(35, false),
                  ),
                ],
              )),
          Positioned(
              top: 100,
              left: 10,
              right: 30,
              bottom: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'R${bigSaleData['Price'].toString()}.99',
                    style: saletextstyle(15, true),
                  ),
                ],
              )),
        ]);
      },
      itemCount: bigSaleList.length,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: BGColor,
          activeColor: lightblue,
        ),
      ),
      control: SwiperControl(
        color: Colors.white.withOpacity(0),
      ),
    ),
  );
}
