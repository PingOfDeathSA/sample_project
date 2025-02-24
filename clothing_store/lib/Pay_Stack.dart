import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/Nav_bar_bottom.dart';
import 'package:webmax_store/Store.dart';
import 'package:webmax_store/messagespop/error.dart';
import 'package:webmax_store/messagespop/success.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/catergoryAvatar.dart';

class GooglePay extends StatefulWidget {
  final Map<String, int> itemNamesWithQuantities;
  final double totalPrice;

  const GooglePay(this.itemNamesWithQuantities, this.totalPrice, {Key? key})
      : super(key: key);

  @override
  State<GooglePay> createState() => _GooglePayState();
}

class _GooglePayState extends State<GooglePay> {
  final String publicKey = 'pk_test_8a6aff050c0c0adc6768c83b3675f9f0a6752ebf';
  final PaystackPlugin plugin = PaystackPlugin();
  String? _email;
  String message = '';
  late int deliveryFree = 0;
  late Color checkcolor = Colors.grey;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    late int deliveryFree = 0;
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final double addedDeliveryFee_final_price =
        deliveryFree + widget.totalPrice;
    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: BGColor,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Pay With Pay Stack',
              style: TextStyle(color: Colors.grey),
            ),
            categoryAavator(false == true, 'assets/paystack.png'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                'assets/payment.png',
              ),
              height: 200,
              fit: BoxFit.contain,
            ),
            Container(
              margin: EdgeInsets.only(left: 60, right: 60),
              child: TextFormField(
                validator: (val) {
                  if (val == null || val.isEmpty || !val.contains("@")) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
                decoration: InputDecoration(hintText: 'Email'),
              ),
            ),
            InkWell(
              onTap: () {
                if (checkcolor == redcolor) {
                  setState(() {
                    deliveryFree = 0;
                    checkcolor = lightblue;
                  });
                } else {
                  setState(() {
                    deliveryFree = 110;
                    checkcolor = redcolor;
                  });
                }
                // print('im test' + deliveryFree.toString());
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: checkcolor,
                  ),
                  child: deliveryFree == 0
                      ? toggleDeliveryRate('5 Working Days Free Delivery')
                      : toggleDeliveryRate(
                          '1-2 Working Days R110 Delivery Fee')),
            ),
            SizedBox(height: 20),
            Text(
              'Total: R${addedDeliveryFee_final_price.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0XFF82C9D2),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  int price = (addedDeliveryFee_final_price * 100).toInt();
                  Charge charge = Charge()
                    ..amount = price
                    ..reference =
                        'ref_${DateTime.now().millisecondsSinceEpoch} \n ' +
                            widget.itemNamesWithQuantities.toString() +
                            "Delevery Fee is: " +
                            deliveryFree.toString()
                    ..email = _email
                    ..currency = 'ZAR';

                  CheckoutResponse response = await plugin.checkout(
                    context,
                    method: CheckoutMethod.card,
                    charge: charge,
                  );

                  if (response.status == true) {
                    message = 'Payment was successful';
                    SuccessscaffMessengerPayment(context, message, 5);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                      ModalRoute.withName('/'),
                    );
                  } else {
                    ErrorffMessenger(context, response.message);
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0XFF82C9D2),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Make Payment',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget toggleDeliveryRate(String DeliveryText) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text(
      DeliveryText,
      style: TextStyle(color: Colors.white),
    ),
  );
}
