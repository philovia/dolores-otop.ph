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
    if (product.id <= 0 || product.quantity <= 0) {
      _logWarning(
          'Invalid product or supplier ID. Product: ${product.id}, Supplier: ${product.quantity}');
      return;
    }

    // Check if product already exists in the cart
    final existingProductIndex = _cartItems.indexWhere((item) =>
        item['product_id'] == product.id && item['quantity'] == product.quantity);

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
        'supplier_id': product.supplierId,
      });
      _logInfo('Added Quantity: $quantity, ID: ${product.id}' );
    }
    notifyListeners();
  }

  // Remove a product from the cart
  void removeProduct(int productId, int supplierId) {
    _cartItems.removeWhere(
            (item) => item['id'] == productId && item['supplier_id'] == supplierId);
    _logInfo('Removed product with ID: $productId from the cart');
    notifyListeners();
  }

  // Update the quantity of a specific product
  void updateQuantity(int productId, int supplierId, int quantity) {
    final productIndex = _cartItems.indexWhere(
        (item) => item['id'] == productId && item['supplier_id'] == supplierId);

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
