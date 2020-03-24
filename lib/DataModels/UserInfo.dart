class UserInfo {
  // String uid;
  String name;
  String email;
  // String username;
  // String bio;
  String ppID;

  UserInfo(this.name, this.email, this.ppID);

  Map<String, dynamic> toJson() => {
        // '"uid"': '"$uid"',
        '"name"': '"$name"',
        '"email"': '"$email"',
        // '"username"': '"$username"',
        // '"bio"': '"$bio"',
        '"ppID"': '"$ppID"',
      };

  UserInfo.fromJson(Map<String, dynamic> json)
      : //uid = json["uid"],
        name = json["name"],
        email = json["email"],
        // username = json["username"],
        // bio = json["bio"],
        ppID = json["ppID"];
}
