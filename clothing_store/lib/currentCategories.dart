import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/ViewItemPage.dart';
import 'package:webmax_store/data/Storeitemsdata.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/cart.dart';
import 'package:webmax_store/widgets.dart/shooping_cart.dart';

class currentCategories extends StatefulWidget {
  final String currentcategoryName;

  const currentCategories({Key? key, required this.currentcategoryName})
      : super(key: key);

  @override
  State<currentCategories> createState() => _currentCategoriesState();
}

class _currentCategoriesState extends State<currentCategories> {
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filterItems();
  }

  void filterItems() {
    filteredItems = StoreItemList.where(
        (item) => item['category'] == widget.currentcategoryName).toList();
  }

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
          widget.currentcategoryName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: filteredItems.isNotEmpty
          ? ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => View_Item_Page(item)),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 130,
                        child: Image.asset(
                          item['image'][0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        item['name'],
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        item['discription'],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        'R ${item['Price']}',
                        style: TextStyle(
                            color: Color(0XFF82C9D2),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Container(
                color: Color(0XFF82C9D2),
                padding: EdgeInsets.all(20),
                child: Text(
                  'No items found in this category',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
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
