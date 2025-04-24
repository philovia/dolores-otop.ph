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
  late Future<int> futureSuppliers;

  @override
  void initState() {
    super.initState();
    futureSuppliers = fetchSupplierData();
  }

  Future<int> fetchSupplierData() async {
    final otopService = OtopProductServices();
    final currentSuppliers = await otopService.getTotalSuppliers();

    if (previousSuppliers != null) {
      percentageChange = ((currentSuppliers - previousSuppliers!) /
          previousSuppliers!) *
          100;
    }
    previousSuppliers = currentSuppliers;

    return currentSuppliers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: futureSuppliers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final currentSuppliers = snapshot.data!;

          return SizedBox(
            width: 200,
            height: 100,
            child: Card(
              surfaceTintColor: const Color.fromARGB(255, 83, 243, 165),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(Icons.person_2_rounded,
                            size: 30, color: Colors.blue),
                        const SizedBox(width: 120),
                        Text(
                          '$currentSuppliers',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        const Text(
                          'Suppliers',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        // const SizedBox(width: 90),
                        // Text(
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

        return const SizedBox();
      },
    );
  }
}
