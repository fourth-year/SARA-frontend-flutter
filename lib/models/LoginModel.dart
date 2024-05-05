class LoginModels {
   late User user;
   late String tokenType;
   late String token;




  LoginModels.fromJson(Map<String, dynamic> json){
    user= User.fromJson(json["user"]);
      tokenType= json["TokenType"];
       token= json["Token"];

  }

}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String phone;
  String address;
  String gender;
  String photo;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.address,
    required this.gender,
    required this.photo,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    address: json["address"],
    gender: json["gender"],
    photo: json["photo"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );


}
