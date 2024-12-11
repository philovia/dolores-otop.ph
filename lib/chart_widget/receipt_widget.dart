import 'package:flutter/material.dart';
import 'package:logger/logger.dart';  // Import the logger package

class ReceiptWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double total;
  final double received;
  final double change;

  // Initialize a logger instance
  final Logger logger = Logger();

   ReceiptWidget({
    super.key,
    required this.items,
    required this.total,
    required this.received,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('DOLORES OTOP.PH Receipt'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('--- Receipt ---', style: TextStyle(fontWeight: FontWeight.bold)),
            ...items.map((item) {
              return Text(
                '${item['name']} (x${item['quantity']}):........... ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}',
              );
            }),
            const Divider(),
            Text('Total Paid: ₱${total.toStringAsFixed(2)}'),
            Text('Amount Received: ₱${received.toStringAsFixed(2)}'),
            Text('Change: ₱${change.toStringAsFixed(2)}'),
            const Text('--- End of Receipt ---', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the receipt dialog
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            // Replace print with logger
            logger.d("Printing receipt...");  // Now it uses the logger
          },
          child: const Text('Print'),
        ),
      ],
    );
  }
}
