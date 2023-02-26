import 'package:flutter/cupertino.dart';
import 'package:praktid/Localizations/localeController.dart';
import 'package:praktid/controller/authorizationController.dart';

import 'package:get/get.dart';
import 'package:praktid/controller/mainController.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() =>AuthController(),fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.put<AuthorizationController>(AuthorizationController(),permanent: true);

    // Get.lazyPut(() =>ScrollController());
  }
}
