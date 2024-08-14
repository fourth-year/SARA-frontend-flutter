// To parse this JSON data, do
//
//     final allPosts = allPostsFromJson(jsonString);

import 'dart:convert';

AllPosts allPostsFromJson(String str) => AllPosts.fromJson(json.decode(str));

String allPostsToJson(AllPosts data) => json.encode(data.toJson());

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
    String? photo;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    bool isLiked;
    List<Like> likes;
    List<Comment> comments;

    Datum({
        required this.id,
        required this.text,
        required this.photo,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.isLiked,
        required this.likes,
        required this.comments,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        text: json["text"],
        photo: json["photo"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isLiked: json["is_liked"],
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "photo": photo,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_liked": isLiked,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
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

class Like {
    int id;
    int userId;
    int postId;
    DateTime likeDate;
    DateTime createdAt;
    DateTime updatedAt;

    Like({
        required this.id,
        required this.userId,
        required this.postId,
        required this.likeDate,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        likeDate: DateTime.parse(json["like_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "like_date": "${likeDate.year.toString().padLeft(4, '0')}-${likeDate.month.toString().padLeft(2, '0')}-${likeDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
