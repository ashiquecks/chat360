class AccountCredentialModal {
  String className;
  String objectId;
  String createdAt;
  String userName;
  String phoneNumber;
  String password;
  ProfilePick profilePick;
  String organizationName;
  String gstNumber;
  String buildingNumber;
  Map<String, String> categoryTypes;
  String accountType;
  bool creator;
  bool verified;
  String latLong;
  String address;

  AccountCredentialModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.userName,
    required this.phoneNumber,
    required this.organizationName,
    required this.gstNumber,
    required this.buildingNumber,
    required this.password,
    required this.profilePick,
    required this.categoryTypes,
    required this.accountType,
    required this.creator,
    required this.verified,
    required this.latLong,
    required this.address,
  });

  factory AccountCredentialModal.fromJson(Map<String, dynamic> json) => AccountCredentialModal(
        className: json["className"] ?? "",
        objectId: json["objectId"] ?? "",
        createdAt: json["createdAt"] ?? "",
        userName: json["userName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        profilePick: ProfilePick.fromJson(json["profilePick"]),
        organizationName: json["organizationName"] ?? "",
        gstNumber: json["gstNumber"] ?? "",
        buildingNumber: json["buildingNumber"] ?? "",
        password: json["password"] ?? "",
        creator: json["creator"] ?? false,
        verified: json["verified"] ?? false,
        accountType: json["accountType"] ?? "",
        categoryTypes: Map.from(json["categoryTypes"]).map((k, v) => MapEntry<String, String>(k, v)),
        latLong: json['latLong'] ?? "",
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "organizationName": organizationName,
        "gstNumber": gstNumber,
        "buildingNumber": buildingNumber,
        "password": password,
        "accountType": accountType,
        "creator": creator,
        "verified": verified,
        "profilePick": profilePick.toJson(),
        "categoryTypes": Map.from(categoryTypes).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "latLong": latLong,
        "address": address,
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
