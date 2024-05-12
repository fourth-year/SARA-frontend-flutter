

class AllAnimals {
  bool success;
  String message;
  List<Datum> data;

  AllAnimals({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllAnimals.fromJson(Map<String, dynamic> json) => AllAnimals(
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
  String name;
  int age;
  String photo;
  DateTime entryDate;
  DateTime createdAt;
  DateTime updatedAt;
  int departmentId;
  int animaltypeId;

  Datum({
    required this.id,
    required this.name,
    required this.age,
    required this.photo,
    required this.entryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.departmentId,
    required this.animaltypeId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    photo: json["photo"],
    entryDate: DateTime.parse(json["entry_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    departmentId: json["department_id"],
    animaltypeId: json["animaltype_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "photo": photo,
    "entry_date": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "department_id": departmentId,
    "animaltype_id": animaltypeId,
  };
}
