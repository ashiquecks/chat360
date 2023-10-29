class ChatMessageModal {
  String className;
  String objectId;
  String createdAt;
  String message;
  String userId;
  String messageId;

  ChatMessageModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.message,
    required this.userId,
    required this.messageId,
  });

  factory ChatMessageModal.fromJson(Map<String, dynamic> json) =>
      ChatMessageModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: json["createdAt"],
        message: json["message"],
        userId: json["userId"],
        messageId: json["messageId"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "message": message,
        "userId": userId,
        "messageId": messageId,
      };
}
