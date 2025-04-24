// providers/receipt_provider.dart
import 'package:flutter/material.dart';

import '../models/receipt_model.dart';
// import '../models/receipt.dart';

class ReceiptProvider with ChangeNotifier {
  final List<Receipt> _receipts = [];

  List<Receipt> get receipts => _receipts;

  void addReceipt(Receipt receipt) {
    _receipts.add(receipt);
    notifyListeners();
  }
}
