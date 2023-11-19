class ChatMessageModal {
  String className;
  String objectId;
  String createdAt;
  String message;
  String userId;
  String messageId;
  PhotoMessage photoMessage;

  ChatMessageModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.message,
    required this.userId,
    required this.messageId,
    required this.photoMessage,
  });

  factory ChatMessageModal.fromJson(Map<String, dynamic> json) => ChatMessageModal(
        className: json["className"] ??"",
        objectId: json["objectId"] ??"",
        createdAt: json["createdAt"] ??"",
        message: json["message"] ??"",
        userId: json["userId"] ??"",
        messageId: json["messageId"] ??"",
        photoMessage: json["photo"] !=null? PhotoMessage.fromJson(json["photo"]) : PhotoMessage(type: '', name: '', url: '')
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "message": message,
        "userId": userId,
        "messageId": messageId,
        "photo": photoMessage.toJson(),
      };
}

class PhotoMessage {
  String type;
  String name;
  String url;

  PhotoMessage({
    required this.type,
    required this.name,
    required this.url,
  });

  factory PhotoMessage.fromJson(Map<String, dynamic> json) => PhotoMessage(
        type: json["__type"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "name": name,
        "url": url,
      };
}
