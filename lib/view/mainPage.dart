import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authorizationController.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final MainController controller = Get.find();
  final AuthorizationController authorizationController = Get.find();
  final LocaleController localController = Get.find();
  // final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: GetBuilder<MainController>(builder: (controller) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    authorizationController.signOut();
                  },
                  child: Text("sign out".tr)),
              ElevatedButton(
                  onPressed: () {
                    localController.changeLang("en");
                  },
                  child: Text("English".tr)),
              ElevatedButton(
                  onPressed: () {
                    localController.changeLang("tr");
                  },
                  child: Text("Turkish".tr)),
              ElevatedButton(
                  onPressed: () {
                    controller.changeTheme();
                  },
                  child: Text("theme".tr))
            ],
          );
        }));
  }
}
