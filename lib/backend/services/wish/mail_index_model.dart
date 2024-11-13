
class MailIndexModel {
  final Data data;

  MailIndexModel({
    required this.data,
  });

  factory MailIndexModel.fromJson(Map<String, dynamic> json) => MailIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Email> emails;

  Data({
    required this.emails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    emails: List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
  );
}

class Email {
  final int id;
  final int userId;
  final int talentId;
  final String userName;
  final String name;
  final String role;
  final String attachment;
  final String from;
  final String emailFor;
  final String occasion;
  final DateTime expirationDate;
  final String settings;
  final int seen;
  final String genders;
  final String instructions;
  final String mailFor;
  final int talentEarningId;
  final DateTime createdAt;
  final dynamic noteEmail;
  final bool downloadStatus;
  final bool fulfilledAt;

  Email({
    required this.id,
    required this.userId,
    required this.talentId,
    required this.userName,
    required this.name,
    required this.role,
    required this.attachment,
    required this.from,
    required this.emailFor,
    required this.occasion,
    required this.expirationDate,
    required this.settings,
    required this.seen,
    required this.genders,
    required this.instructions,
    required this.mailFor,
    required this.talentEarningId,
    required this.createdAt,
    required this.noteEmail,
    required this.downloadStatus,
    required this.fulfilledAt,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
    id: json["id"],
    userId: json["user_id"],
    talentId: json["talent_id"],
    userName: json["user_name"] ?? "",
    name: json["name"] ?? "",
    role: json["role"],
    attachment: json["attachment"],
    from: json["from"] ?? "",
    emailFor: json["for"] ?? "",
    occasion: json["occasion"] ?? "",
    expirationDate: DateTime.parse(json["expirationDate"]),
    settings: json["settings_time"] ?? "",
    seen: json["seen"],
    genders: json["genders"] ?? "",
    instructions: json["instructions"] ?? "",
    mailFor: json["mailFor"] ?? "",
    talentEarningId: json["talent_earning_id"],
    createdAt: DateTime.parse(json["created_at"]),
    noteEmail: json["note_email"],
    downloadStatus: json["download_status"],
    fulfilledAt: json["fulfilled_at"],
  );
}