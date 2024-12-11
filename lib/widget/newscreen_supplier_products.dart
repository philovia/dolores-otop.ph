// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import '../models/supplier_product.dart';
import '../services/product_services.dart';

class NewscreenSupplierProducts extends StatefulWidget {
  const NewscreenSupplierProducts({super.key});

  @override
  _NewscreenSupplierProductsState createState() => _NewscreenSupplierProductsState();
}

class _NewscreenSupplierProductsState extends State<NewscreenSupplierProducts> {
  late Future<List<SupplierProduct>?> _productListFuture;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

 Future<void> _loadProducts() async {
  final supplierId = await getSupplierId();
  if (supplierId != 0) {
    setState(() {
      // Cast the result to Future<List<SupplierProduct>?>
      _productListFuture = ProductServices().getProductsByStore(supplierId) as Future<List<SupplierProduct>?>;
    });
  } else {
    _logger.e('No supplier ID found');
  }
}


  Future<int> getSupplierId() async {
    final prefs = await SharedPreferences.getInstance();
    final supplierId = prefs.getInt('supplierId') ?? 0;
    return supplierId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supplier Products")),
      body: FutureBuilder<List<SupplierProduct>?>(
        future: _productListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found"));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
