class AllPosts {
    bool success;
    String message;
    List<Datum> data;

    AllPosts({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AllPosts.fromJson(Map<String, dynamic> json) => AllPosts(
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
    String text;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    List<Comment> likes;
    List<Comment> comments;

    Datum({
        required this.id,
        required this.text,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.likes,
        required this.comments,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        text: json["text"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        likes: List<Comment>.from(json["likes"].map((x) => Comment.fromJson(x))),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    int id;
    int userId;
    int postId;
    String? comment;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime? likeDate;

    Comment({
        required this.id,
        required this.userId,
        required this.postId,
        this.comment,
        required this.createdAt,
        required this.updatedAt,
        this.likeDate,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        likeDate: json["like_date"] == null ? null : DateTime.parse(json["like_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "like_date": "${likeDate!.year.toString().padLeft(4, '0')}-${likeDate!.month.toString().padLeft(2, '0')}-${likeDate!.day.toString().padLeft(2, '0')}",
    };
}
