import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int? _supplierId;

  int? get supplierId => _supplierId;

  void setSupplierId(int id) {
    _supplierId = id;
    notifyListeners();
  }
}
