import 'package:flutter/material.dart';
// import 'package:otop_front/components/add_product_screen.dart';
import 'package:otop_front/components/order_list.dart';
// import 'package:otop_front/components/supplier_list.dart';
import 'package:otop_front/components/transactions.dart';
// import 'package:otop_front/components/transactions.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/logout_services.dart';
import 'package:otop_front/widget/custom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabletSupplierDashboard extends StatefulWidget {
  const TabletSupplierDashboard({super.key});

  @override
  State<TabletSupplierDashboard> createState() =>
      _TabletSupplierDashboardState();
}

class _TabletSupplierDashboardState extends State<TabletSupplierDashboard> {
  Widget _currentWidget = OrderList();
  // Instance of AuthService
  final AuthService _authService = AuthService();

  // Function to handle logout
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Retrieve your token here

    try {
      // Call the logout method with context and token
      // ignore: use_build_context_synchronously
      await _authService.logout(context, token!);

      // Check if the widget is still mounted before using context
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login
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
              title: Stack(
                children: [
                  Center(
                    child: Text(
                      'SUPPLIER DASHBOARD',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    // left: 0,
                    child: Image.asset(
                      'images/otopph.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
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
                          'On Sales',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            // _currentWidget = AddProductScreen();
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'Orders',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = OrderList();
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
                          }); // Uncomment and add your logic
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box),
                        title: Text(
                          'On Sales',
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = CustomContainer();
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
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
