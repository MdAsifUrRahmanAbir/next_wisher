class MobilePaymentModel {
  final Message message;
  final Data data;

  MobilePaymentModel({
    required this.message,
    required this.data,
  });

  factory MobilePaymentModel.fromJson(Map<String, dynamic> json) => MobilePaymentModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String redirectUrl;

  Data({
    required this.redirectUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    redirectUrl: json["redirect_url"],
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