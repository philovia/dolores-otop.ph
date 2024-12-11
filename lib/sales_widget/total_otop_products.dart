import 'package:flutter/material.dart';
import 'package:otop_front/services/otop_sales_service.dart';

class TotalImpressionsWidget extends StatelessWidget {
  const TotalImpressionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final otopService = OtopProductServices();

    return FutureBuilder<Map<String, dynamic>>(
      future: fetchProductData(otopService), // New method to get product data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final totalProducts = snapshot.data?['totalProducts'] ?? 0;
          final percentageChange = snapshot.data?['percentageChange'] ?? 0.0;
          final percentageColor =
              percentageChange >= 0 ? Colors.green : Colors.red;

          return SizedBox(
            width: 200,
            height: 100,
            child: Card(
              surfaceTintColor: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 25),
                        Icon(Icons.shop_2_sharp, size: 30, color: Colors.blue),
                        SizedBox(width: 120),
                        Text(
                          totalProducts.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 25),
                        Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 90),
                        Text(
                          '${percentageChange.toStringAsFixed(2)}%',
                          style: TextStyle(color: percentageColor),
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

  // Helper function to fetch product data
  Future<Map<String, dynamic>> fetchProductData(
      OtopProductServices service) async {
    int totalProducts = await service.getOtopTotalProducts();
    double percentageChange = await service.calculatePercentageChange();

    return {
      'totalProducts': totalProducts,
      'percentageChange': percentageChange,
    };
  }
}
