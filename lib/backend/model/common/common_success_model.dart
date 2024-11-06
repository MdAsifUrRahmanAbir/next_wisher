class CommonSuccessModel {
  final Message message;

  CommonSuccessModel({
    required this.message,
  });

  factory CommonSuccessModel.fromJson(Map<String, dynamic> json) => CommonSuccessModel(
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
