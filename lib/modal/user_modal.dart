
class UserModal {
    String className;
    String objectId;
    DateTime createdAt;
    String userName;
    String phoneNumber;
    String password;

    UserModal({
        required this.className,
        required this.objectId,
        required this.createdAt,
        required this.userName,
        required this.phoneNumber,
        required this.password,
    });

    factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "userName": userName,
        "phoneNumber": phoneNumber,
        "password": password,
    };
}