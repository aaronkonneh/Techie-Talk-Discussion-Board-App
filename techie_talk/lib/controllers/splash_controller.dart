import 'package:get/get.dart';
import 'package:techie_talk/utils/firebase_service.dart';
import 'package:techie_talk/views/home_view.dart';
import 'package:techie_talk/views/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      Get.off(() => FirebaseService.auth.currentUser == null ? const LoginView() : const HomeView());
    });
  }
}
