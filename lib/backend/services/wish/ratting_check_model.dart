
class RatingCheckModel {
  final Data data;

  RatingCheckModel({
    required this.data,
  });

  factory RatingCheckModel.fromJson(Map<String, dynamic> json) => RatingCheckModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final bool ratingStatus;

  Data({
    required this.ratingStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ratingStatus: json["rating_status"],
  );
}