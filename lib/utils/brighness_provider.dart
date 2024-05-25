import 'package:flutter/material.dart';

enum AppBrightness { light, dark }

class BrightnessProvider with ChangeNotifier {
  AppBrightness _brightness = AppBrightness.light;

  AppBrightness get brightness => _brightness;

  set brightness(AppBrightness value) {
    _brightness = value;
    notifyListeners();
  }
}
