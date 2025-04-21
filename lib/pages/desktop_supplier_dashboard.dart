// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otop_front/components/custom_container_salessipplier.dart';
import 'package:otop_front/components/suppliers_pending_transaction.dart';
import 'package:otop_front/components/suppliers_verified_transaction.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/responsive/responsive_layout.dart';
import 'package:otop_front/services/auth_service.dart';

import 'package:otop_front/widget/supplier_product_listscreen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopSupplierDashboard extends StatefulWidget {
  const DesktopSupplierDashboard({super.key});

  @override
  State<DesktopSupplierDashboard> createState() =>
      _DesktopSupplierDashboardState();
}

class _DesktopSupplierDashboardState extends State<DesktopSupplierDashboard> {
  Widget _currentWidget = SupplierProductListscreen();

  // Instance of AuthService
  final AuthService _authService = AuthService();

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
                  Text('SUPPLIER DASHBOARD',
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
                  color: Color.fromARGB(255, 22, 141, 170),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.home, color: Colors.white),
                        title: Text(
                          'My Product',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = SupplierProductListscreen();
                          });
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(207, 88, 86, 86),
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag, color: Colors.white),
                        title: Text(
                          'Orders',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = SuppliersPendingTransaction();
                          });
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(207, 88, 86, 86),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box, color: Colors.white),
                        title: Text(
                          'Transaction History',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = SuppliersVerifiedTransaction();
                          });
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(207, 110, 104, 104),
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag_rounded,
                            color: Colors.white),
                        title: Text(
                          'Sales',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _currentWidget = CustomContainerSalessipplier();
                          });
                        },
                      ),
                      Spacer(),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.white),
                        title: Text(
                          'Logout',
                          style: TextStyle(fontSize: 13, color: Colors.white),
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
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
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
                      Text('SUPPLIER DASHBOARD',
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
                      color: Color.fromARGB(255, 22, 141, 170),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          ListTile(
                            leading: Icon(Icons.home, color: Colors.white),
                            title: Text(
                              'My Product',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = SupplierProductListscreen();
                              });
                            },
                          ),
                          Divider(
                            color: Color.fromARGB(207, 88, 86, 86),
                          ),
                          ListTile(
                            leading: Icon(Icons.shopping_bag, color: Colors.white),
                            title: Text(
                              'Orders',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = SuppliersPendingTransaction();
                              });
                            },
                          ),
                          Divider(
                            color: Color.fromARGB(207, 88, 86, 86),
                          ),
                          ListTile(
                            leading: Icon(Icons.add_box, color: Colors.white),
                            title: Text(
                              'Transaction History',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = SuppliersVerifiedTransaction();
                              });
                            },
                          ),
                          Divider(
                            color: Color.fromARGB(207, 110, 104, 104),
                          ),
                          ListTile(
                            leading: Icon(Icons.shopping_bag_rounded,
                                color: Colors.white),
                            title: Text(
                              'Sales',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = CustomContainerSalessipplier();
                              });
                            },
                          ),
                          Spacer(),
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.white),
                            title: Text(
                              'Logout',
                              style: TextStyle(fontSize: 13, color: Colors.white),
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              )),
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
                      Text('SUPPLIER DASHBOARD',
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
                      color: Color.fromARGB(255, 22, 141, 170),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          ListTile(
                            leading: Icon(Icons.home, color: Colors.white),
                            title: Text(
                              'My Product',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = SupplierProductListscreen();
                              });
                            },
                          ),
                          Divider(
                            color: Color.fromARGB(207, 88, 86, 86),
                          ),
                          ListTile(
                            leading: Icon(Icons.shopping_bag, color: Colors.white),
                            title: Text(
                              'Orders',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = SuppliersPendingTransaction();
                              });
                            },
                          ),
                          Divider(
                            color: Color.fromARGB(207, 88, 86, 86),
                          ),
                          ListTile(
                            leading: Icon(Icons.add_box, color: Colors.white),
                            title: Text(
                              'Transaction History',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = SuppliersVerifiedTransaction();
                              });
                            },
                          ),
                          Divider(
                            color: Color.fromARGB(207, 110, 104, 104),
                          ),
                          ListTile(
                            leading: Icon(Icons.shopping_bag_rounded,
                                color: Colors.white),
                            title: Text(
                              'Sales',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                _currentWidget = CustomContainerSalessipplier();
                              });
                            },
                          ),
                          Spacer(),
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.white),
                            title: Text(
                              'Logout',
                              style: TextStyle(fontSize: 13, color: Colors.white),
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              )),
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
