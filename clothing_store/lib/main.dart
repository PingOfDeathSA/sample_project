import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/Nav_bar_bottom.dart';
import 'package:webmax_store/Store.dart';
import 'package:webmax_store/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: kIsWeb ? Web_BottomNavigationBarApp() : BottomNavBar(),
    );
  }
}
