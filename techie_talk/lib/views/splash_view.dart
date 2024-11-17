import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Image.asset(
      "assets/images/splash_screen.jpg",
      fit: BoxFit.cover,
    );
  }
}
