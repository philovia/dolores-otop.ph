// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'pos_widget.dart'; // Import the POSWidget to get cart items

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
