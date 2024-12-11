// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:otop_front/services/product_services.dart';
// import 'package:otop_front/widget/order_requestDialog.dart';
import 'package:otop_front/widget/order_request_dialog.dart';

import '../services/order_service.dart';
// import '../services/product_serviceOrder.dart';

final Logger _logger = Logger();

class OrderDialogWidget extends StatefulWidget {
  final Map<String, dynamic> supplier;

  const OrderDialogWidget({super.key, required this.supplier});

  @override
  _OrderDialogWidgetState createState() => _OrderDialogWidgetState();
}

class _OrderDialogWidgetState extends State<OrderDialogWidget> {
  // Store quantities for each product
  Map<String, int> productQuantities = {};

  @override
  Widget build(BuildContext context) {
    final ProductServices productService = ProductServices();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
            color: const Color.fromARGB(255, 10, 195, 236), width: 2),
      ),
      child: Container(
        width: 800,
        height: 500,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ORDER TO ${widget.supplier['store_name']}',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 7, 136, 175)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>?>(
                future:
                    productService.getProductsByStore(widget.supplier['id']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  final products = snapshot.data!;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text('Name',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Description',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Price',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Category',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Quantity',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                          label: Text('Action',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                      rows: products.map((product) {
                        // Split the description into words
                        String description = product['description'];
                        List<String> descriptionWords = description.split(' ');
                        bool isExpanded = false;

                        // Show only the first 4 words
                        String displayedDescription = descriptionWords.length >
                                4
                            ? '${descriptionWords.sublist(0, 4).join(' ')}...'
                            : description;

                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                product['name'],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded
                                      // ignore: dead_code
                                      ? description
                                      : displayedDescription,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '₱${product['price']}',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            DataCell(
                              Text(
                                product['category'],
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            DataCell(
                              // Display the product quantity from the database
                              Text(
                                '${product['quantity']}',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
  final productId = product['id']; // Assuming product['id'] contains the product ID
  final supplierId = widget.supplier['id'];

  showDialog(
    context: context,
    builder: (_) => CreateOrderRequestDialog(
      productName: product['name'],
      onOrderRequested: (quantity, description) async {
        final response = await OrderService().createOrder(
          productId: productId,
          quantity: quantity,
          supplierId: supplierId,
        );

        if (response != null && response.statusCode == 201) {
          _logger.i('Order successfully created');
          // Optionally show a success message or update UI
        } else {
          _logger.e('Failed to create order');
          // Optionally show an error message
        }
      },
    ),
  );
},

                                child: const Text('Order'),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Bottom bar with total quantity and total price
            FutureBuilder<List<dynamic>?>(
              future: productService.getProductsByStore(widget.supplier['id']),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
