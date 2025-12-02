import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;
  bool _isTokenLoaded = false;

  String? get token => _token;
  bool get isTokenLoaded => _isTokenLoaded;

  set token(String? value) {
    _token = value;
    _saveToken(value);
    notifyListeners();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _isTokenLoaded = true;
    notifyListeners();
  }

  Future<void> _saveToken(String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value != null) {
      await prefs.setString('token', value);
    } else {
      await prefs.remove('token');
    }
  }

  Future<void> clearToken() async {
    _token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
