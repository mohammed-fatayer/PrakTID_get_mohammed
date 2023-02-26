import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid/Localizations/local.dart';
import 'package:praktid/Localizations/localeController.dart';
import 'package:praktid/controller/authorizationController.dart';
import 'package:praktid/theme/theme.dart';

import 'package:praktid/view/login.dart';
import 'package:praktid/view/mainPage.dart';
import 'package:praktid/view/register.dart';
import 'package:praktid/utils/myBindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:praktid/view/login.dart';
import 'package:flutter/material.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    bool? theme = sharedPreferences!.getBool("theme");
    return GetMaterialApp(
        title: 'PrakTID',
        locale: controller.initLanguage,
        fallbackLocale:const Locale("en"),
        translations: MyLocale(),
        initialBinding: MyBinding(),
        theme: theme == true ? Themes.customDarkTheme : Themes.customLightTheme,
        initialRoute: "/",
        getPages: [
          GetPage(
            name: "/",
            page: () => LoginPage(),
          ),
          GetPage(
            name: "/Register",
            page: () => RegisterPage(),
          ),
          GetPage(
            name: "/main",
            page: () => MainPage(),
          ),
        ]);
  }
}
