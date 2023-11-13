import 'package:flutter/material.dart';

class BottomNavModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<Widget> _children = [
    // const Homepage(),
    // const LinkedAccounts(),
    // const ManageConsent(selectedIndex: 0),
    // const MyProfile()
  ];

  List<Widget> get children => _children;

  updateIndex(int index, context) {
    _currentIndex = index;
    notifyListeners();
  }
}
