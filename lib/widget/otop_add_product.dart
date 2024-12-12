import 'package:flutter/material.dart';
import 'package:otop_front/models/otop_models.dart';
import 'package:otop_front/services/otop_product_service.dart';
import 'package:logger/logger.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final Logger logger = Logger(level: Level.debug);
  final _formKey = GlobalKey<FormState>();

  String? productName;
  String? description;
  String? category;
  String? storeName;
  double price = 0.0;
  int quantity = 0;

  void _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        int supplierId = 1; // Replace with actual supplier ID logic
        int maxSequentialNumber =
            100; // Replace with logic to fetch the current max number
        String sequentialNumber =
            OtopProduct.generateSequentialNumber(maxSequentialNumber);

        OtopProduct newProduct = OtopProduct(
          id: 0,
          name: productName!,
          description: description!,
          category: OtopProduct.validateCategory(category!),
          price: price,
          quantity: quantity,
          supplierId: supplierId,
          storeName: storeName!,
          sequentialNumber: sequentialNumber,
        );

        logger.d('Submitting product: ${newProduct.toJson()}');
        bool success =
            await OtopProductServiceAdmin.createOtopProduct(newProduct);

        if (success) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product created successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to create product. Please try again.')),
          );
        }
      } catch (e) {
        logger.e('Error submitting product: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Store Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => storeName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a store name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => productName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => category = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
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
          onPressed: () => Navigator.of(context).pop(),
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
