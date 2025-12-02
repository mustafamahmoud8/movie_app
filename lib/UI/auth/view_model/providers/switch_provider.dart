import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_prefs.dart';

class SwitchProvider with ChangeNotifier {
  bool isActive = false;

  SwitchProvider() {
    loadSwitchState();
  }

  void toggleSwitch(bool value) {
    isActive = value;
    AppPrefs.localizationSetBool('switchState', isActive);
    notifyListeners();
  }

  void loadSwitchState() async {
    final savedValue = AppPrefs.localizationGetBool('switchState');
    isActive = savedValue ?? false;
    notifyListeners();
  }
}
