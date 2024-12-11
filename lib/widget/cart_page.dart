// lib/widgets/cart_item_widget.dart

import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  // final String productName;
  // final double price;
  // final int quantity;
  // final double total;

  const CartItemWidget({
    super.key,
    // required this.productName,
    // required this.price,
    // required this.quantity,
    // required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // children: [
              //   Text(
              //     productName,
              //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //   ),
              //   const SizedBox(height: 4),
              // ],
            ),
          ),
          // Text(
            // '\$$price',
            // style: const TextStyle(fontSize: 16),
          // ),
          const SizedBox(width: 16.0),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Decrease quantity logic here
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              // Text(
              //   quantity.toString(),
              //   style: const TextStyle(fontSize: 16),
              // ),
              IconButton(
                onPressed: () {
                  // Increase quantity logic here
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          const SizedBox(width: 16.0),
          // Text(
          //   '\$$total',
          //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          IconButton(
            onPressed: () {
              // Remove item logic here
            },
            icon: const Icon(Icons.close),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
