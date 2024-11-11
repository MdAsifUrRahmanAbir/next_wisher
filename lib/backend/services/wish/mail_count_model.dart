class MailCountModel {
  final Data data;

  MailCountModel({
    required this.data,
  });

  factory MailCountModel.fromJson(Map<String, dynamic> json) => MailCountModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final int mailCount;

  Data({
    required this.mailCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mailCount: json["mail_count"],
  );
}