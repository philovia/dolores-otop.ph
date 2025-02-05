import 'package:flutter/material.dart';

class ResponsiveDashboardLayout extends StatelessWidget {
  final Widget mobileAdminDashboard;
  final Widget tabletAdminDashboard;
  final Widget desktopAdminDashboard;

  const ResponsiveDashboardLayout({
    super.key,
    required this.mobileAdminDashboard,
    required this.desktopAdminDashboard,
    required this.tabletAdminDashboard,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: non_constant_identifier_names
      builder: (context, Constraints) {
        if (Constraints.maxWidth < 400) {
          return mobileAdminDashboard;
        } else if (Constraints.maxWidth < 1100) {
          return tabletAdminDashboard;
        } else {
          return desktopAdminDashboard;
        }
      },
    );
  }
}
