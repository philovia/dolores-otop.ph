import 'package:flutter/material.dart';
import 'package:otop_front/components/auth.dart';
import 'package:otop_front/pages/desktop_admin_dashboard.dart';
import 'package:otop_front/pages/desktop_cashier_dashboard.dart';
import 'package:otop_front/pages/desktop_supplier_dashboard.dart';
import 'package:otop_front/pages/responsive_dashboard_cashier.dart';
import 'package:otop_front/pages/responsive_dashboard_layout.dart';
import 'package:otop_front/pages/responsive_dashboard_supplier.dart';
import 'package:otop_front/providers/cart_provider.dart';
import 'package:otop_front/providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
            create: (_) => CartProvider()), // Add CartProvider here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        home: AuthForm(),
        routes: {
          '/login': (context) => const AuthForm(),
          '/admin': (context) => const ResponsiveDashboardLayout(
                desktopAdminDashboard: DesktopAdminDashboard(),
              ),
          '/cashier': (context) => const ResponsiveDashboardCashier(
                desktopCashierDashboard: DesktopCashierDashboard(),
              ),
          '/supplier': (context) => const ResponsiveDashboardSupplier(
                desktopSupplierDashboard: DesktopSupplierDashboard(),
              ),
        },
      ),
    );
  }
}
