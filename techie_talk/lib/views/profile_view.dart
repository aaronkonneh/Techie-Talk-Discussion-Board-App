import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Profile"),
        ),
        body: GetBuilder<ProfileController>(
            init: Get.put(ProfileController()),
            builder: (logic) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: logic.nameController,
                        decoration: const InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: logic.updateName,
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
