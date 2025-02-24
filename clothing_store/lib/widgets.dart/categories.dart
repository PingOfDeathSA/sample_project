import 'package:flutter/material.dart';
import 'package:webmax_store/AllCategories.dart';
import 'package:webmax_store/currentCategories.dart';
import 'package:webmax_store/data/categoriesData.dart';

Widget categorieswidget() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (BuildContext context, int index) {
      final category = categories[index];
      final currentcategoryName = category['category'];
      return Container(
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => currentCategories(
                            currentcategoryName: currentcategoryName),
                      ),
                    );
                  },
                  child: CircleAvatar(
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
                ),
                if (category['sale'] == true)
                  Positioned(
                    top: 0,
                    left: 20,
                    right: -20,
                    bottom: -35,
                    child: CircleAvatar(
                      radius: 0,
                      backgroundColor: Colors.white.withOpacity(0),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(10),
                          child:
                              Image.asset('assets/sale.png', fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              category['category'],
              style: TextStyle(
                color: Color.fromARGB(255, 24, 24, 24),
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    },
  );
}
