import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/data/categoriesData.dart';
import 'package:webmax_store/messagespop/success.dart';
import 'package:webmax_store/models.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/cart.dart';
import 'package:webmax_store/widgets.dart/catergoryAvatar.dart';
import 'package:webmax_store/widgets.dart/logoAvatar.dart';
import 'package:webmax_store/widgets.dart/shooping_cart.dart';
import 'package:webmax_store/widgets.dart/styles.dart';
import 'colors.dart';

class View_Item_Page extends StatefulWidget {
  final Map<String, dynamic> item;

  const View_Item_Page(this.item, {super.key});

  @override
  State<View_Item_Page> createState() => _View_Item_PageState();
}

class _View_Item_PageState extends State<View_Item_Page> {
  Color likecolor = lightblue;
  int count = 1;
  String availableItemsMessage = '';
  String getCategoryImage(String category) {
    for (var cat in categories) {
      if (cat['category'] == category) {
        return cat['image'];
      }
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    count = 1;
    availableItemsMessage = '';
  }

  @override
  void dispose() {
    count = 1;
    availableItemsMessage = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final int availableStock = item['available'];
    final double finalPrice = item['Price'] * count;
    final cartProvider = Provider.of<CartProvider>(context);
    final categoryImage = getCategoryImage(item['category']);
    return Scaffold(
      backgroundColor: BGColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          categoryAavator(item['sale'] == true, categoryImage),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            item['category'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      logoAavatar(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: redcolor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item['name'],
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 92, 92, 92)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 250,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Swiper(
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          item['image'][index],
                          fit: BoxFit.contain,
                        );
                      },
                      itemCount: item['image'].length,
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          color: lightblue,
                          activeColor: redcolor,
                        ),
                      ),
                      control: SwiperControl(
                        color: lightblue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: R${finalPrice.toString()}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF82C9D2)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              if (likecolor == redcolor) {
                                setState(() {
                                  likecolor = lightblue;
                                });
                              } else {
                                setState(() {
                                  likecolor = redcolor;
                                });
                              }
                            },
                            child: Icon(
                              Icons.favorite,
                              color: likecolor,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Was: R${(item['Price'] * 1.5).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        availableItemsMessage,
                        style: TextStyle(color: redcolor),
                      )
                    ],
                  ),
                  Text(
                    'Price: R${item['discription']}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0XFF82C9D2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.only(
                                left: 50, right: 50, top: 10, bottom: 10),
                            child: Text(
                              'Add to Cart',
                              style: saletextstyle(15, false),
                            ),
                          ),
                          onTap: () {
                            final num currentTotalQuantity =
                                cartProvider.totalQuantity;

                            if (currentTotalQuantity + count <=
                                availableStock) {
                              cartProvider.addItem(CartItem(
                                id: item['id'].toString(),
                                name: item['name'],
                                image: item['image'][0],
                                price: finalPrice,
                                numberOfItems: count,
                                availableItems_instore: availableStock,
                              ));
                              SuccessscaffMessenger(
                                  context, 'Item added to Cart', 2);
                            } else {
                              setState(() {
                                availableItemsMessage =
                                    "Cannot add more than available stock";
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
