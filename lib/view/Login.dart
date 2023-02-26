import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:praktid/controller/authorizationController.dart';
import 'package:praktid/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:praktid/view/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthorizationController authorizationController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("Login".tr),
        ),
        body: GetBuilder<AuthorizationController>(builder: (controller) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const FlutterLogo(
                    size: 40,
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Email'.tr,
                          ),
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email".tr,
                          onSaved: (value) {
                            if (value != null) {
                              controller.email = value;
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Password'.tr,
                          ),
                          onSaved: (value) {
                            if (value != null) {
                              controller.password = value;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child:  Text('Sign in'.tr),
                      onPressed: () {
                        var formData = _formKey.currentState;
                        if (formData != null && formData.validate()) {
                          formData.save();
                          controller.login(
                              controller.email, controller.password);
                        }
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offNamed("/Register");
                      },
                      child: Text(
                        'Sign Up'.tr,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    TextButton(
                      onPressed: () {
                        var formData = _formKey.currentState;
                        if (formData != null && formData.validate()) {
                          formData.save();
                        }
                        controller.resetPassword(controller.email);
                      },
                      child: Text(
                        'Forgot Password?'.tr,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}