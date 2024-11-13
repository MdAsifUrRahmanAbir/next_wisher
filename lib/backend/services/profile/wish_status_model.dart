class WishStatusModel {
  final Data data;

  WishStatusModel({
    required this.data,
  });

  factory WishStatusModel.fromJson(Map<String, dynamic> json) => WishStatusModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Wish wish;

  Data({
    required this.wish,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wish: Wish.fromJson(json["wish"]),
  );
}

class Wish {
  final String type;
  final int amount;
  final int status;

  Wish({
    required this.type,
    required this.amount,
    required this.status,
  });

  factory Wish.fromJson(Map<String, dynamic> json) => Wish(
    type: json["type"],
    amount: json["amount"],
    status: json["status"],
  );
}