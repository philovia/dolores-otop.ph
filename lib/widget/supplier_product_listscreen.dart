import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:otop_front/models/product.dart';
import 'package:otop_front/widget/supplier_add_product.dart';

import '../services/myproducts_supplier_service.dart';

class SupplierProductListscreen extends StatefulWidget {
  const SupplierProductListscreen({super.key});

  @override
  _SupplierProductListscreenState createState() =>
      _SupplierProductListscreenState();
}

class _SupplierProductListscreenState extends State<SupplierProductListscreen> {
  final Logger logger = Logger(level: Level.debug);
  late Future<List<Product>> _productsFuture;
  final Set<int> _selectedProductIds = {};

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    setState(() {
      _productsFuture = MyproductsSupplierService().getMyProducts();
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

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SupplierAddProductDialog();
      },
    );
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
                Row(
                  children: [
                    SizedBox(
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for a product...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _showAddProductDialog,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 121, 26)),
                      child: const Text("+ Add new product"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),

          // Table header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: const [
                Checkbox(value: false, onChanged: null),
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
          const Divider(),

          // Product list
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  logger.e("Error loading products: ${snapshot.error}");
                  return Center(
                    child: Text(
                      "Failed to load products: ${snapshot.error}",
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products found."));
                }

                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _selectedProductIds.contains(product.id),
                                onChanged: (_) {
                                  _toggleSelection(product.id);
                                },
                              ),
                              Expanded(child: Text(product.name)),
                              Expanded(child: Text(product.description)),
                              Expanded(child: Text(product.category)),
                              Expanded(
                                  child: Text("₱${product.price.toString()}")),
                              Expanded(
                                  child: Text(product.quantity.toString())),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
