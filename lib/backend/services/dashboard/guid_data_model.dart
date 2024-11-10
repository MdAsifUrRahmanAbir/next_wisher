class GuidDataModel {
  final Data data;

  GuidDataModel({
    required this.data,
  });

  factory GuidDataModel.fromJson(Map<String, dynamic> json) => GuidDataModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final GuideData guideData;

  Data({
    required this.guideData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    guideData: GuideData.fromJson(json["guideData"]),
  );
}

class GuideData {
  final int id;
  final String title;
  final String username;
  final String description;
  final String french;
  final String purtugues;
  final String spanish;

  GuideData({
    required this.id,
    required this.title,
    required this.username,
    required this.description,
    required this.french,
    required this.purtugues,
    required this.spanish,
  });

  factory GuideData.fromJson(Map<String, dynamic> json) => GuideData(
    id: json["id"],
    title: json["title"],
    username: json["username"] ?? "",
    description: json["description"] ?? "",
    french: json["french"] ?? "",
    purtugues: json["purtugues"] ?? "",
    spanish: json["spanish"] ?? "",
  );
}