class ErrorResponse {
  final Message message;

  ErrorResponse({
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: Message.fromJson(json["message"]),
  );
}

class Message {
  final List<String> error;

  Message({
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    error: List<String>.from(json["error"].map((x) => x)),
  );
}