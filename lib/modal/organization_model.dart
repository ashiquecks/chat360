class OrganizationModal {
  String className;
  String objectId;
  DateTime createdAt;
  String userName;
  String phoneNumber;
  String password;
  ProfilePick profilePick;
  String organizationName;
  String gstNumber;
  String buildingNumber;

  OrganizationModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.userName,
    required this.phoneNumber,
    required this.password,
    required this.organizationName,
    required this.gstNumber,
    required this.buildingNumber,
    required this.profilePick,
  });

  factory OrganizationModal.fromJson(Map<String, dynamic> json) =>
      OrganizationModal(
        className: json["className"] ?? "",
        objectId: json["objectId"] ?? "",
        createdAt: DateTime.parse(json["createdAt"].toString() ?? ""),
        userName: json["userName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        password: json["password"] ?? "",
        profilePick: ProfilePick.fromJson(json["profilePick"]),
        organizationName: json["organizationName"],
        gstNumber: json["gstNumber"] ?? "",
        buildingNumber: json["buildingNumber"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "userName": userName,
        "phoneNumber": phoneNumber,
        "password": password,
        "organizationName": organizationName,
        "gstNumber": gstNumber,
        "buildingNumber": buildingNumber,
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
