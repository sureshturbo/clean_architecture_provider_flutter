import 'package:flutter/material.dart';

enum AppTab { home, cart, account }

class AppNavigation with ChangeNotifier {
  AppTab _currentTab = AppTab.home;

  AppTab get currentTab => _currentTab;

  void changeTab(AppTab newTab) {
    _currentTab = newTab;
    notifyListeners();
  }
}
