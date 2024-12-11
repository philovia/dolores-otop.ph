import 'package:flutter/material.dart';
import 'package:otop_front/components/custom_container_cashier.dart';
// import 'package:otop_front/components/custom_container_receipts.dart';
import 'package:otop_front/components/on_sales.dart';
// import 'package:otop_front/components/add_product_screen.dart';
// import 'package:otop_front/components/reports.dart';
import 'package:otop_front/components/supplier_list.dart';
import 'package:otop_front/components/transactions.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/logout_services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TabletCashierDashboard extends StatefulWidget {
  const TabletCashierDashboard({super.key});

  @override
  State<TabletCashierDashboard> createState() =>
      _TabletCashierDashboardState();
}

class _TabletCashierDashboardState extends State<TabletCashierDashboard> {
  Widget _currentWidget = SupplierList();

  // Instance of AuthService
  final AuthService _authService = AuthService();

  // Add these variables
  double totalPrice = 0.0; // Initialize totalPrice
  int totalStock = 0; // Initialize totalStock
  List<dynamic> cartItems = []; // Initialize cartItems as needed
  int productCount = 0; // Initialize productCount

  // Function to handle logout
 Future<void> _logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token'); // Retrieve your token here

  try {
     // Call the logout method without passing context
   // ignore: use_build_context_synchronously
   await _authService.logout(context, token!);
    // After the logout, check if the widget is still mounted before using context
    if (mounted) {
      // Show a success message or navigate to the login screen
      Navigator.of(context).pushReplacementNamed('/login'); // Adjust based on your routing
    }
  } catch (e) {
    // Check if the widget is still mounted before showing a Snackbar
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
      body: Column(
        children: [
          // AppBar
          PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 16, 136, 165),
              title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/otopph.png',
          height: 50,
          width: 50,
        ),
        Spacer(),
        Text(
          'CASHIER DASHBOARD',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Spacer(flex: 2), // Ensure more spacing to the right of the title
      ],
    ),
  ),
),

          // Main content
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 200,
                  color: Color.fromARGB(255, 16, 136, 165),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text(
                         'Suppliers',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = SupplierList();
                          });
                        },
                      ),
                     ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'Purchase',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = CustomContainerCashier();
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box),
                        title: Text(
                          'Transactions',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = MyTransaction();
                          });
                        },
                      ),
                       ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'On Sales',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = OnSales();
                          });
                        },
                      ),
                        ListTile(
                        leading: Icon(Icons.home),
                        title: Text(
                          'Receipts',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            // _currentWidget = CustomContainerReceipts(
                            //   totalPrice: totalPrice,
                            //   productCount: productCount,
                            //   totalStock: totalStock,
                            //   cartItems: [],
                            // );
                          });
                        },
                      ),
                      Spacer(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(
                          'Logout',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: _showLogoutConfirmationDialog,
                      ),
                    ],
                  ),
                ),
                // Main content area
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                    
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: _currentWidget,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
