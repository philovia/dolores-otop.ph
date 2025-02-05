import 'package:flutter/material.dart';

class ResponsiveDashboardCashier extends StatelessWidget {
  final Widget mobileCashierDashboard;
  final Widget tabletCashierDashboard;
  final Widget desktopCashierDashboard;

  const ResponsiveDashboardCashier({
    super.key,
    required this.mobileCashierDashboard,
    required this.desktopCashierDashboard,
    required this.tabletCashierDashboard,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: non_constant_identifier_names
      builder: (context, Constraints) {
        if (Constraints.maxWidth < 400) {
          return mobileCashierDashboard;
        } else if (Constraints.maxWidth < 1100) {
          return tabletCashierDashboard;
        } else {
          return desktopCashierDashboard;
        }
      },
    );
  }
}
