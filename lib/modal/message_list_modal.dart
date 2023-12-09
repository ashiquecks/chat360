class MessageListModal {
  String className;
  String objectId;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  String chatTitle;
  Map<String, String> categoryTypes;

  MessageListModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.chatTitle,
    required this.categoryTypes,
  });

  factory MessageListModal.fromJson(Map<String, dynamic> json) =>
      MessageListModal(
        className: json["className"] ??"",
        objectId: json["objectId"] ??"",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"] ??"",
        chatTitle: json["chatTitle"]??"",
        categoryTypes: Map.from(json["categoryTypes"] ??{})
            .map((k, v) => MapEntry<String, String>(k, v))
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "chatTitle": chatTitle,
        "categoryTypes": Map.from(categoryTypes)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
