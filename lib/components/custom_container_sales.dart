import 'package:flutter/material.dart';
// import 'package:otop_front/sales_widget/categories_widget.dart';
import 'package:otop_front/sales_widget/outstanding_supplier_chart.dart';
import 'package:otop_front/sales_widget/suppliers_products_container.dart';
import 'package:otop_front/sales_widget/impression_measurement_widget.dart';
import 'package:otop_front/sales_widget/spend_by_widget.dart';
import 'package:otop_front/sales_widget/total_otop_products.dart';
import 'package:otop_front/sales_widget/total_suppliers.dart';
import 'package:otop_front/sales_widget/total_spend.dart';
import 'package:otop_front/sales_widget/total_food_nonfood.dart';

class CustomContainerSales extends StatelessWidget {
  const CustomContainerSales({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Expanded(child: TotalSpendWidget()),
                Expanded(child: TotalImpressionsWidget()),
                Expanded(child: ViewableImpressionsWidget()),
                Expanded(child: TotalSalesWidget()),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: const [
                Expanded(child: SpendByChannelWidget()),
                Expanded(child: ResonanceScoreWidget()),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: const [
                Expanded(child: DeviceTypeWidget()),
                Expanded(child: ImpressionMeasurementWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(home: CustomContainerSales()),
  );
}
