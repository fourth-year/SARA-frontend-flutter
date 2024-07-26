class AllCommentsForPostModel {
    bool success;
    String message;
    List<Datum> data;

    AllCommentsForPostModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AllCommentsForPostModel.fromJson(Map<String, dynamic> json) => AllCommentsForPostModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int userId;
    int postId;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    bool isOwner;
    User user;

    Datum({
        required this.id,
        required this.userId,
        required this.postId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.isOwner,
        required this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isOwner: json["is_owner"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_owner": isOwner,
        "user": user.toJson(),
    };
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
    int wallet;
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
        required this.wallet,
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
        wallet: json["wallet"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "address": address,
        "gender": gender,
        "photo": photo,
        "role": role,
        "wallet": wallet,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
