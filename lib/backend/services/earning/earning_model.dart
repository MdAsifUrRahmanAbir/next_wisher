
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
  final List<PaymentRequest> paymentRequests;

  Data({
    required this.revenue,
    required this.pending,
    required this.paid,
    required this.balance,
    required this.paymentRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    revenue: json["revenue"].toDouble(),
    pending: json["pending"].toDouble(),
    paid: json["paid"].toDouble(),
    balance: json["balance"].toDouble(),
    paymentRequests: List<PaymentRequest>.from(json["payment_requests"].map((x) => PaymentRequest.fromJson(x))),
  );
}

class PaymentRequest {
  final String invoice;
  final String bankType;
  final double amount;
  final String stripeEmail;
  final BankInfo bankInfo;
  final DateTime createdAt;

  PaymentRequest({
    required this.invoice,
    required this.bankType,
    required this.amount,
    required this.stripeEmail,
    required this.bankInfo,
    required this.createdAt,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    invoice: json["invoice"],
    bankType: json["bank_type"],
    amount: json["amount"].toDouble(),
    stripeEmail: json["stripe_email"] ?? "",
    bankInfo: BankInfo.fromJson(json["bank_info"]),
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class BankInfo {
  final String area;
  final String fullName;
  final String swift;
  final String accountNumber;

  BankInfo({
    required this.area,
    required this.fullName,
    required this.swift,
    required this.accountNumber,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
    area: json["area"] ?? "",
    fullName: json["full_name"] ?? "",
    swift: json["swift"] ?? "",
    accountNumber: json["account_number"] ?? "",
  );
}
