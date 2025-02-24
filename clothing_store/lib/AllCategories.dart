import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/ViewItemPage.dart';
import 'package:webmax_store/data/Storeitemsdata.dart';
import 'package:webmax_store/data/categoriesData.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/cart.dart';
import 'package:webmax_store/widgets.dart/shooping_cart.dart';

import 'currentCategories.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: BGColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'All Categories',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Allcategorieswidget(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: redcolor.withOpacity(0.8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        },
        tooltip: 'Cart',
        child: shopping_cart(cartProvider.totalQuantity.toString(), BGColor),
      ),
    );
  }
}

Widget Allcategorieswidget() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: categories.length,
    itemBuilder: (BuildContext context, int index) {
      final category = categories[index];
      final categoryItems = StoreItemList.where(
          (item) => item['category'] == category['category']).toList();
      final currentcategoryName = category['category'];
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  currentCategories(currentcategoryName: currentcategoryName),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: category['sale'] == true
                            ? Color.fromARGB(255, 224, 190, 139).withOpacity(0)
                            : Color.fromARGB(255, 109, 109, 109).withOpacity(0),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(30),
                              child: Image.asset(
                                category['image'].toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        category['category'],
                        style: TextStyle(
                            color: Color(0XFF82C9D2),
                            fontSize: 15,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: -300,
                    right: -20,
                    bottom: -40,
                    child: category['sale'] == true
                        ? CircleAvatar(
                            radius: 0,
                            backgroundColor: Colors.white.withOpacity(0),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(10),
                                child: Image.asset('assets/sale.png',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          )
                        : Text(''),
                  ),
                ],
              ),
              // SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
