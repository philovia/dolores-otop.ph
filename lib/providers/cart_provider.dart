import 'package:flutter/material.dart';
import 'package:otop_front/models/otop_models.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  double get total => cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));

  // Updated addProduct to include supplierId and better logging
  void addProduct(OtopProduct product, int quantity) {
    print('Adding product to cart: '
        'Product ID: ${product.id}, '
        'Supplier ID: ${product.supplierId}, '
        'Name: ${product.name}, '
        'Price: ${product.price}, '
        'Quantity: $quantity');

    if (product.id == 0 || product.supplierId == 0) {
      print('Warning: Invalid product or supplier ID: '
          'Product ID: ${product.id}, Supplier ID: ${product.supplierId}');
    }

    cartItems.add({
      'id': product.id,
      'name': product.name,
      'price': product.price,
      'quantity': quantity,
      'supplierId': product.supplierId, // Include supplierId
    });
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
