import 'package:flutter/material.dart';

import '../../Provider/Database/db_provider.dart';
import '../../Widgets/appBar.dart';

class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
             DatabaseProvider().logOut(context);
            },
          ),
        ],
        showBackButton: false, // Set to true if you want to show the back button
      ),
      body: Center(child: Text('Home Page')),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'cart',
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // Perform logout action
              // Example: DatabaseProvider().logOut(context);
            },
          ),
        ],
        showBackButton: true, // Set to true if you want to show the back button
      ),
      body: Center(child: Text('Cart Page')),
    );
  }
}

// class AccountPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Account')),
//       body: Center(child: Text('Account Page')),
//     );
//   }
// }
