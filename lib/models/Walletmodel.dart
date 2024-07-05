
class WalletModel {
  bool success;
  String message;
  Data data;

  WalletModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
  int wallet;

  Data({
    required this.wallet,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
  };
}
