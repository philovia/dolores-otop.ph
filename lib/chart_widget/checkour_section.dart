// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:otop_front/models/sold_items_model.dart';
// import 'package:otop_front/services/otop_product_service.dart';
import 'package:provider/provider.dart';
import 'package:otop_front/providers/cart_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckoutSection extends StatefulWidget {
  const CheckoutSection({super.key});

  @override
  _CheckoutSectionState createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSection> {
  double received = 0.00;
  double change = 0.00;

  void calculateChange(double total) {
    setState(() {
      change = received - total;
    });
  }

  // Updated completeCheckout method
  Future<void> completeCheckout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    try {
      // Iterate through each item in the cart and call the API
      for (var item in cartProvider.cartItems) {
        final productId = item['product_id'] ?? 0;
        final quantitySold = item['quantity'] ?? 0;
        final price = item['price'] ?? 0.0;

        // Print the item data for debugging purposes
        print('Recording sold item: '
              'product_id: $productId, '
              'quantitySold: $quantitySold, '
              'totalAmount: ${price * quantitySold}, '
              'soldDate: ${DateTime.now()}');

        // If the data is invalid, throw an error
        if (productId == 0 || quantitySold == 0 || price == 0.0) {
          throw Exception('Invalid item data: '
              'productId: $productId, quantitySold: $quantitySold, price: $price');
        }

        // Call the API to record the sold item
        await recordSoldItems(productId, quantitySold);
      }

      if (!mounted) return;

      // Clear the cart after successful checkout
      cartProvider.clearCart();
      setState(() {
        received = 0.00;
        change = 0.00;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout completed successfully!')),
      );
    } catch (error) {
      if (!mounted) return;

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during checkout: $error')),
      );
    }
  }

  // Function to make API call to record sold items
  Future<void> recordSoldItems(int productId, int quantitySold) async {
    const String apiUrl = 'http://127.0.0.1:8097/api/otop/sold_items'; // Replace with your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
          'quantity_sold': quantitySold,
        }),
      );

     if (response.statusCode == 200) {
  print('Sold item recorded successfully');
  print('Response: ${response.body}');
} else {
  print('Failed to record sold item. Status code: ${response.statusCode}');
  print('Response: ${response.body}');
}

    } catch (error) {
  print('Error during checkout: $error');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error during checkout: $error')),
  );
}

  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bill', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return Text(
                  '${item['name']} (x${item['quantity']}): ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          ),
          Divider(),
          Text('Total: ₱${cartProvider.total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Received: ₱', style: TextStyle(fontSize: 18)),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    received = double.tryParse(value) ?? 0.00;
                    calculateChange(cartProvider.total);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.00',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [50, 100, 200, 500, 1000].map((amount) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    received += amount;
                    calculateChange(cartProvider.total);
                  });
                },
                child: Text('₱$amount'),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text('Change: ₱${change.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (received >= cartProvider.total) {
                completeCheckout(); // Call the complete checkout function
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Received amount is insufficient!')),
                );
              }
            },
            child: Text('Complete Checkout'),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
