
class SessionModel {
  bool success;
  String message;
  List<Datum> data;

  SessionModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
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
  String title;
  int numOfAttendees;
  DateTime date;
  String time;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAdded;

  Datum({
    required this.id,
    required this.title,
    required this.numOfAttendees,
    required this.date,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.isAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
