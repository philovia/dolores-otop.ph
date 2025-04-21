import 'package:flutter/material.dart';

class SupplierList extends StatelessWidget {
  const SupplierList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ALL SUPPLIERS', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1700),
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int columns;
                if (constraints.maxWidth > 1000) {
                  columns = 5;
                } else if (constraints.maxWidth > 500) {
                  columns = 4;
                } else {
                  columns = 3;
                }
                
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: 0.75, // Adjust height vs width ratio
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8, // Change this based on your supplier data
                  itemBuilder: (context, index) {
                    return _buildSupplierCard(context, 'Supplier ${index + 1}');
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupplierCard(BuildContext context, String supplier) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 50), // Person icon
            const SizedBox(height: 10),
            Text(supplier, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showProductForm(context, supplier); // Show supplier products form
              },
              child: const Text('See Details'),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductForm(BuildContext context, String supplier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Products of $supplier'),
          content: Text('Total Product: 10'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Order'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SupplierList(),
  ));
}
