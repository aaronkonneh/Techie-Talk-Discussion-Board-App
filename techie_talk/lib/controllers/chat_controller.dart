import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:techie_talk/models/chat_message.dart';
import 'package:techie_talk/models/user.dart';
import 'package:techie_talk/utils/firebase_service.dart';

class ChatController extends GetxController {
  var messageTextController = TextEditingController();
  var messages = <ChatMessage>[];
  StreamSubscription? subscription;
  final listController = ScrollController();
  var users = <FbUser>[];
  var loading = true;
  final bool isGeneralDiscussion;

  ChatController(this.isGeneralDiscussion);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    var res = await FirebaseService.fireStore.collection("users").get();
    users = res.docs.map<FbUser>((e) => FbUser.fromJson(e.id, e.data())).toList();
    loading = false;
    update();

    subscription ??= FirebaseService.fireStore
        .collection("chat")
        .where("isGeneralDiscussion", isEqualTo: isGeneralDiscussion)
        .orderBy("time")
        .snapshots()
        .listen((value) {
      messages = value.docs.map<ChatMessage>((e) => ChatMessage.fromJson(e.id, e.data())).toList();
      update();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        listController.jumpTo(listController.position.maxScrollExtent);
      });
    });
  }

  void sendMessage() {
    var messageText = messageTextController.text.trim();
    if (messageText.isEmpty) return;
    messageTextController.clear();
    var message = ChatMessage(
      senderId: FirebaseService.auth.currentUser!.uid,
      time: DateTime.now(),
      message: messageText,
      isGeneralDiscussion: isGeneralDiscussion,
    );
    FirebaseService.fireStore.collection("chat").add(message.toJson());
  }

  @override
  void onClose() {
    subscription?.cancel();
    subscription = null;
  }
}
