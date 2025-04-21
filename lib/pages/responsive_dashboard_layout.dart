import 'package:flutter/material.dart';

class ResponsiveDashboardLayout extends StatelessWidget {
  final Widget desktopAdminDashboard;

  const ResponsiveDashboardLayout({
    super.key,
    required this.desktopAdminDashboard,
  });

  @override
  Widget build(BuildContext context) {
    return desktopAdminDashboard;
  }
}
