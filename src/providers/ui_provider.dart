import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  final PageController _controller = PageController();

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    _controller.animateToPage(i, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get controller => _controller;
}
