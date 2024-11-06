
class RegisterModel {
  final Data data;
  final Message message;

  RegisterModel({
    required this.data,
    required this.message,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    data: Data.fromJson(json["data"]),
    message: Message.fromJson(json["message"]),
  );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );
}

class Data {
  final String token;
  final String role;
  final UserInfo userInfo;
  final Authorization authorization;

  Data({
    required this.token,
    required this.role,
    required this.userInfo,
    required this.authorization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    role: json["role"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    authorization: Authorization.fromJson(json["authorization"]),
  );
}

class Authorization {
  final bool status;
  final String token;

  Authorization({
    required this.status,
    required this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
    status: json["status"],
    token: json["token"],
  );
}

class UserInfo {
  final int id;
  final String name;
  final String username;

  UserInfo({
    required this.id,
    required this.name,
    required this.username,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    username: json["username"],
  );
}