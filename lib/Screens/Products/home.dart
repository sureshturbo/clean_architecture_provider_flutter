import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Screens/Products/pages.dart';

import '../../Provider/ProductProvider/app_navigation_provider.dart';
import '../TaskPage/home_page.dart';
import 'Product_list.dart';



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<AppNavigation>(context);

    return Scaffold(
      body: _buildPage(navigationProvider.currentTab),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: AppTab.values.indexOf(navigationProvider.currentTab),
        onTap: (index) {
          navigationProvider.changeTab(AppTab.values[index]);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildPage(AppTab currentTab) {
    switch (currentTab) {
      case AppTab.home:
        return Home1();
      case AppTab.cart:
        return CartPage();
      case AppTab.account:
        return Products_List();
    }
  }
}