import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/main.dart';

class LocaleController {
  Locale initLanguage = sharedPreferences!.getString("lang") == null? Get.deviceLocale!: Locale(sharedPreferences!.getString("lang")!);
  

  void changeLang(String lang) {
    Locale locale = Locale(lang);
    sharedPreferences?.setString("lang", lang);
    Get.updateLocale(locale);
  }
}
