class AllEmergencyModel {
    bool success;
    String message;
    List<Datum> data;

    AllEmergencyModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AllEmergencyModel.fromJson(Map<String, dynamic> json) => AllEmergencyModel(
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
    String address;
    String description;
    String contact;
    DateTime emrDate;
    String? photo;
    int status;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.address,
        required this.description,
        required this.contact,
        required this.emrDate,
        required this.photo,
        required this.status,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        address: json["address"],
        description: json["description"],
        contact: json["contact"],
        emrDate: DateTime.parse(json["emr_date"]),
        photo: json["photo"],
        status: json["status"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "description": description,
        "contact": contact,
        "emr_date": "${emrDate.year.toString().padLeft(4, '0')}-${emrDate.month.toString().padLeft(2, '0')}-${emrDate.day.toString().padLeft(2, '0')}",
        "photo": photo,
        "status": status,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
