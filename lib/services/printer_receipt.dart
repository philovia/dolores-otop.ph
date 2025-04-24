// // import 'package:esc_pos_utils/esc_pos_utils.dart';
// // import 'package:usb_esc_pos_printer/usb_esc_pos_printer.dart';
// //
// // Future<void> printReceipt(List<Map<String, dynamic>> cartItems, double received, double change, double total) async {
// //   final profile = await CapabilityProfile.load();
// //   final generator = Generator(PaperSize.mm58, profile);
// //   final bytes = <int>[];
// //
// //   bytes += generator.text('OTOP.PH Receipt',
// //       styles: PosStyles(align: PosAlign.center, bold: true, height: PosTextSize.size2));
// //   bytes += generator.hr();
// //
// //   for (final item in cartItems) {
// //     bytes += generator.text('${item['name']}');
// //     bytes += generator.text(
// //         '${item['quantity']} x ₱${item['price']} = ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}');
// //   }
// //
// //   bytes += generator.hr();
// //   bytes += generator.text('Total: ₱${total.toStringAsFixed(2)}', styles: PosStyles(bold: true));
// //   bytes += generator.text('Cash: ₱${received.toStringAsFixed(2)}');
// //   bytes += generator.text('Change: ₱${change.toStringAsFixed(2)}');
// //
// //   bytes += generator.feed(2);
// //   bytes += generator.cut();
// //
// //   final printer = UsbEscPosPrinter();
// //   final result = await printer.connect(
// //     vendorId: YOUR_VENDOR_ID,  // Replace with your printer's USB Vendor ID
// //     productId: YOUR_PRODUCT_ID, // Replace with your printer's Product ID
// //   );
// //
// //   if (result != null && result) {
// //     await printer.write(bytes);
// //     await printer.disconnect();
// //   } else {
// //     debugPrint('Printer connection failed');
// //   }
// // }
//
//
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/cart_provider.dart';
//
// BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//
// void printReceiptBluetooth(BuildContext context) async {
//   final cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//   List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
//   if (devices.isEmpty) {
//     debugPrint("No bonded devices found.");
//     return;
//   }
//
//   // Connect to the first bonded printer
//   bluetooth.connect(devices[0]);
//
//   bluetooth.isConnected.then((isConnected) {
//     if (isConnected!) {
//       bluetooth.printNewLine();
//       bluetooth.printCustom("OTOP.PH POS RECEIPT", 3, 1);
//       bluetooth.printNewLine();
//
//       for (var item in cartProvider.cartItems) {
//         bluetooth.printCustom(
//             "${item['name']} x${item['quantity']} = ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}",
//             1, 0);
//       }
//
//       bluetooth.printNewLine();
//       bluetooth.printCustom("TOTAL: ₱${cartProvider.total.toStringAsFixed(2)}", 2, 0);
//       bluetooth.printCustom("RECEIVED: ₱${received.toStringAsFixed(2)}", 1, 0);
//       bluetooth.printCustom("CHANGE: ₱${change.toStringAsFixed(2)}", 1, 0);
//       bluetooth.printNewLine();
//       bluetooth.printCustom("Thank you!", 2, 1);
//       bluetooth.printNewLine();
//       bluetooth.paperCut(); // optional
//     }
//   });
// }
