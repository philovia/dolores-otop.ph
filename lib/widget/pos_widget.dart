// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:otop_front/services/solds_products_services.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
import 'package:otop_front/models/otop_models.dart';
import 'package:otop_front/services/otop_product_service.dart';
import 'package:otop_front/providers/cart_provider.dart';
import '../chart_widget/product_cart.dart';

class ProductCheckoutWidget extends StatelessWidget {
  const ProductCheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: const ProductList()),
        const SizedBox(width: 10),
        Expanded(flex: 1, child: const CheckoutSection()),
      ],
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<OtopProduct>> _futureProducts;
  late TextEditingController _searchController;
  List<OtopProduct> _allProducts = [];
  List<OtopProduct> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _futureProducts = OtopProductServiceAdmin.getOtopProducts();
    _futureProducts.then((products) {
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: _filterProducts,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<OtopProduct>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (_filteredProducts.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return ProductCard(
                    product: product,
                    onAdd: (quantity) {
                      Provider.of<CartProvider>(context, listen: false)
                          .addProduct(product, quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} (x$quantity) added!'),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class CheckoutSection extends StatefulWidget {
  const CheckoutSection({super.key});

  @override
  _CheckoutSectionState createState() => _CheckoutSectionState();
}

class _CheckoutSectionState extends State<CheckoutSection> {
  double received = 0.00;
  double change = 0.00;

  void calculateChange(double total) {
    setState(() {
      change = received - total;
    });
  }

  Future<void> completeCheckout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    try {
      for (var item in cartProvider.cartItems) {
        final productId = item['id'] ?? 0;
        final quantitySold = item['quantity'] ?? 0;

        // Debug print to check values
        print('Product ID: $productId, Quantity: $quantitySold');

        if (productId == 0 || quantitySold == 0) {
          throw Exception('Invalid item data');
        }

        await recordSoldItems(productId, quantitySold);
      }

      cartProvider.clearCart();
      setState(() {
        received = 0.00;
        change = 0.00;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout completed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during checkout: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 222, 192),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return Text(
                  '${item['name']} (x${item['quantity']}): ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ),
          const Divider(),
          Text(
            'Total: ₱${cartProvider.total.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: received >= cartProvider.total ? completeCheckout : null,
            child: const Text('Complete Checkout'),
          ),
        ],
      ),
    );
  }
}
