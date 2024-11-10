class StripePaymentModel {
  final Data data;

  StripePaymentModel({
    required this.data,
  });

  factory StripePaymentModel.fromJson(Map<String, dynamic> json) => StripePaymentModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final RedirectionResponse redirectionResponse;
  final String redirectUrl;

  Data({
    required this.redirectionResponse,
    required this.redirectUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    redirectionResponse: RedirectionResponse.fromJson(json["redirection_response"]),
    redirectUrl: json["redirect_url"],
  );
}

class RedirectionResponse {
  final String cancelUrl;
  final String successUrl;

  RedirectionResponse({
    required this.cancelUrl,
    required this.successUrl,
  });

  factory RedirectionResponse.fromJson(Map<String, dynamic> json) => RedirectionResponse(
    cancelUrl: json["cancel_url"],
    successUrl: json["success_url"],
  );
}