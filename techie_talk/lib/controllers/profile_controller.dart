import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techie_talk/models/user.dart';
import 'package:techie_talk/utils/custom_snackbar.dart';
import 'package:techie_talk/utils/firebase_service.dart';

class ProfileController extends GetxController {
  late FbUser currentUser;
  var nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    var id = FirebaseService.auth.currentUser!.uid;
    var res = await FirebaseService.fireStore.collection("users").doc(id).get();
    currentUser = FbUser.fromJson(res.id, res.data());
    nameController.text = currentUser.name;
  }

  void updateName() async {
    var name = nameController.text.trim();
    if (name.isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Enter a valid name");
      return;
    }
    var id = FirebaseService.auth.currentUser!.uid;
    FirebaseService.fireStore.collection("users").doc(id).update({'name': name});
    Get.back();
    CustomSnackBar.showCustomToast(message: "Name updated");
  }
}
