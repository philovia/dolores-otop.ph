// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:otop_front/components/add_product_screen.dart';
import 'package:otop_front/components/order_list.dart';
// import 'package:otop_front/components/supplier_list.dart';
import 'package:otop_front/components/transactions.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/logout_services.dart';
import 'package:otop_front/widget/custom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileSupplierDashboard extends StatefulWidget {
  const MobileSupplierDashboard({super.key});

  @override
  State<MobileSupplierDashboard> createState() =>
      _MobileSupplierDashboardState();
}

class _MobileSupplierDashboardState extends State<MobileSupplierDashboard> {
  Widget _currentWidget = OrderList();

  // Instance of AuthService
  final AuthService _authService = AuthService();

  // Function to handle logout
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Retrieve your token here

    try {
      // ignore: use_build_context_synchronously
      await _authService.logout(context, token!);
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login'); // Adjust based on your routing
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  // Function to show confirmation dialog before logout
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call the logout function
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 16, 136, 165),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'images/otopph.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 5), // Added space
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  'SUPPLIER DASHBOARD',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(), // Placeholder to center the title
            ),
          ],
        ),
      ),

      drawer: Drawer(
        elevation: 0,
        width: 200,
        child: Container(
          color: Color.fromARGB(255, 16, 136, 165),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'My Product',
                  style: TextStyle(fontSize: 13),
                ),
                onTap: () {
                  setState(() {
                    // _currentWidget = AddProductScreen();
                  });
                  Navigator.of(context).pop(); // Close the drawer after selection
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(
                  'Suppliers',
                  style: TextStyle(fontSize: 13),
                ),
                onTap: () {
                  setState(() {
                    _currentWidget = OrderList();
                  });
                  Navigator.of(context).pop(); // Close the drawer after selection
                },
              ),
              ListTile(
                leading: Icon(Icons.handshake_outlined),
                title: Text(
                  'Transaction',
                  style: TextStyle(fontSize: 13),
                ),
                onTap: () {
                  setState(() {
                    _currentWidget = MyTransaction();
                  });
                  Navigator.of(context).pop(); // Close the drawer after selection
                },
              ),
              ListTile(
                leading: Icon(Icons.add_box),
                title: Text(
                  'On Sales',
                  style: TextStyle(fontSize: 13),
                ),
                onTap: () {
                  // Uncomment and implement the action for On Sales if needed
                  setState(() {
                    _currentWidget = CustomContainer();
                  });
                  Navigator.of(context).pop(); // Close the drawer after selection
                },
              ),
              SizedBox(height: 20), // Added space before logout
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 13),
                ),
                onTap: _showLogoutConfirmationDialog, // Show confirmation dialog on tap
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.center,
            child: _currentWidget,
          ),
        ),
      ),
    );
  }
}
