// import 'package:flutter/material.dart';
// // import 'package:otop_front/widget/pos_widget.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// // import 'pos_widget.dart'; // Import the POSWidget to get cart items

// class CustomContainerReceipts extends StatelessWidget {
//   final List<CartItem> cartItems; // List of items in the cart
//   final int totalStock;            // Total stock
//   final int productCount;          // Total product count
//   final double totalPrice;         // Total price

//   const CustomContainerReceipts({
//     super.key,
//     required this.cartItems,
//     required this.totalStock,
//     required this.productCount,
//     required this.totalPrice,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // get the width of the screen
//     double screenWidth = MediaQuery.of(context).size.width;

//     // set the container width 
//     double containerWidth;
//     if (screenWidth <= 500) {
//       containerWidth = screenWidth * 0.9; // 90% of the screen
//     } else if (screenWidth > 500 && screenWidth <= 1100) {
//       containerWidth = 500; // max width of 500
//     } else {
//       containerWidth = 1100; // use a larger screen width
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 197, 192, 192),
//         title: Center(child: Text('Receipts Form', style: TextStyle(fontSize: 18))),
//       ),
//       body: Center(
//         child: Container(
//           width: containerWidth,
//           height: 550,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3),
//               )
//             ],
//           ),
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Total Products: $productCount', style: TextStyle(fontSize: 16)),
//               Text('Total Stock: $totalStock', style: TextStyle(fontSize: 16)),
//               Text('Total Price: Php${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Generate and show the receipt
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ReceiptWidget(
//                         cartItems: cartItems,
//                         totalAmount: totalPrice,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text('Generate Receipt'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ReceiptWidget remains the same as previously defined
// class ReceiptWidget extends StatelessWidget {
//   final List<CartItem> cartItems;
//   final double totalAmount;

//   const ReceiptWidget({super.key, required this.cartItems, required this.totalAmount});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Receipt'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final cartItem = cartItems[index];
//                   return ListTile(
//                     title: Text(cartItem.product.name),
//                     subtitle: Text(
//                       'Price: Php${cartItem.product.price}, Quantity: ${cartItem.quantity}',
//                     ),
//                     trailing: Text(
//                       'Php${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Text(
//               'Total: Php${totalAmount.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 generateAndPrintReceipt();
//               },
//               child: const Text('Download Receipt'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to generate and download the receipt PDF
//   void generateAndPrintReceipt() {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('Receipt', style: pw.TextStyle(fontSize: 24)),
//             pw.SizedBox(height: 20),
//             pw.ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final cartItem = cartItems[index];
//                 return pw.Container(
//                   padding: const pw.EdgeInsets.symmetric(vertical: 4),
//                   child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text(cartItem.product.name),
//                       pw.Text('Price: Php${cartItem.product.price}'),
//                       pw.Text('Quantity: ${cartItem.quantity}'),
//                       pw.Text('Php${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             pw.SizedBox(height: 20),
//             pw.Text(
//               'Total: Php${totalAmount.toStringAsFixed(2)}',
//               style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );

//     // Download or print the PDF
//     Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save(),
//     );
//   }
// }

// // Example usage
// void main() {
//   runApp(MaterialApp(
//     home: CustomContainerReceipts(
//       cartItems: [], // Replace with your cart items
//       totalStock: 100, // Default values for testing
//       productCount: 5,
//       totalPrice: 1500.0,
//     ),
//   ));
// }
