
class SessionUserModel {
  bool success;
  String message;
  List<Datum> data;

  SessionUserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SessionUserModel.fromJson(Map<String, dynamic> json) => SessionUserModel(
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
  int sessionId;
  DateTime sessionDate;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAdded;
  Session session;
  User user;

  Datum({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.sessionDate,
    required this.createdAt,
    required this.updatedAt,
    required this.isAdded,
    required this.session,
    required this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    sessionId: json["session_id"],
    sessionDate: DateTime.parse(json["session_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isAdded: json["is_Added"],
    session: Session.fromJson(json["session"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "session_id": sessionId,
    "session_date": "${sessionDate.year.toString().padLeft(4, '0')}-${sessionDate.month.toString().padLeft(2, '0')}-${sessionDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_Added": isAdded,
    "session": session.toJson(),
    "user": user.toJson(),
  };
}

class Session {
  int id;
  String title;
  int numOfAttendees;
  DateTime date;
  String time;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAdded;

  Session({
    required this.id,
    required this.title,
    required this.numOfAttendees,
    required this.date,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.isAdded,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["id"],
    title: json["title"],
    numOfAttendees: json["num_of_attendees"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isAdded: json["is_added"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "num_of_attendees": numOfAttendees,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_added": isAdded,
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
  dynamic photo;
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
