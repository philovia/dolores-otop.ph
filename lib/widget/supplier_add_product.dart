// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:otop_front/models/product.dart';
import 'package:otop_front/services/supplier_product_services.dart';

class SupplierAddProductDialog extends StatefulWidget {
  const SupplierAddProductDialog({super.key});

  @override
  _SupplierAddProductDialogState createState() => _SupplierAddProductDialogState();
}

class _SupplierAddProductDialogState extends State<SupplierAddProductDialog> {
  final Logger logger = Logger(level: Level.debug);

  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String description = '';
  String category = '';
  double price = 0.0;
  int quantity = 0;

void _submitProduct() async {
  if (_formKey.currentState!.validate()) {

    Product newProduct = Product(
      id: 0,
      name: productName,
      description: description,
      category: category,
      price: price,
      quantity: quantity,
    );

    bool success = await SupplierProductService.createProduct(newProduct);


    if (mounted) {
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product created successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create product. Please try again.')),
        );
      }
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product'),
      content: SizedBox(
        // Set the width and height for the dialog content
        width: 400,  // Adjust width here
        height: 300, // Adjust height here
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Product Name'),
                  onChanged: (value) => productName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (value) => description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  onChanged: (value) => category = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    if (value != 'Food' && value != 'Non-Food') {
                      return 'Category must be "Food" or "Non-Food"';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => quantity = int.tryParse(value) ?? 0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
                ),

              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close the dialog
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitProduct,
          child: Text('Add Product'),
        ),
      ],
    );
  }
}
