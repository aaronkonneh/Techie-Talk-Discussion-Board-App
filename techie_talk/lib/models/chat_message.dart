class ChatMessage {
  String? key;
  String senderId;
  DateTime time;
  bool isGeneralDiscussion;
  String message;

  ChatMessage({
    this.key,
    required this.senderId,
    required this.time,
    this.isGeneralDiscussion = true,
    required this.message,
  });

  static ChatMessage fromJson(key, value) => ChatMessage(
        key: key,
        senderId: value['senderId'],
        time: value['time'].toDate(),
        isGeneralDiscussion: value['isGeneralDiscussion'],
        message: value['message'],
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "time": time,
        "isGeneralDiscussion": isGeneralDiscussion,
        "message": message,
      };
}
