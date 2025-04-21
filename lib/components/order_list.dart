import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'ALL ORDERS',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1700), // Limit max width
          padding: const EdgeInsets.all(14), // Outer padding
          color: Colors.white, // Light gray background for the page
          child: Container(
            padding:
                const EdgeInsets.all(14), // Padding inside the white container
            decoration: BoxDecoration(
              color: Colors.white, // White background inside the container
              borderRadius:
                  BorderRadius.circular(10), // Rounded corners for container
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Light shadow effect
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        _buildSupplierRow(context, 'Cahier Order', 'Cahier',
                            'Food', Colors.orange),
                        _buildSupplierRow(context, 'Cahier', 'Cahier',
                            'Non-food', Colors.blueGrey),
                        _buildSupplierRow(context, 'Cahier', 'Cahier',
                            'Non-food', Colors.blueGrey),
                        _buildSupplierRow(
                            context, 'Cahier', 'Cahier', 'Food', Colors.orange),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Text('Cahier',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: Text('Stocks',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 1,
              child: Text('Category',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 1, child: SizedBox()), // For alignment of the order button
        ],
      ),
    );
  }

  Widget _buildSupplierRow(BuildContext context, String supplier, String file,
      String category, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 10),
                Text(supplier),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(file),
          ),
          Expanded(
            flex: 1,
            child: Text(category),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                _showOrderDialog(context, supplier);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the dialog when "Order" is clicked
  void _showOrderDialog(BuildContext context, String supplier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Contact Cashier?'),
          content: Text('Do you want to contact $supplier?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle "Yes" action, e.g., navigate or contact supplier logic
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: OrderList(),
  ));
}
