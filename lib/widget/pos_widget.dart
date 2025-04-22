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
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('${product.name} (x$quantity) added!'),
                      //   ),
                      // );
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
class ProductCard extends StatefulWidget {
  final OtopProduct product;
  final void Function(int quantity) onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 1;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '$_quantity');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _controller.text = '$_quantity';
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _controller.text = '$_quantity';
      }
    });
  }

  void _updateQuantity(String value) {
    setState(() {
      _quantity = int.tryParse(value) ?? 0;
      if (_quantity < 0) _quantity = 0; // Ensure quantity is not negative
      _controller.text = '$_quantity';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name
            Row(
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  widget.product.quantity == 0
                      ? 'Out of Stock'
                      : 'Stocks: (${widget.product.quantity})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: widget.product.quantity == 0 ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 5),
            Text(
              widget.product.id.toString(),
              style: const TextStyle(
                // fontWeight: FontWeight.bol
                fontSize: 13.0,
              ),
            ),
            Text(
              widget.product.description,
              style: const TextStyle(
                // fontWeight: FontWeight.bol
                fontSize: 13.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product Price
                Text(
                  '₱${widget.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Row(
                  children: [
                    // Decrement Button
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove),
                    ),
                    // Quantity Input Field
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: _updateQuantity,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                      ),
                    ),
                    // Increment Button
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                    // Add Button
                    ElevatedButton(
                      onPressed: (_quantity > 0 && widget.product.quantity > 0)
                          ? () {
                        widget.onAdd(_quantity);
                      }
                          : null, // Disable button if quantity is 0 or stock is 0
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
  final TextEditingController customAmountController = TextEditingController();


  void calculateChange(double total) {
    setState(() {
      change = received - total;
    });
  }
  @override
  void dispose() {
    customAmountController.dispose();
    super.dispose();
  }


  Future<void> completeCheckout() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // PRINTING CART ITEMS
    debugPrint("Printing cart items...");
    for (var item in cartProvider.cartItems) {
      debugPrint('Product: ${item['name']}, '
          'ID: ${item['id']}, '
          'Supplier ID: ${item['supplier_id']}, '
          'Quantity: ${item['quantity']}, '
          'Price: ₱${item['price']}, '
          'Subtotal: ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}');
    }
    // PRINTING CART ITEMS
    debugPrint("Printing cart items...");
    debugPrint('CASH RECEIVED: ₱${received.toStringAsFixed(2)}');
    debugPrint('CHANGE: ₱${change.toStringAsFixed(2)}');

    // Print total bill
    debugPrint('TOTAL BILL: ₱${cartProvider.total.toStringAsFixed(2)}');

    try {
      for (var item in cartProvider.cartItems) {
        final productId = item['id'] ?? 0;
        final quantitySold = item['quantity'] ?? 0;

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
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
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
              SizedBox(
                height: 550,
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.cartItems[index];
                    return Card(
                      // color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${item['name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('₱${item['price'].toStringAsFixed(2)} x ${item['quantity']} = ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    final newQty = item['quantity'] - 1;
                                    if (newQty <= 0) {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .removeProduct(item['id'], item['supplier_id']);
                                    } else {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .updateQuantity(item['id'], item['supplier_id'], newQty);
                                    }
                                    setState(() {
                                    received = 0.00;
                                    change = 0.00;
                                    });
                                  },
                                ),
                                Text('${item['quantity']}'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    final newQty = item['quantity'] + 1;
                                    Provider.of<CartProvider>(context, listen: false)
                                        .updateQuantity(item['id'], item['supplier_id'], newQty);
                                    setState(() {
                                      received = 0.00;
                                      change = 0.00;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () {
                                    Provider.of<CartProvider>(context, listen: false)
                                        .removeProduct(item['id'], item['supplier_id']);
                                    setState(() {
                                      received = 0.00;
                                      change = 0.00;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    // return Text(
                    //   '${item['name']} (x${item['quantity']}): ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                    //   style: const TextStyle(fontSize: 16),
                    // );
                  },
                ),
              ),
              const Divider(),
              Text(
                'Total: ₱${cartProvider.total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [100,200, 500, 1000].map((amount) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        received = amount.toDouble();
                        calculateChange(cartProvider.total);
                      });
                    },
                    child: Text('₱$amount'),
                  );
                }).toList(),
              ),
              SizedBox(height: 5),
              TextField(
                controller: customAmountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Enter amount',
                  prefixText: '₱',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final parsed = double.tryParse(value);
                  if (parsed != null) {
                    setState(() {
                      received = parsed;
                      calculateChange(cartProvider.total);
                    });
                  }
                },
              ),
              SizedBox(height: 5),
              Text(
                'Cash Received: ₱${received.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Change: ₱${change.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 5),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: (cartProvider.cartItems.isNotEmpty && received >= cartProvider.total)
                          ? completeCheckout
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (cartProvider.cartItems.isNotEmpty && received >= cartProvider.total)
                            ? Colors.green
                            : Colors.grey,
                      ),
                      child: const Text('Complete Checkout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

