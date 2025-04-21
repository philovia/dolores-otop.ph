import 'package:flutter/material.dart';

class SelectedIndexProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify listeners to update UI
  }
}
