import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/Pay_Stack.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/logoAvatar.dart';
import 'package:webmax_store/widgets.dart/shooping_cart.dart';
import 'package:webmax_store/widgets.dart/styles.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: BGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Cart ',
                  style: TextStyle(color: Colors.black),
                ),
                shopping_cart(
                    cartProvider.totalQuantity.toString(), Color(0XFF82C9D2)),
              ],
            ),
            logoAavatar(),
          ],
        ),
      ),
      body: cartProvider.totalQuantity == 0
          ? Center(
              child: Text(
                'No Items Added To Cart',
                style: TextStyle(
                    color: Color(0XFF82C9D2),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: cartProvider.aggregatedCartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartProvider.aggregatedCartItems[index];

                        return ListTile(
                          leading: Image.asset(item.image),
                          title: Text(
                            item.name,
                            style: TextStyle(
                                fontSize: 12, color: Color(0XFF82C9D2)),
                          ),
                          subtitle: Text(
                              'Price: R${item.price.toStringAsFixed(2).toString()}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: redcolor,
                                      size: 10,
                                    ),
                                    onPressed: () {
                                      cartProvider
                                          .decrementItemQuantity(item.id);
                                    },
                                  ),
                                  Text('${item.numberOfItems.toString()}'),
                                  item.numberOfItems <
                                          item.availableItems_instore
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: redcolor,
                                            size: 10,
                                          ),
                                          onPressed: () {
                                            cartProvider
                                                .incrementItemQuantity(item.id);
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: redcolor,
                                            size: 10,
                                          ),
                                          onPressed: () {},
                                        ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: redcolor,
                                ),
                                onPressed: () {
                                  cartProvider.removeItem(item.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Quantity: ${cartProvider.totalQuantity}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total Price: R${cartProvider.totalPrice.toStringAsFixed(2).toString()}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF82C9D2)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0XFF82C9D2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pay with Pay Stack',
                                style: saletextstyle(16, false),
                              ),
                              Container(
                                height: 50,
                                child: Image.asset(
                                  'assets/paystack.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          print(cartProvider.totalPrice);
                          print(cartProvider.itemNamesWithQuantities);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GooglePay(
                                  cartProvider.itemNamesWithQuantities,
                                  cartProvider.totalPrice),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
