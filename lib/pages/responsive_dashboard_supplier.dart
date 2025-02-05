import 'package:flutter/material.dart';

class ResponsiveDashboardSupplier extends StatelessWidget {
  final Widget mobileSupplierDashboard;
  final Widget tabletSupplierDashboard;
  final Widget desktopSupplierDashboard;

  const ResponsiveDashboardSupplier({
    super.key,
    required this.mobileSupplierDashboard,
    required this.desktopSupplierDashboard,
    required this.tabletSupplierDashboard,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: non_constant_identifier_names
      builder: (context, Constraints) {
        if (Constraints.maxWidth < 400) {
          return mobileSupplierDashboard;
        } else if (Constraints.maxWidth < 1100) {
          return tabletSupplierDashboard;
        } else {
          return desktopSupplierDashboard;
        }
      },
    );
  }
}
