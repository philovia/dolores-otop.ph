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

  Future<void> completeCheckout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    try {
      for (var item in cartProvider.cartItems) {
        final productId = item['id'] ?? 0;
        final quantitySold = item['quantity'] ?? 0;
        final price = item['price'] ?? 0.0;

        if (productId == 0 || quantitySold == 0 || price == 0.0) {
          throw Exception('Invalid item data');
        }

        await recordSoldItems(productId, quantitySold);
      }

      cartProvider.clearCart();
      setState(() {
        received = 0.00;
        change = 0.00;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout completed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during checkout: $e')),
      );
    }
  }

  Future<void> recordSoldItems(int productId, int quantitySold) async {
    const String apiUrl = '(link unavailable)';

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
        print(
            'Failed to record sold item. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error recording sold item: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 222, 192), // Background color
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 5, // How much the shadow blurs
            offset: Offset(0, 3), // Position of the shadow (x, y)
          ),
        ],
        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
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
          Text(
            'Total: ₱${cartProvider.total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Received: ₱',
                style: TextStyle(fontSize: 18),
              ),
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
          Text(
            'Change: ₱${change.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: received >= cartProvider.total ? completeCheckout : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: received >= cartProvider.total
                  ? Colors.green
                  : Colors.grey, // Button color
              foregroundColor: Colors.white, // Text color
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12), // Button padding
              textStyle: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold), // Text styling
            ),
            child: const Text('Complete Checkout'),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
