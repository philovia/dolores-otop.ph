import 'package:flutter/material.dart';

class ResponsiveDashboardCashier extends StatelessWidget {
  // final Widget mobileCashierDashboard;
  // final Widget tabletCashierDashboard;
  final Widget desktopCashierDashboard;

  const ResponsiveDashboardCashier({
    super.key,
    // required this.mobileCashierDashboard,
    required this.desktopCashierDashboard,
    // required this.tabletCashierDashboard,
  });
  @override
  Widget build(BuildContext context) {
    return desktopCashierDashboard;
  }
}
