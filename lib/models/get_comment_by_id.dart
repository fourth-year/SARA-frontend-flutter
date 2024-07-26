class CommentByIdModel {
    bool success;
    String message;
    Data data;

    CommentByIdModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory CommentByIdModel.fromJson(Map<String, dynamic> json) => CommentByIdModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    int userId;
    int postId;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    bool isOwner;

    Data({
        required this.id,
        required this.userId,
        required this.postId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.isOwner,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isOwner: json["is_owner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_owner": isOwner,
    };
}