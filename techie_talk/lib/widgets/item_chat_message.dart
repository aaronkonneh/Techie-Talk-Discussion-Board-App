import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techie_talk/models/chat_message.dart';
import 'package:techie_talk/utils/firebase_service.dart';

class ItemChatMessage extends StatelessWidget {
  final bool isSent;
  final ChatMessage message;
  final String userName;
  final String nameLetters;

  ItemChatMessage({
    super.key,
    required this.message,
    required this.userName,
    required this.nameLetters,
  }) : isSent = FirebaseService.auth.currentUser!.uid == message.senderId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
        right: isSent ? 15 : 35,
        left: isSent ? 35 : 15,
      ),
      decoration: BoxDecoration(
        color: isSent ? Colors.blue.shade100 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(nameLetters),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: Get.textTheme.titleSmall,
                    ),
                    Text(
                      DateFormat("hh:mm a, dd MMM yyyy").format(message.time),
                      style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  message.message,
                  textAlign: TextAlign.start,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
