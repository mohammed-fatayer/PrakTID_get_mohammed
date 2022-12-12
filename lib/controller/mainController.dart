import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/main.dart';
import 'package:praktid_flutter/theme/theme.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void changeTheme() {
    
    if (Get.isDarkMode) {
      sharedPreferences!.setBool("theme", false);
      Get.changeTheme(Themes.customLightTheme);
    } else {
      sharedPreferences!.setBool("theme", true);
      Get.changeTheme(Themes.customDarkTheme);
    }
  }
}
