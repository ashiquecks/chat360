
class CategoryModel {
  String className;
  String objectId;
  String createdAt;
  String categoryName;
  String subCategory;
  String categoryId;

  CategoryModel({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.categoryName,
    required this.categoryId,
    required this.subCategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        className: json["className"] ?? "",
        objectId: json["objectId"] ?? "",
        createdAt: json["createdAt"] ?? "",
        categoryName: json["categoryName"] ?? "",
        categoryId: json['categoryId'] ?? "",
        subCategory: json['subCategory'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "categoryName": categoryName,
        "categoryId": categoryId,
        "subCategory": subCategory,
      };
}
