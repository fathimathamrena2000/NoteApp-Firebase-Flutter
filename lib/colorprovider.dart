import 'package:flutter/material.dart';

class Colorchange with ChangeNotifier {
  final List _listofclrs = [
    Colors.green.shade100,
    Colors.black12,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.red.shade100,
    Colors.purple.shade100,
  ];
  List get listofclrs => _listofclrs;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
