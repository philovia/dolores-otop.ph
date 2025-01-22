import 'package:flutter/material.dart';
import 'package:otop_front/components/custom_con_OtpProduct_list.dart';
import 'package:otop_front/components/custom_container_sales.dart';
import 'package:otop_front/components/custom_container_suppproduct_page.dart';
import 'package:otop_front/components/custome_container_suppselect.dart';
import 'package:otop_front/components/transactions.dart';
import 'package:otop_front/components/verified_transactions.dart';
import 'package:otop_front/responsive/constant.dart';
import 'package:otop_front/services/auth_service.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/generate_sales_widget.dart';

class DesktopAdminDashboard extends StatefulWidget {
  const DesktopAdminDashboard({super.key});

  @override
  State<DesktopAdminDashboard> createState() => _DesktopAdminDashboardState();
}

class _DesktopAdminDashboardState extends State<DesktopAdminDashboard> {
  Widget _currentWidget = CustomContainerSales();

  final AuthService _authService = AuthService();
  bool _isSuppliersExpanded = false;
  bool _isSalesExpanded = false;

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      try {
        // ignore: use_build_context_synchronously
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
    return Scaffold(
      backgroundColor: myDefaultBackground,
      body: Column(
        children: [
          AppBar(
            elevation: 0,
            title: Row(
              children: [
                Image.asset('images/otopph.png', height: 50, width: 50),
                const SizedBox(width: 575),
                const Text('ADMIN DASHBOARD',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 6, 122, 151),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 200,
                  color: const Color.fromARGB(255, 6, 122, 151),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.shopping_bag,
                            color: Color.fromARGB(255, 228, 224, 224)),
                        title: const Text('Manage Suppliers',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        dense: true,
                        trailing: Icon(
                          _isSuppliersExpanded
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: const Color.fromARGB(255, 228, 224, 224),
                        ),
                        onTap: () => setState(() {
                          _isSuppliersExpanded = !_isSuppliersExpanded;
                        }),
                      ),
                      if (_isSuppliersExpanded)
                        Column(
                          children: [
                            _buildListTile(
                              icon: Icons.add,
                              title: '   Add Supplier',
                              onTap: () {
                                setState(() {
                                  _currentWidget = CustomContainerCashier();
                                  _isSuppliersExpanded = false;
                                });
                              },
                            ),
                            _buildListTile(
                              icon: Icons.person_search,
                              title: '   Supplier Details',
                              onTap: () {
                                setState(() {
                                  _currentWidget = CustomContainerSupselect();
                                  _isSuppliersExpanded = false;
                                });
                              },
                            ),
                            _buildListTile(
                              icon: Icons.list,
                              title: '   Order Status',
                              onTap: () {
                                setState(() {
                                  _currentWidget = MyTransaction();
                                  _isSuppliersExpanded = false;
                                });
                              },
                            ),
                          ],
                        ),
                      const Divider(color: Color.fromARGB(207, 88, 86, 86)),
                      _buildListTile(
                        icon: Icons.home,
                        title: 'Transaction History',
                        onTap: () => setState(() {
                          _currentWidget = MyVerifiedTransaction();
                        }),
                      ),
                      const Divider(color: Color.fromARGB(207, 88, 86, 86)),
                      _buildListTile(
                        icon: Icons.add_box,
                        title: 'Manage Products',
                        onTap: () => setState(() {
                          _currentWidget = CustomeConSuppage();
                        }),
                      ),
                      const Divider(color: Color.fromARGB(207, 88, 86, 86)),
                      ListTile(
                        leading: Icon(
                          Icons.shopping_bag_rounded,
                          color: Color.fromARGB(255, 228, 224, 224),
                        ),
                        title: Text('Sales',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        dense: true,
                        trailing: Icon(
                          _isSalesExpanded
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: const Color.fromARGB(255, 228, 224, 224),
                        ),
                        onTap: () => setState(() {
                          _isSalesExpanded = !_isSalesExpanded;
                        }),
                      ),
                      if (_isSalesExpanded)
                        Column(
                          children: [
                            _buildListTile(
                              icon: Icons.shopping_bag_rounded,
                              title: '   Sales Overview',
                              onTap: () {
                                setState(() {
                                  _currentWidget = CustomContainerSales();
                                  _isSalesExpanded = false;
                                });
                              },
                            ),
                            _buildListTile(
                              icon: Icons.add,
                              title: '   Generate Sales',
                              onTap: () {
                                setState(() {
                                  _currentWidget = SalesInventoryPage();
                                  _isSalesExpanded = false;
                                });
                              },
                            ),
                          ],
                        ),
                      const Spacer(),
                      _buildListTile(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: _showLogoutConfirmationDialog,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(98, 151, 147, 147),
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
