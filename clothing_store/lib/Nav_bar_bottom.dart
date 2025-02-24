import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webmax_store/Colors.dart';
import 'package:webmax_store/ContactUs.dart';
import 'package:webmax_store/Store.dart';
import 'package:webmax_store/provider.dart';
import 'package:webmax_store/widgets.dart/cart.dart';
import 'package:webmax_store/widgets.dart/shooping_cart.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    Center(child: Store()),
    Center(
      child: ContactUsPage(),
    ),
    Center(
      child: Cart(),
    ),
  ];
  TextStyle labelstylingcustom() {
    return TextStyle(color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: BGColor,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            labelStyle: labelstylingcustom(),
            child: Icon(Icons.store_outlined,
                color: _page == 0 ? Color(0XFF82C9D2) : Colors.white),
            label: _page == 0 ? '' : 'Store',
          ),
          CurvedNavigationBarItem(
            labelStyle: labelstylingcustom(),
            child: Icon(
              Icons.contact_mail_outlined,
              color: _page == 1 ? Color(0XFF82C9D2) : Colors.white,
            ),
            label: _page == 1 ? '' : 'Contact Us',
          ),
          CurvedNavigationBarItem(
            labelStyle: labelstylingcustom(),
            child: shopping_cart(cartProvider.totalQuantity.toString(),
                _page == 2 ? Color(0XFF82C9D2) : Colors.white),
            label: _page == 2 ? '' : 'Cart',
          ),
        ],
        color: Color(0XFF82C9D2),
        buttonBackgroundColor: Colors.white.withOpacity(0),
        backgroundColor: BGColor,
        height: 55,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _pages[_page],
    );
  }
}

class Web_BottomNavigationBarApp extends StatelessWidget {
  const Web_BottomNavigationBarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Web_BottomNavigationBar(),
    );
  }
}

class Web_BottomNavigationBar extends StatefulWidget {
  const Web_BottomNavigationBar({super.key});
  @override
  State<Web_BottomNavigationBar> createState() =>
      _Web_BottomNavigationBarState();
}

class _Web_BottomNavigationBarState extends State<Web_BottomNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Center(child: Store()),
    Center(
      child: ContactUsPage(),
    ),
    Center(
      child: Cart(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle labelstylingcustom() {
    return TextStyle(color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: BGColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //     unselectedLabelStyle: labelstylingcustom(),
        //    selectedLabelStyle: labelstylingcustom(),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined,
                color: _selectedIndex == 0 ? Color(0XFF82C9D2) : Colors.white),
            label: _selectedIndex == 0 ? '' : 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded,
                color: _selectedIndex == 1 ? Color(0XFF82C9D2) : Colors.white),
            label: _selectedIndex == 1 ? '' : 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: shopping_cart(cartProvider.totalQuantity.toString(),
                _selectedIndex == 2 ? Color(0XFF82C9D2) : Colors.white),
            label: _selectedIndex == 2 ? '' : 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        elevation: 0,

        backgroundColor: BGColor.withOpacity(0),
        onTap: _onItemTapped,
      ),
    );
  }
}
