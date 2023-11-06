class UserModal {
  String className;
  String objectId;
  DateTime createdAt;
  String userName;
  String phoneNumber;
  String password;
  ProfilePick profilePick;

  UserModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.userName,
    required this.phoneNumber,
    required this.password,
    required this.profilePick,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        profilePick: ProfilePick.fromJson(json["profilePick"]),
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "userName": userName,
        "phoneNumber": phoneNumber,
        "password": password,
        "profilePick": profilePick.toJson(),
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
