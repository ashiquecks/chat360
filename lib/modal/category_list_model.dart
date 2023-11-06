class CategoryListModal {
  String className;
  String objectId;
  DateTime createdAt;
  DateTime updatedAt;
  String categoryName;
  String categoryType;
  String keywordsCount;
  bool status;

  CategoryListModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
    required this.categoryType,
    required this.keywordsCount,
    required this.status,
  });

  factory CategoryListModal.fromJson(Map<String, dynamic> json) =>
      CategoryListModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        categoryName: json["categoryName"],
        categoryType: json["categoryType"],
        keywordsCount: json["keywordsCount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "categoryName": categoryName,
        "categoryType": categoryType,
        "keywordsCount": keywordsCount,
        "status": status,
      };
}
