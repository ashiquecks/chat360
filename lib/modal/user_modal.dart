class UserModal {
  String className;
  String objectId;
  String createdAt;
  String userName;
  String phoneNumber;
  String password;
  ProfilePick profilePick;
  Map<String, String> categoryTypes;
  String accountType;

  UserModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.userName,
    required this.phoneNumber,
    required this.password,
    required this.profilePick,
    required this.categoryTypes,
    required this.accountType,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        className: json["className"] ?? "",
        objectId: json["objectId"] ?? "",
        createdAt: json["createdAt"] ?? "",
        userName: json["userName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        password: json["password"] ?? "",
        profilePick: ProfilePick.fromJson(json["profilePick"] ?? ""),
        accountType: json["accountType"] ?? "",
        categoryTypes: Map.from(json["categoryTypes"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "password": password,
        "accountType": accountType,
        "profilePick": profilePick.toJson(),
        "categoryTypes": Map.from(categoryTypes)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class ProfilePick {
  String type;
  String name;
  String url;

  ProfilePick({
    required this.type,
    required this.name,
    required this.url,
  });

  factory ProfilePick.fromJson(Map<String, dynamic> json) => ProfilePick(
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
