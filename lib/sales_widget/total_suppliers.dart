// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:otop_front/services/otop_sales_service.dart';

class TotalSalesWidget extends StatefulWidget {
  const TotalSalesWidget({super.key});

  @override
  _TotalSalesWidgetState createState() => _TotalSalesWidgetState();
}

class _TotalSalesWidgetState extends State<TotalSalesWidget> {
  int? previousSuppliers;
  double percentageChange = 0.0;

  @override
  Widget build(BuildContext context) {
    final otopService = OtopProductServices();

    return FutureBuilder<int>(
      future: otopService.getTotalSuppliers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final currentSuppliers = snapshot.data ?? 0;
          if (previousSuppliers != null) {
            // Calculate the percentage change
            setState(() {
              percentageChange = ((currentSuppliers - previousSuppliers!) /
                      previousSuppliers!) *
                  100;
            });
          }
          previousSuppliers = currentSuppliers;

          return SizedBox(
            width: 200,
            height: 100,
            child: Card(
              surfaceTintColor: const Color.fromARGB(255, 83, 243, 165),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // First Row for Icon
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(Icons.person_2_rounded,
                            size: 30, color: Colors.blue),
                        SizedBox(width: 120),
                        Text(
                          '$currentSuppliers', // Display total suppliers
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        Text(
                          'Suppliers',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 90),
                        // Text(
                        //   // Display percentage change
                        //   '${percentageChange.toStringAsFixed(2)}%',
                        //   style: TextStyle(
                        //       color: percentageChange >= 0
                        //           ? Colors.green
                        //           : Colors.red),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SizedBox(); // Return an empty widget if no data
      },
    );
  }
}
