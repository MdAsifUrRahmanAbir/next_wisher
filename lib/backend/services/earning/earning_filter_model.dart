class EarningFilterModel {
  final Data data;

  EarningFilterModel({
    required this.data,
  });

  factory EarningFilterModel.fromJson(Map<String, dynamic> json) => EarningFilterModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Calender wish;
  final Calender tips;
  final Calender mylife;
  final Calender calender;
  final Calender revenueGross;
  final double revenue;

  Data({
    required this.wish,
    required this.tips,
    required this.mylife,
    required this.calender,
    required this.revenueGross,
    required this.revenue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wish: Calender.fromJson(json["wish"]),
    tips: Calender.fromJson(json["tips"]),
    mylife: Calender.fromJson(json["mylife"]),
    calender: Calender.fromJson(json["calender"]),
    revenueGross: Calender.fromJson(json["revenue_gross"]),
    revenue: json["revenue"].toDouble(),
  );
}

class Calender {
  final double amount;
  final int count;

  Calender({
    required this.amount,
    required this.count,
  });

  factory Calender.fromJson(Map<String, dynamic> json) => Calender(
    amount: json["amount"].toDouble(),
    count: json["count"],
  );
}