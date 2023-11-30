import 'package:flutter/material.dart';

class Colorchange with ChangeNotifier {
  final List _listofclrs = [
    const Color.fromARGB(255, 154, 228, 156),
    const Color.fromARGB(255, 197, 189, 115),
    const Color.fromARGB(255, 208, 152, 148),
    const Color.fromARGB(255, 135, 188, 232),
    const Color.fromARGB(255, 247, 200, 129),
    const Color.fromARGB(255, 232, 177, 242),
    const Color.fromARGB(255, 170, 163, 163),
    const Color.fromARGB(255, 236, 153, 181)
  ];
  List get listofclrs => _listofclrs;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
