class GetAnimal_byid_Model {
    bool status;
    String message;
    Data data;

    GetAnimal_byid_Model({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetAnimal_byid_Model.fromJson(Map<String, dynamic> json) => GetAnimal_byid_Model(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
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
    List<dynamic> adoptions;
    List<dynamic> sponcerships;

    Data({
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
        required this.adoptions,
        required this.sponcerships,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        adoptions: List<dynamic>.from(json["adoptions"].map((x) => x)),
        sponcerships: List<dynamic>.from(json["sponcerships"].map((x) => x)),
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
        "adoptions": List<dynamic>.from(adoptions.map((x) => x)),
        "sponcerships": List<dynamic>.from(sponcerships.map((x) => x)),
    };
}
