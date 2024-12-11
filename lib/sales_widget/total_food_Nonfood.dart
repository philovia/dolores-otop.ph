// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otop_front/services/otop_sales_service.dart';

class ViewableImpressionsWidget extends StatelessWidget {
  const ViewableImpressionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final otopService = OtopProductServices();

    return FutureBuilder<Map<String, int>>(
      future: otopService.getTotalProductsByCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final foodCount = snapshot.data?['Food'] ?? 0;
          final nonFoodCount = snapshot.data?['Non-Food'] ?? 0;

          // Calculate percentage change between Non-Food and Food
          double percentageChange = 0;
          if (foodCount != 0) {
            percentageChange = ((nonFoodCount - foodCount) / foodCount) * 100;
          }

          return SizedBox(
            width: 200,
            height: 100,
            child: Card(
              surfaceTintColor: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // First Row for Icon
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(Icons.production_quantity_limits_sharp,
                            size: 30, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          'FOOD',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 95),
                        Text(
                          '$foodCount',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60),
                        Text(
                          'NON-FOOD',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 70),
                        Text(
                          '$nonFoodCount',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // SizedBox(height: 8),
                    // Percentage Change
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 25),
                        Text(
                          'Percent:',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 80),
                        Text(
                          '${percentageChange.toStringAsFixed(2)}%',
                          style: TextStyle(
                              color: percentageChange >= 0
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
