import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techie_talk/controllers/chat_controller.dart';
import 'package:techie_talk/widgets/custom_app_bar.dart';
import 'package:techie_talk/widgets/item_chat_message.dart';

class ChatView extends StatelessWidget {
  final bool isGeneralDiscussion;

  const ChatView({super.key, required this.isGeneralDiscussion});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          title: isGeneralDiscussion ? "General Discussion" : "Tech Talk",
          showHome: true,
        ),
        body: GetBuilder<ChatController>(
            init: Get.put(ChatController(isGeneralDiscussion)),
            builder: (logic) => logic.loading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: logic.listController,
                          itemBuilder: (_, i) {
                            var message = logic.messages[i];
                            var userName = logic.users.firstWhere((e) => e.id == message.senderId).name;
                            var nameLetters = getNameLettersForName(userName);
                            return ItemChatMessage(
                              message: logic.messages[i],
                              userName: userName,
                              nameLetters: nameLetters,
                            );
                          },
                          itemCount: logic.messages.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: logic.messageTextController,
                          decoration: InputDecoration(
                            hintText: "Enter message here",
                            hintStyle: const TextStyle(color: Colors.grey),
                            isDense: true,
                            enabledBorder: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: logic.sendMessage,
                              icon: const Icon(Icons.send),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

  String getNameLettersForName(String name) {
    var words = name.split(" ");
    var letters = words[0].split("")[0];
    if (words.length > 1) {
      letters = "$letters${words[1].split("")[0]}";
    }
    return letters;
  }
}
