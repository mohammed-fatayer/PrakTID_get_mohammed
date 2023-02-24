import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AuthorizationController extends GetxController {
  String email = "";
  String password = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> _user;

  @override
  void onInit() {
    super.onInit();
    _user = Rx<User?>(auth.currentUser);
    // our user would be notified
    _user.bindStream(auth.userChanges());
    //if user login or logout he will be notified from firebase  using bindStream
    // and function ever  tasks listener and a function and every time change happens ever function will  work
    //notice that firebase auth always follow user current login state
    ever(_user, _initialScreen);
  }

// navigate to login or main page
  void _initialScreen(User? user) {
    if (user != null && user.emailVerified == true) {
      Get.toNamed("/main");
    } else {
      Get.toNamed("/");
    }
  }

  void register(String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      verification(credential);
      print(credential);
      return Get.defaultDialog(
        title: "Verification",
        middleText:
            "Please check your email to Verify your account and then use it to sign in",
        textConfirm: "ok",
        onConfirm: () {
          Get.back();
          Get.toNamed("/");
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return Get.defaultDialog(
          title: "Failed",
          middleText: "The password provided is too weak. ",
          textConfirm: "ok",
          onConfirm: () {
            Get.back();
          },
        );
        ;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return Get.defaultDialog(
          title: "Failed",
          middleText: "The account already exists for that email.",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void verification(UserCredential credential) async {
    try {
      if (credential.user!.emailVerified == false) {
        await credential.user!.sendEmailVerification();
      }
    } catch (e) {
      print("An error occurred while trying to send email  verification");
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      if (credential.user!.emailVerified == true) {
        print(credential);
        Get.toNamed("/main");
      } else {
        return Get.defaultDialog(
          title: "Failed to login",
          middleText:
              "email not verified please check your email and try again",
          textConfirm: "ok",
          textCancel: "send email",
          onCancel: (() {
            verification(credential);
          }),
          onConfirm: () {
            Get.back();
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return Get.defaultDialog(
          title: "Failed",
          middleText: "No user found for that email.",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return Get.defaultDialog(
          title: "Failed",
          middleText: "Wrong email or password ",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }

  void resetPassword(String email) async {
    String textValue = email;
    return Get.defaultDialog(
      title: "reset password",
      textConfirm: "Send email",
      content: TextFormField(
        initialValue: email,
        validator: ((text) => EmailValidator.validate(text!)
            ? null
            : "Please enter a valid email"),
        decoration: const InputDecoration(
            labelText: "enter your email", border: OutlineInputBorder()),
        onChanged: (text) {
          textValue = text;
        },
      ),
      onCancel: () {},
      onConfirm: () async {
        try {
          await auth.sendPasswordResetEmail(email: textValue.trim());
          Get.back();
          return Get.defaultDialog(
            title: "success",
            textCancel: "ok",
            middleText: "email has been send check your email",
            onCancel: () {},
          );
        } catch (e) {
          Get.defaultDialog(
            title: "Failed",
            textCancel: "Ok",
            middleText: "There is no user record for this email",
            onCancel: () {},
          );
        }
      },
    );
  }

  void signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
