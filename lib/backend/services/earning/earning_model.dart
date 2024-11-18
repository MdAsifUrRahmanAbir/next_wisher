class EarningModel {
  final Data data;

  EarningModel({
    required this.data,
  });

  factory EarningModel.fromJson(Map<String, dynamic> json) => EarningModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final double revenue;
  final double pending;
  final double paid;
  final double balance;
  final double wishAmount;
  final double tipsAmount;
  final int wishCount;
  final int tipsCount;
  final List<PaymentRequest> paymentRequests;

  Data({
    required this.revenue,
    required this.pending,
    required this.paid,
    required this.balance,
    required this.wishAmount,
    required this.tipsAmount,
    required this.wishCount,
    required this.tipsCount,
    required this.paymentRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    revenue: json["revenue"].toDouble(),
    pending: json["pending"].toDouble(),
    paid: json["paid"].toDouble(),
    balance: json["balance"].toDouble(),
    wishAmount: json["wish_amount"].toDouble(),
    tipsAmount: json["tips_amount"].toDouble(),
    wishCount: json["wish_count"],
    tipsCount: json["tips_count"],
    paymentRequests: List<PaymentRequest>.from(json["payment_requests"].map((x) => PaymentRequest.fromJson(x))),
  );
}

class PaymentRequest {
  final int userId;
  final String invoice;
  final String bankType;
  final double amount;
  final String stripeEmail;
  final int status;
  final DateTime createdAt;

  PaymentRequest({
    required this.userId,
    required this.invoice,
    required this.bankType,
    required this.amount,
    required this.stripeEmail,
    required this.status,
    required this.createdAt,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    userId: json["user_id"],
    invoice: json["invoice"],
    bankType: json["bank_type"],
    amount: json["amount"].toDouble(),
    stripeEmail: json["stripe_email"] ?? "",
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}