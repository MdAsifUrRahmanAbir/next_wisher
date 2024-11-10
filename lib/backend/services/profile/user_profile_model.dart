class UserProfileModel {
  final Data data;

  UserProfileModel({
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final UserInfo userInfo;

  Data({
    required this.userInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["user_info"]),
  );
}

class UserInfo {
  final int id;
  final String name;
  final String email;
  final String role;
  final int status;

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    status: json["status"],
  );
}