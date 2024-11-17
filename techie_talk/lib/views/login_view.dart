import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/controllers/login_controller.dart';
import 'package:techie_talk/views/sign_up_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginController());
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
                      onPressed: logic.login,
                      child: const Text("Login"),
                    )),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SignUpView());
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.blue.shade700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
