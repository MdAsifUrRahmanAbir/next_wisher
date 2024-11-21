
import 'home_model.dart';

class CategoryModel {
  final Data data;
  final String type;
  final int status;

  CategoryModel({
    required this.data,
    required this.type,
    required this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    data: Data.fromJson(json["data"]),
    type: json["type"],
    status: json["status"],
  );
}

class Data {
  final List<HomeTalent> talents;

  Data({
    required this.talents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    talents: List<HomeTalent>.from(json["talents"].map((x) => HomeTalent.fromJson(x))),
  );
}
