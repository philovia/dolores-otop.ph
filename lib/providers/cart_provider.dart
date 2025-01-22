import 'package:flutter/material.dart';
import 'package:otop_front/models/otop_models.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  // Get total price of all items in the cart
  double get total => _cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));

  // Expose cart items as an unmodifiable list
  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  // Add product to the cart or update quantity if it already exists
  void addProduct(OtopProduct product, int quantity) {
    if (product.id <= 0 || product.supplierId <= 0) {
      _logWarning(
          'Invalid product or supplier ID. Product: ${product.id}, Supplier: ${product.supplierId}');
      return;
    }

    // Check if product already exists in the cart
    final existingProductIndex = _cartItems.indexWhere((item) =>
        item['id'] == product.id && item['supplierId'] == product.supplierId);

    if (existingProductIndex != -1) {
      // Update quantity of the existing product
      _cartItems[existingProductIndex]['quantity'] += quantity;
      _logInfo(
          'Updated quantity for Product ID: ${product.id}, New Quantity: ${_cartItems[existingProductIndex]['quantity']}');
    } else {
      // Add new product to the cart
      _cartItems.add({
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'quantity': quantity,
        'supplierId': product.supplierId,
      });
      _logInfo('Added product to cart: ${product.name}, Quantity: $quantity');
    }
    notifyListeners();
  }

  // Remove a product from the cart
  void removeProduct(int productId, int supplierId) {
    _cartItems.removeWhere(
        (item) => item['id'] == productId && item['supplierId'] == supplierId);
    _logInfo('Removed product with ID: $productId from the cart');
    notifyListeners();
  }

  // Update the quantity of a specific product
  void updateQuantity(int productId, int supplierId, int quantity) {
    final productIndex = _cartItems.indexWhere(
        (item) => item['id'] == productId && item['supplierId'] == supplierId);

    if (productIndex != -1) {
      if (quantity <= 0) {
        // Remove product if quantity is zero or less
        removeProduct(productId, supplierId);
      } else {
        // Update quantity
        _cartItems[productIndex]['quantity'] = quantity;
        _logInfo(
            'Updated quantity for Product ID: $productId, New Quantity: $quantity');
        notifyListeners();
      }
    } else {
      _logWarning(
          'Attempted to update quantity for non-existent Product ID: $productId');
    }
  }

  // Clear all items from the cart
  void clearCart() {
    _cartItems.clear();
    _logInfo('Cart cleared');
    notifyListeners();
  }

  // Logging methods (replace with your logging framework if available)
  void _logInfo(String message) {
    debugPrint('INFO: $message'); // Replaced with debugPrint
  }

  void _logWarning(String message) {
    debugPrint('WARNING: $message'); // Replaced with debugPrint
  }
}
