
class MessageModal {
    String className;
    String objectId;
    DateTime createdAt;
    DateTime updatedAt;
    String message;
    String userId;
    String messageId;

    MessageModal({
        required this.className,
        required this.objectId,
        required this.createdAt,
        required this.updatedAt,
        required this.message,
        required this.userId,
        required this.messageId,
    });

    factory MessageModal.fromJson(Map<String, dynamic> json) => MessageModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        message: json["message"],
        userId: json["userId"],
        messageId: json["messageId"],
    );

    Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "message": message,
        "userId": userId,
        "messageId": messageId,
    };
}
