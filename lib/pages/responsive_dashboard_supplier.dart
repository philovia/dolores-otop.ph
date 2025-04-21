import 'package:flutter/material.dart';

class ResponsiveDashboardSupplier extends StatelessWidget {
  // final Widget mobileSupplierDashboard;
  // final Widget tabletSupplierDashboard;
  final Widget desktopSupplierDashboard;

  const ResponsiveDashboardSupplier({
    super.key,
    // required this.mobileSupplierDashboard,
    required this.desktopSupplierDashboard,
    // required this.tabletSupplierDashboard,
  });
  @override
  Widget build(BuildContext context) {
    return desktopSupplierDashboard;
  }
}
