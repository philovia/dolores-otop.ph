// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/responsive/responsive_layout.dart';
import 'package:otop_front/widget/pos_widget.dart';
import 'package:otop_front/widget/product_list_otopcashier.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class DesktopCashierDashboard extends StatefulWidget {
  const DesktopCashierDashboard({super.key});

  @override
  State<DesktopCashierDashboard> createState() =>
      _DesktopCashierDashboardState();
}

class _DesktopCashierDashboardState extends State<DesktopCashierDashboard> {
  Widget _currentWidget = ProductCheckoutWidget();

  final AuthService _authService = AuthService();
  //  bool _isSuppliersExpanded = false;

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      try {
        await _authService.logout(context, token);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool dense = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 228, 224, 224)),
      title: Text(title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Arial',
          )),
      dense: dense,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: Scaffold(
      backgroundColor: myDefaultBackground,
      body: Column(
        children: [
          // AppBar
          PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                children: [
                  Image.asset(
                    'images/otopph.png',
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 575),
                  Text('CASHIER DASHBOARD',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              backgroundColor: Color.fromARGB(255, 16, 136, 165),
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
                        title: Text(
                          'P O S',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Arial',
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = ProductCheckoutWidget();
                          });
                        },
                      ),
                      Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                      ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text(
                          'Receipts',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Arial',
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            // _currentWidget = ReceiptsDisplay(receipts: receipts)
                          });
                        },
                      ),
                      Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                      ListTile(
                        leading: Icon(Icons.add_box),
                        title: Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Arial',
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = ProductListScreenCashier();
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
                      constraints: const BoxConstraints(maxWidth: 1700),
                      // padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),
                        // topRight: Radius.circular(20.0),)
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
    ),

        tabletBody: Scaffold(
          backgroundColor: myDefaultBackground,
          body: Column(
            children: [
              // AppBar
              PreferredSize(
                preferredSize: Size.fromHeight(90),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Row(
                    children: [
                      Image.asset(
                        'images/otopph.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(width: 575),
                      Text('CASHIER DASHBOARD',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  backgroundColor: Color.fromARGB(255, 16, 136, 165),
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
                            title: Text(
                              'P O S',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = ProductCheckoutWidget();
                              });
                            },
                          ),
                          Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                          ListTile(
                            leading: Icon(Icons.shopping_bag),
                            title: Text(
                              'Receipts',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                // _currentWidget = ReceiptsDisplay(receipts: receipts)
                              });
                            },
                          ),
                          Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                          ListTile(
                            leading: Icon(Icons.add_box),
                            title: Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = ProductListScreenCashier();
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
                          constraints: const BoxConstraints(maxWidth: 1700),
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),
                            // topRight: Radius.circular(20.0),)
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
        ),
        desktopBody: Scaffold(
          backgroundColor: myDefaultBackground,
          body: Column(
            children: [
              // AppBar
              PreferredSize(
                preferredSize: Size.fromHeight(90),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Row(
                    children: [
                      Image.asset(
                        'images/otopph.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(width: 575),
                      Text('CASHIER DASHBOARD',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  backgroundColor: Color.fromARGB(255, 16, 136, 165),
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
                            title: Text(
                              'P O S',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = ProductCheckoutWidget();
                              });
                            },
                          ),
                          Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                          ListTile(
                            leading: Icon(Icons.shopping_bag),
                            title: Text(
                              'Receipts',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                // _currentWidget = ReceiptsDisplay(receipts: receipts)
                              });
                            },
                          ),
                          Divider(color: const Color.fromARGB(207, 88, 86, 86)),
                          ListTile(
                            leading: Icon(Icons.add_box),
                            title: Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Arial',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = ProductListScreenCashier();
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
                          constraints: const BoxConstraints(maxWidth: 1700),
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),
                            // topRight: Radius.circular(20.0),)
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
        )
    );

  }
}
