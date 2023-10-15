class ChatMessageModal {
  String className;
  String objectId;
  String createdAt;
  String chatMessage;
  String userId;

  ChatMessageModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.chatMessage,
    required this.userId,
  });

  factory ChatMessageModal.fromJson(Map<String, dynamic> json) =>
      ChatMessageModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: json["createdAt"],
        chatMessage: json["chatMessage"],
        userId: json["userID"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "chatMessage": chatMessage,
        "userID": userId,
      };
}
