import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/controllers/home_controller.dart';
import 'package:techie_talk/views/chat_view.dart';
import 'package:techie_talk/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: Get.put(HomeController()),
        builder: (logic) {
          return SafeArea(
            child: Scaffold(
              appBar: customAppBar(title: "Select a room"),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const ChatView(isGeneralDiscussion: false));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/images/tech_talk_logo.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const ChatView(isGeneralDiscussion: true));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/images/general_discussion_logo.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
