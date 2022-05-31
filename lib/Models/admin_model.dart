class AdminModel{
  static const admName = "name";
  static const admEmail = "email";
  static const admPassword = "password";
  static const admProfile = "profile";
  static const admToken = "Token";
  String? name;
  String? email;
  String? password;
  String? profile;
  String? token;
  AdminModel({
    this.name,
    this.email,
    this.profile,
    this.password,
    this.token,
  }
      );
  AdminModel.fromMap(Map<String, dynamic> data){
    name = data[admName];
    email = data[admEmail];
    password = data[admPassword];
    profile = data[admProfile];
    token = data[admToken];
  }
  toJson() {
    return {
      admName:name,
      admEmail:email,
      admPassword:password,
      admProfile:profile
    };
  }
}