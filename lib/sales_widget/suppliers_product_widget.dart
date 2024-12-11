// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:otop_front/services/otop_sales_service.dart';

class StoreProductTable extends StatefulWidget {
  const StoreProductTable({super.key});

  @override
  _StoreProductTableState createState() => _StoreProductTableState();
}

class _StoreProductTableState extends State<StoreProductTable> {
  late Future<List<Map<String, dynamic>>> _storeDataFuture;

  @override
  void initState() {
    super.initState();
    // Fetch data when widget is initialized
    _storeDataFuture = OtopProductServices().countSuppliersByStoreName();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _storeDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final data = snapshot.data!;
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.symmetric(),
                columnWidths: {
                  0: FractionColumnWidth(0.8),
                  1: FractionColumnWidth(0.2),
                },
                children: [
                  for (var store in data)
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(store['store_name']),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(store['product_count'].toString()),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
