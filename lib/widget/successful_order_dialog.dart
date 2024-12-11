import 'package:flutter/material.dart';

class SuccessfulOrderDialog extends StatelessWidget {
  final Function onProceed;
  final Function onCancel;

  const SuccessfulOrderDialog({
    super.key,
    required this.onProceed,
    required this.onCancel,
  });

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
        height: 250, // Set your desired height here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Order Successfully Created!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 7, 136, 175),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Would you like to proceed with the order or cancel it?',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      onCancel();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel Order'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      onProceed();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Proceed'),
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
