import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/controllers/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SignupController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Full Name",
                ),
                controller: logic.nameController,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                controller: logic.emailController,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                controller: logic.passwordController,
              ),
              const SizedBox(height: 35),
              Obx(() => logic.loading.value
                  ? const LinearProgressIndicator()
                  : ElevatedButton(
                      onPressed: logic.signup,
                      child: const Text("Register"),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
