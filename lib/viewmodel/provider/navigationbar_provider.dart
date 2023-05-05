import 'package:flutter/material.dart';

class NavigationBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;

  set getSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
