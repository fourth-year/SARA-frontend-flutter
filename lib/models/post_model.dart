class PostByIdModel {
    bool success;
    String message;
    Data data;

    PostByIdModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory PostByIdModel.fromJson(Map<String, dynamic> json) => PostByIdModel(
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
    String text;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    bool isOwner;
    bool isLiked;
    List<dynamic> likes;
    List<Comment> comments;

    Data({
        required this.id,
        required this.text,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.isOwner,
        required this.isLiked,
        required this.likes,
        required this.comments,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        text: json["text"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isOwner: json["is_owner"],
        isLiked: json["is_liked"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_owner": isOwner,
        "is_liked": isLiked,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    int id;
    int userId;
    int postId;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    bool isOwner;

    Comment({
        required this.id,
        required this.userId,
        required this.postId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.isOwner,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
