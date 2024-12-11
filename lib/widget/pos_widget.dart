import 'package:flutter/material.dart';
import 'package:otop_front/chart_widget/checkour_section.dart';
import 'package:otop_front/chart_widget/product_cart.dart';
import 'package:otop_front/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class POSScreen extends StatelessWidget {
  const POSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('POS System'),
            ],
          ),
        ),
        body: Row(
          children: [
            Expanded(flex: 2, child: ProductList()),
            SizedBox(width: 10),
            Expanded(flex: 1, child: CheckoutSection()),

          ],
        ),
      ),
    );
  }
}
