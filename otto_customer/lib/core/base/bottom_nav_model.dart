import 'package:flutter/material.dart';
import 'package:otto_customer/modules/dashboard/homepage/homepage.dart';

class BottomNavModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<Widget> _children = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  List<Widget> get children => _children;

  updateIndex(int index, context) {
    _currentIndex = index;
    notifyListeners();
  }
}
