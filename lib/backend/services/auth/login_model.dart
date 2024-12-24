class LoginModel {
  final Data data;

  LoginModel({
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;
  final UserInfo userInfo;
  final Authorization authorization;

  Data({
    required this.token,
    required this.userInfo,
    required this.authorization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    authorization: Authorization.fromJson(json["authorization"]),
  );
}

class Authorization {
  final String token;

  Authorization({
    required this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
    token: json["token"],
  );
}

class UserInfo {
  final int id;
  final String name;
  final String bio;
  final String email;
  final String role;
  final String emailVerified;
  final int status;
  final int fileAccess;
  final int isFeatured;
  final double balance;

  UserInfo({
    required this.id,
    required this.name,
    required this.bio,
    required this.email,
    required this.role,
    required this.status,
    required this.fileAccess,
    required this.isFeatured,
    required this.balance,
    required this.emailVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    bio: json["bio"] ?? "",
    email: json["email"],
    role: json["role"],
    status: json["status"],
    fileAccess: json["file_access"],
    isFeatured: json["is_featured"],
    emailVerified: json["email_verified_at"] ?? "",
    balance: json["balance"].toDouble(),
  );
}