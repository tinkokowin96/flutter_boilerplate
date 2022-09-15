import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocale extends ChangeNotifier {
  static Locale locale = const Locale('en', 'US');

  void changeLocale(String lang, String count) {
    if ('${lang}_$count' != locale.toString()) {
      locale = Locale(lang, count);
      Get.updateLocale(locale);
      notifyListeners();
    }
  }
}
