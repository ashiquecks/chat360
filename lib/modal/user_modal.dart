


class UserModal {
    String className;
    String objectId;
    String createdAt;
    String userName;
    String password;
    String phoneNumber;

    UserModal({
        required this.className,
        required this.objectId,
        required this.createdAt,
        required this.userName,
        required this.password,
        required this.phoneNumber,
    });

    factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: json["createdAt"],
        userName: json["userName"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt,
        "userName": userName,
        "password": password,
        "phoneNumber": phoneNumber,
    };
}