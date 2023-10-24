class ChatMessageModal {
  String className;
  String objectId;
  String createdAt;

  ChatMessageModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
  });

  factory ChatMessageModal.fromJson(Map<String, dynamic> json) => ChatMessageModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
      };
}
