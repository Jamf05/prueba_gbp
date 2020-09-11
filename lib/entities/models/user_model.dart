class UserModel {
    String userId = "";
    String name = "";
    String surname  = "";
    String email = "";
    String password = "";
    String token = "";
    bool confirmed = false;
    bool hasAccess = false;

    UserModel({
      this.userId = "",
      this.name = "",
      this.surname = "",
      this.email = "",
      this.token = "",
      this.password = "",
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["id"],
        token: json["token"],
        name: json["name"],
        surname: json["surname"],
        email: json["correo"],
    );

    Map<String, dynamic> toJson() => {
      "id"            : userId,
      "name"          : name,
      "surname"       : surname,
      "correo"        : email,
    };
}
