class KeywordsModal {
    String className;
    String objectId;
    String createdAt;
    String updatedAt;
    String keywordName;
    String keywordType;
    String categoryId;
    String categoryName;

    KeywordsModal({
        required this.className,
        required this.objectId,
        required this.createdAt,
        required this.updatedAt,
        required this.keywordName,
        required this.keywordType,
        required this.categoryId,
        required this.categoryName,
    });

    factory KeywordsModal.fromJson(Map<String, dynamic> json) => KeywordsModal(
        className: json["className"] ??"",
        objectId: json["objectId"] ??"",
        createdAt: json["createdAt"].toString() ?? "",
        updatedAt: json["updatedAt"].toString() ??"",
        keywordName: json["keywordName"] ??"",
        keywordType: json["keywordType"] ??"",
        categoryId: json["categoryId"] ??"",
        categoryName: json["categoryName"] ??"",
    );

    Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "keywordName": keywordName,
        "keywordType": keywordType,
        "categoryId": categoryId,
        "categoryName": categoryName,
    };
}