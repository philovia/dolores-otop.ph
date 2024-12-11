import 'package:flutter/material.dart';
import 'package:otop_front/sales_widget/suppliers_product_widget.dart';


class DeviceTypeWidget extends StatelessWidget {
  const DeviceTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the table
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SUPPLIERS & PRODUCTS',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 100,
              color: Colors.grey[200],
              child: StoreProductTable(),
            ),
          ],
        ),
      ),
    );
  }
}
