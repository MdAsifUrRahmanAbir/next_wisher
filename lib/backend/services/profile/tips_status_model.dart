class TipsStatusModel {
  final Data data;

  TipsStatusModel({
    required this.data,
  });

  factory TipsStatusModel.fromJson(Map<String, dynamic> json) => TipsStatusModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Tips tips;

  Data({
    required this.tips,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tips: Tips.fromJson(json["tips"]),
  );
}

class Tips {
  final String type;
  final int amount;
  final int status;

  Tips({
    required this.type,
    required this.amount,
    required this.status,
  });

  factory Tips.fromJson(Map<String, dynamic> json) => Tips(
    type: json["type"],
    amount: json["amount"],
    status: json["status"],
  );
}