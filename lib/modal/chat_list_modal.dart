class ChatListModal {
  String message;
  String userId;
  String messageId;

  ChatListModal({
    required this.message,
    required this.userId,
    required this.messageId,
  });

  factory ChatListModal.fromJson(Map<String, dynamic> json) => ChatListModal(
        message: json["message"],
        userId: json["userId"],
        messageId: json["messageId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
        "messageId": messageId,
      };
}
