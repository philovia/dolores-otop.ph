// receipts_display.dart
import 'package:flutter/material.dart';
// import 'receipt_widget.dart'; // Import the receipt widget

class ReceiptsDisplay extends StatelessWidget {
  final List<Widget> receipts;

  const ReceiptsDisplay({super.key, required this.receipts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts'),
      ),
      body: receipts.isEmpty
          ? const Center(child: Text('No receipts printed yet'))
          : ListView(
              children: receipts,
            ),
    );
  }
}
