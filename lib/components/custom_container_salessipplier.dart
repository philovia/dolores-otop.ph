import 'package:flutter/material.dart';
import 'package:otop_front/sales_widget/spend_by_widget.dart';
// import 'package:otop_front/sales_widget/categories_widget.dart';
// import 'package:otop_front/sales_widget/outstanding_supplier_chart.dart';
// import 'package:otop_front/sales_widget/suppliers_products_container.dart';
// import 'package:otop_front/sales_widget/impression_measurement_widget.dart';
// import 'package:otop_front/sales_widget/spend_by_widget.dart';
// import 'package:otop_front/sales_widget/total_otop_products.dart';
// import 'package:otop_front/sales_widget/total_suppliers.dart';
// import 'package:otop_front/sales_widget/total_spend.dart';
// import 'package:otop_front/sales_widget/total_food_nonfood.dart';

class CustomContainerSalessipplier extends StatelessWidget {
  const CustomContainerSalessipplier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
        children: [
          Text("OTOP OPERATIONS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 250, 106, 3))),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: const [
                Expanded(child: SpendByChannelWidget()), // Only include SpendByChannelWidget here
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(home: CustomContainerSalessipplier()),
  );
}
