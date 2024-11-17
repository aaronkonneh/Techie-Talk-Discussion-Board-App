import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/utils/custom_snackbar.dart';
import 'package:techie_talk/utils/firebase_service.dart';
import 'package:techie_talk/views/home_view.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loading = false.obs;

  bool isFormValid() {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (email.isEmpty || !email.isEmail) {
      CustomSnackBar.showCustomErrorToast(message: "Enter a valid email");
      return false;
    }
    if (password.isEmpty || password.length < 6) {
      CustomSnackBar.showCustomErrorToast(message: "Password should be at least 6 characters");
      return false;
    }
    return true;
  }

  void login() async {
    if (!isFormValid()) return;
    loading.value = true;
    try {
      await FirebaseService.auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAll(() => const HomeView());
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'invalid-credential') {
        CustomSnackBar.showCustomErrorToast(message: "Wrong email or password.");
      } else if (e.code == 'invalid-email') {
        CustomSnackBar.showCustomErrorToast(message: "Enter a valid email.");
      }
    }
  }
}
