
class SponcershipModel {
  bool success;
  String message;
  List<Datum> data;

  SponcershipModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SponcershipModel.fromJson(Map<String, dynamic> json) => SponcershipModel(
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
  int balance;
  int sponStatus;
  DateTime sponcershipDate;
  int userId;
  int animalId;
  DateTime createdAt;
  DateTime updatedAt;
  Animal animal;

  Datum({
    required this.id,
    required this.balance,
    required this.sponStatus,
    required this.sponcershipDate,
    required this.userId,
    required this.animalId,
    required this.createdAt,
    required this.updatedAt,
    required this.animal,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    balance: json["balance"],
    sponStatus: json["spon_status"],
    sponcershipDate: DateTime.parse(json["sponcership_date"]),
    userId: json["user_id"],
    animalId: json["animal_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    animal: Animal.fromJson(json["animal"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "balance": balance,
    "spon_status": sponStatus,
    "sponcership_date": "${sponcershipDate.year.toString().padLeft(4, '0')}-${sponcershipDate.month.toString().padLeft(2, '0')}-${sponcershipDate.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "animal_id": animalId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "animal": animal.toJson(),
  };
}

class Animal {
  int id;
  String name;
  int age;
  dynamic photo;
  DateTime entryDate;
  String health;
  DateTime createdAt;
  DateTime updatedAt;
  int departmentId;
  int animaltypeId;
  String type;
  String department;

  Animal({
    required this.id,
    required this.name,
    required this.age,
    required this.photo,
    required this.entryDate,
    required this.health,
    required this.createdAt,
    required this.updatedAt,
    required this.departmentId,
    required this.animaltypeId,
    required this.type,
    required this.department,
  });

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    photo: json["photo"],
    entryDate: DateTime.parse(json["entry_date"]),
    health: json["health"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    departmentId: json["department_id"],
    animaltypeId: json["animaltype_id"],
    type: json["type"],
    department: json["department"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "photo": photo,
    "entry_date": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
    "health": health,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "department_id": departmentId,
    "animaltype_id": animaltypeId,
    "type": type,
    "department": department,
  };
}
