import 'package:flutter/cupertino.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authorizationController.dart';

import 'package:get/get.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() =>AuthController(),fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.put<AuthorizationController>(AuthorizationController(),permanent: true);

    // Get.lazyPut(() =>ScrollController());
  }
}
