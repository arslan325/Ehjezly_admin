class PatientModel{
  static const userName = "Full Name";
  static const userEmail = "Email";
  static const userId = "userID";
  static const userPassword = "password";
  static const userProfile = "profile";
  String? name;
  String? email;
  String? password;
  String? profile;
  String? uid;
  PatientModel({
    this.name,
    this.email,
    this.profile,
    this.password,
  this.uid
  }
      );
  PatientModel.fromMap(Map<String, dynamic> data){
    name = data[userName];
    email = data[userEmail];
    password = data[userPassword];
    profile = data[userProfile];
    uid = data[userId];
  }
  toJson() {
    return {
      userName:name,
      userEmail:email,
      userProfile:profile
    };
  }
}