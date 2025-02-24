import 'package:flutter/material.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/ViewItemPage.dart';
import 'package:webmax_store/data/Storeitemsdata.dart';
import 'package:webmax_store/widgets.dart/StoreitemsContainer.dart';

class All_instore extends StatefulWidget {
  const All_instore({super.key});

  @override
  State<All_instore> createState() => _All_instoreState();
}

class _All_instoreState extends State<All_instore> {
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
    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        toolbarHeight: 150,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextField(
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
        backgroundColor: BGColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'All in Store',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 750 ? 3 : 2,
                  mainAxisSpacing: 5,
                  childAspectRatio: (1 / 1.1),
                ),
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredItems[index];
                  String formatName(String name) {
                    String truncatedName =
                        name.length > 22 ? name.substring(0, 22) + "..." : name;
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
                          builder: (context) => View_Item_Page(item),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
