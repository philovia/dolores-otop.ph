// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:usb_esc_pos_printer/usb_esc_pos_printer.dart';
//
// Future<void> printReceipt(List<Map<String, dynamic>> cartItems, double received, double change, double total) async {
//   final profile = await CapabilityProfile.load();
//   final generator = Generator(PaperSize.mm58, profile);
//   final bytes = <int>[];
//
//   bytes += generator.text('OTOP.PH Receipt',
//       styles: PosStyles(align: PosAlign.center, bold: true, height: PosTextSize.size2));
//   bytes += generator.hr();
//
//   for (final item in cartItems) {
//     bytes += generator.text('${item['name']}');
//     bytes += generator.text(
//         '${item['quantity']} x ₱${item['price']} = ₱${(item['price'] * item['quantity']).toStringAsFixed(2)}');
//   }
//
//   bytes += generator.hr();
//   bytes += generator.text('Total: ₱${total.toStringAsFixed(2)}', styles: PosStyles(bold: true));
//   bytes += generator.text('Cash: ₱${received.toStringAsFixed(2)}');
//   bytes += generator.text('Change: ₱${change.toStringAsFixed(2)}');
//
//   bytes += generator.feed(2);
//   bytes += generator.cut();
//
//   final printer = UsbEscPosPrinter();
//   final result = await printer.connect(
//     vendorId: YOUR_VENDOR_ID,  // Replace with your printer's USB Vendor ID
//     productId: YOUR_PRODUCT_ID, // Replace with your printer's Product ID
//   );
//
//   if (result != null && result) {
//     await printer.write(bytes);
//     await printer.disconnect();
//   } else {
//     debugPrint('Printer connection failed');
//   }
// }
