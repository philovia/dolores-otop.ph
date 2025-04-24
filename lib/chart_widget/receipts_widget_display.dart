import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/receipts_provider.dart';

class ReceiptsDisplay extends StatelessWidget {
  const ReceiptsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final receipts = Provider.of<ReceiptProvider>(context).receipts;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Receipts'),
      ),
      body: receipts.isEmpty
          ? const Center(child: Text('No receipts printed yet'))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: receipts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Change to 4 if desired
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 1, // Adjust based on content
          ),
          itemBuilder: (context, index) {
            final receipt = receipts[index];
            return Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Receipt #${index + 1} - ${receipt.timestamp.toLocal()}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          for (var item in receipt.items)
                            Text("${item['name']} x${item['quantity']}"),
                          const SizedBox(height: 5),
                          Text("Received: ₱${receipt.received.toStringAsFixed(2)}", style: TextStyle(fontSize: 12),),
                          Text("Change: ₱${receipt.change.toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                          Text("Total: ₱${receipt.total.toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
