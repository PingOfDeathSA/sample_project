import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/AllCategories.dart';
import 'package:webmax_store/All_in_Store.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/ViewItemPage.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/BigSale.dart';
import 'package:webmax_store/widgets.dart/cart.dart';
import 'package:webmax_store/widgets.dart/categories.dart';
import 'package:webmax_store/widgets.dart/logoAvatar.dart';
import 'package:webmax_store/widgets.dart/shooping_cart.dart';

import 'data/Storeitemsdata.dart';
import 'widgets.dart/StoreitemsContainer.dart';
import 'widgets.dart/styles.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredItems = StoreItemList;

  void _searchItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = StoreItemList;
      } else {
        filteredItems = StoreItemList.where((item) =>
            item['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item['category']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    print('size is: ' + screenWidth.toString());
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: BGColor,
        toolbarHeight: 120,
        elevation: 0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        logoAavatar()
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  },
                  child: shopping_cart(
                      cartProvider.totalQuantity.toString(), Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
                onChanged: _searchItems,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 850,
          child: Column(
            children: [
              // sections(
              //     'Categories',
              //     Row(
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => AllCategories()),
              //             );
              //           },
              //           child: Text('View All', style: viewButtonStyle()),
              //         ),
              //         Icon(
              //           Icons.arrow_forward,
              //           size: 14,
              //           color: Colors.grey,
              //         )
              //       ],
              //     )),
              Container(height: 110, child: categorieswidget()),
              searchController.text.isEmpty
                  ? big_Sale(context, redcolor)
                  : Text(''),
              sections(
                  'Store',
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => All_instore()),
                      );
                    },
                    child: Row(
                      children: [
                        Text('View All', style: viewButtonStyle()),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )),
              Container(
                height: 450,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 750 ? 3 : 2,
                    mainAxisSpacing: 5,
                    childAspectRatio: (1 / 1.1),
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = filteredItems[index];
                    String formatName(String name) {
                      String truncatedName = name.length > 22
                          ? name.substring(0, 22) + "..."
                          : name;
                      if (truncatedName.isEmpty) return truncatedName;
                      return truncatedName[0].toUpperCase() +
                          truncatedName.substring(1);
                    }

                    final price = item['Price'];
                    final wasprice = (price * 1.5).toStringAsFixed(2);
                    return InkWell(
                      child: StoreItemContainer(
                          item['image'][0],
                          formatName(item['name'].toString()),
                          'R${item['Price'].toString()}',
                          'Was R${wasprice}',
                          item['category'],
                          'assets/sale.png'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => View_Item_Page(item)),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
