//   import 'package:flutter/material.dart';
// // import 'package:otop_front/widget/payment_receipts.dart';
//   import 'pos_widget.dart';  

//   // CartDialog Widget
// class CartDialog extends StatelessWidget {
//   final List<CartItem> cart;  // List of items in the cart
//   final double totalPrice;    // Total price of the cart

//   const CartDialog({super.key, required this.cart, required this.totalPrice});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 16,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // Makes the dialog wrap the content size
//           children: [
//             // Dialog Title
//             Text(
//               'Your Cart',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16.0),

//             // List of Cart Items
//             Flexible(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: cart.length,
//                 itemBuilder: (context, index) {
//                   final cartItem = cart[index];
//                   return ListTile(
//                     title: Text(cartItem.product.name),
//                     subtitle: Text('Quantity: ${cartItem.quantity}'),
//                     trailing: Text(
//                       'Php${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
//                     ),
//                   );
//                 },
//               ),
//             ),

//             SizedBox(height: 16.0),

//             // Total Price
//             Text(
//               'Total: Php${totalPrice.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 16.0),

//             // Proceed to Payment Button
//             ElevatedButton(
//               onPressed: () {
//                 // Calculate total number of stocks and number of products
//                 // int totalStock = cart.fold(0, (sum, item) => sum + item.quantity);
//                 // int productCount = cart.length;

//                 // Navigate to ReceiptScreen
//                 // Navigator.of(context).push(
//                   // MaterialPageRoute(
//                   //   builder: (context) => ReceiptWidget(
//                   //     cartItems: cart,  // Pass cart items here
//                   //     totalAmount: totalPrice,  // Pass total price
//                   //   ),
//                   // ),
//                 // );
//               },
//               child: Text('Proceed to Pay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }