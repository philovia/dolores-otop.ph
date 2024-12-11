// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:otop_front/models/product.dart';
import 'package:otop_front/services/supplier_product_services.dart';
import 'package:otop_front/widget/supplier_add_product.dart';

class SupplierProductListscreen extends StatefulWidget {
  const SupplierProductListscreen({super.key});

  @override
  _SupplierProductListscreenState createState() => _SupplierProductListscreenState();
}

class _SupplierProductListscreenState extends State<SupplierProductListscreen> {
  final Logger logger = Logger(level: Level.debug);

late Future<Product> _searchedProduct;

  final Set<int> _selectedProductIds = {};

  @override
void initState() {
  super.initState();
  _searchedProduct = Future.error("No search initiated");
}


  void _fetchProductByName(String name) {
  setState(() {
    _searchedProduct = SupplierProductService.getProductByName(name);
  });
}


  void _toggleSelection(int productId) {
    setState(() {
      if (_selectedProductIds.contains(productId)) {
        _selectedProductIds.remove(productId);
      } else {
        _selectedProductIds.add(productId);
      }
    });
  }

  // Future<void> _confirmDeleteDialog() async {
  //   if (_selectedProductIds.isEmpty) {
  //     logger.w("No products selected for deletion.");
  //     return;
  //   }

  //   final confirmed = await showDialog<bool>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Delete Products"),
  //         content:
  //             Text("Are you sure you want to delete the selected products?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(false),
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(true),
  //             child: Text("Confirm"),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (confirmed == true) {
  //     _deleteSelectedProducts();
  //   }
  // }

  // Future<void> _deleteSelectedProducts() async {
  //   for (int productId in _selectedProductIds) {
  //     bool success = await OtopProductServiceAdmin.deleteOtopProduct(productId);
  //     if (!success) {
  //       logger.e("Failed to delete product with ID $productId");
  //     }
  //   }

  //   // Clear selected IDs and refresh the product list
  //   setState(() {
  //     _selectedProductIds.clear();
  //   });
  //   _fetchProducts();
  // }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SupplierAddProductDialog();
      },
    );
  }

void _filterProducts(String query) {
  _fetchProductByName(query);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  hint: Text("Choose action"),
                  items:
                      <String>['Delete', 'Update Product'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value == 'Delete') {
                      // _confirmDeleteDialog();
                    }
                  },
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for a product...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: _filterProducts,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _showAddProductDialog,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Text("+ Add new product"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),

          // Table header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                Expanded(
                    child: Text("Name",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Description",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Category",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Price",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Quantity",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Divider(),

          // Display filtered products
          Expanded(
            child:
            FutureBuilder<Product>(
  future: _searchedProduct,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      logger.e("Error loading product: ${snapshot.error}");
      return Center(
        child: Text("Failed to load product: ${snapshot.error.toString()}"),
      );
    } else if (!snapshot.hasData) {
      return Center(child: Text("Product not found"));
    }

    Product product = snapshot.data!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(product.name)),
              Expanded(child: Text(product.description)),
              Expanded(child: Text(product.category)),
              Expanded(child: Text("₱${product.price}")),
              Expanded(child: Text("${product.quantity}")),
            ],
          ),
          Divider(),
        ],
      ),
    );
  },
)

          ),
        ],
      ),
    );
  }

}
