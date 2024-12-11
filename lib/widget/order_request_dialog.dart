// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:flutter/material.dart';

class CreateOrderRequestDialog extends StatefulWidget {
  final String productName;
  final Function(int, String) onOrderRequested;

  const CreateOrderRequestDialog({
    super.key,
    required this.productName,
    required this.onOrderRequested,
  });

  @override
  _CreateOrderRequestDialogState createState() =>
      _CreateOrderRequestDialogState();
}

class _CreateOrderRequestDialogState extends State<CreateOrderRequestDialog> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color.fromARGB(255, 10, 195, 236),
          width: 2,
        ),
      ),
      child: SizedBox(
        width: 400, // Set your desired width here
        height: 300, // Set your desired height here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order Request for ${widget.productName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 7, 136, 175),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
  onPressed: () {
    final quantity = int.tryParse(_quantityController.text);
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid quantity')),
      );
      return;
    }
    final description = _descriptionController.text;
    widget.onOrderRequested(quantity, description);
    Navigator.of(context).pop();
  },
  child: const Text('Submit Order'),
),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
