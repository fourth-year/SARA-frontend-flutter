

class SignupModel {
   late User user;
   late String? tokenType;
   late String? accessToken;

  SignupModel({
    required this.user,
     this.tokenType,
     this.accessToken,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    // user: User.fromJson(json["user"]),
    user:(json['user']!= null? User.fromJson(json['user']):null)!,

    tokenType: json["tokenType"],
    accessToken: json["access_token"],
  );

}

class User {
  late  String? name;
  late String? email;
  late String? phone;
  late String? address;
  late  String? photo;
  late String? gender;
  late DateTime updatedAt;
  late DateTime createdAt;
  late int? id;

  User({
     this.name,
     this.email,
     this.phone,
     this.address,
     this.photo,
     this.gender,
    required this.updatedAt,
    required this.createdAt,
     this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    photo: json["photo"],
    gender: json["gender"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

}
