import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OnSales extends StatefulWidget {
  const OnSales({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnSalesState createState() => _OnSalesState();
}

class _OnSalesState extends State<OnSales> {
  final Logger logger = Logger(); // Logger instance

  List<Product> foodProducts = [];
  List<Product> nonFoodProducts = [];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('On Sales', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ],
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Food Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildProductTable(foodProducts, 'Food', context),
                  _addProductRow(foodProducts),
                  const SizedBox(height: 20),
                  const Text(
                    'Non-Food Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildProductTable(nonFoodProducts, 'Non-Food', context),
                  _addProductRow(nonFoodProducts),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductTable(List<Product> products, String category, BuildContext context) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Colors.grey),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            for (var product in products) _buildProductRow(product, products),
          ],
        ),
      ],
    );
  }

  TableRow _buildProductRow(Product product, List<Product> products) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product.name),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(product.price.toStringAsFixed(2)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              _saveProduct(product);
            },
            child: const Text('Save'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                products.remove(product);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _addProductRow(List<Product> products) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Product Name'),
          ),
        ),
        Expanded(
          child: TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              products.add(Product(
                name: nameController.text,
                price: double.parse(priceController.text),
              ));

              nameController.clear();
              priceController.clear();
            });
          },
          child: const Text('Add Product'),
        ),
      ],
    );
  }

  void _saveProduct(Product product) {
    // Use the logger to log the saved product
    logger.i("Saved: ${product.name} with price ${product.price}");
  }

  void _showDailyProducts(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Products Sold on ${selectedDate.toLocal()}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // List the products sold on the selected date here
              const Text('List of products sold on selected date'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showDailyProducts(context);
          }
        });
      }
    }
  }
}

class Product {
  String name;
  double price;

  Product({ required this.name, required this.price});
}

void main() {
  runApp(const MaterialApp(
    home: OnSales(),
  ));
}
