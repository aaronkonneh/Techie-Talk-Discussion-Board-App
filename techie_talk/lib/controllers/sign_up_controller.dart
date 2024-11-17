import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techie_talk/models/user.dart';
import 'package:techie_talk/utils/custom_snackbar.dart';
import 'package:techie_talk/utils/firebase_service.dart';
import 'package:techie_talk/views/home_view.dart';

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loading = false.obs;

  bool isFormValid() {
    var name = nameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    if (name.isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Enter a valid name");
      return false;
    }
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

  void signup() async {
    if (!isFormValid()) return;
    loading.value = true;

    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var name = nameController.text.trim();
    try {
      var credentials = await FirebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = FbUser(
        id: credentials.user!.uid,
        name: name,
        timeWhenCreated: DateTime.now(),
      );
      await FirebaseService.fireStore.collection("users").doc(credentials.user!.uid).set(user.toJson());
      Get.offAll(() => const HomeView());
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'weak-password') {
        CustomSnackBar.showCustomErrorToast(message: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        CustomSnackBar.showCustomErrorToast(message: "An account already exists for that email.");
      } else if (e.code == 'invalid-email') {
        CustomSnackBar.showCustomErrorToast(message: "Enter a valid email.");
      }
    }
  }
}
