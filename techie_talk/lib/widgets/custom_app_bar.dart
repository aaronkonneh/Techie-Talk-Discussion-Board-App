import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/utils/firebase_service.dart';
import 'package:techie_talk/views/login_view.dart';
import 'package:techie_talk/views/profile_view.dart';

PreferredSizeWidget customAppBar({String? title, bool showHome = false}) {
  var menuItems = {'Profile', 'Logout'};
  if (showHome) {
    menuItems = {'Home', ...menuItems};
  }
  return AppBar(
    title: title != null ? Text(title) : null,
    actions: <Widget>[
      PopupMenuButton<String>(
        onSelected: (value) async {
          if (value == "Home") {
            Get.back();
          }
          if (value == "Profile") {
            Get.to(() => const ProfileView());
          }
          if (value == "Logout") {
            await FirebaseService.auth.signOut();
            Get.offAll(() => const LoginView());
          }
        },
        itemBuilder: (BuildContext context) {
          return menuItems.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ],
  );
}
