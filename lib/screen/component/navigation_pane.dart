import 'package:flutter/material.dart';
import 'package:pondok207/screen/home/home_screen.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:pondok207/screen/keranjang/cart_screen.dart';
import 'package:pondok207/screen/pesananku/see_checkout_screen.dart';
import 'package:pondok207/screen/settings/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  static final List<Widget> _widgetOptions = [
    HomeScreen(),
    CartScreen(),
    SeeCheckoutScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<MenuViewModel>(context);
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: unnecessary_brace_in_string_interps
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Pesananku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: modelView.primaryColor,
        unselectedItemColor: Color.fromARGB(255, 31, 29, 29),
        onTap: _onItemTapped,
      ),
    );
  }
}
