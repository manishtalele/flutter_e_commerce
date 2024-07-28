// user_provider.dart
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _userLogged = false;

  bool get userLogged => _userLogged;

  void setUserLogged(bool value) {
    _userLogged = value;
    notifyListeners();
  }
}
