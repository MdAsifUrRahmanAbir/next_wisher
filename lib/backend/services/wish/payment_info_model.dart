import 'package:next_wisher/widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class PaymentInfoModel {
  final Data data;

  PaymentInfoModel({
    required this.data,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) => PaymentInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final double commission;
  final String orderCode;
  final Talent talent;
  final Earning earning;
  final List<Ocasion> ocasions;
  final List<PawapayCountry> pawapayCountries;

  Data({
    required this.commission,
    required this.orderCode,
    required this.talent,
    required this.earning,
    required this.ocasions,
    required this.pawapayCountries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    commission: json["commission"].toDouble(),
    orderCode: json["order_code"],
    talent: Talent.fromJson(json["talent"]),
    earning: Earning.fromJson(json["earning"]),
    ocasions: List<Ocasion>.from(json["ocasions"].map((x) => Ocasion.fromJson(x))),
    pawapayCountries: List<PawapayCountry>.from(json["pawapay_countries"].map((x) => PawapayCountry.fromJson(x))),
  );
}

class Earning {
  final int id;
  final int userId;
  final String type;
  final double amount;
  final int status;

  Earning({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.status,
  });

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    amount: json["amount"].toDouble(),
    status: json["status"],
  );
}

class Ocasion extends DropdownModel{
  final int id;
  final String name;
  final String slug;
  final int status;

  Ocasion({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
  });

  factory Ocasion.fromJson(Map<String, dynamic> json) => Ocasion(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
  );

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement image
  String get image => throw UnimplementedError();
}

class PawapayCountry extends DropdownModel{
  final String name;
  final String flag;
  final double rate;
  final List<Sim> sim;

  PawapayCountry({
    required this.name,
    required this.flag,
    required this.rate,
    required this.sim,
  });

  factory PawapayCountry.fromJson(Map<String, dynamic> json) => PawapayCountry(
    name: json["name"],
    flag: json["flag"],
    rate: json["rate"].toDouble(),
    sim: List<Sim>.from(json["sim"].map((x) => Sim.fromJson(x))),
  );

  @override
  // TODO: implement title
  String get title => "${sim.first.country} (${sim.first.currency})";

  @override
  // TODO: implement image
  String get image => throw UnimplementedError();
}

class Sim {
  final String mno;
  final String correspondent;
  final String country;
  final String currency;
  final String prefix;
  final double rate;
  final double decimal;

  Sim({
    required this.mno,
    required this.correspondent,
    required this.country,
    required this.currency,
    required this.prefix,
    required this.rate,
    required this.decimal,
  });

  factory Sim.fromJson(Map<String, dynamic> json) => Sim(
    mno: json["mno"],
    correspondent: json["correspondent"],
    country: json["country"],
    currency: json["currency"],
    prefix: json["prefix"],
    rate: json["rate"].toDouble(),
    decimal: json["decimal"].toDouble(),
  );
}

class Talent {
  final int id;
  final String name;
  final String username;
  final String bio;
  final String role;
  final String videoPath;
  final String verificationVideo;
  final Category category;
  final Category subcategory;

  Talent({
    required this.id,
    required this.name,
    required this.username,
    required this.bio,
    required this.role,
    required this.videoPath,
    required this.verificationVideo,
    required this.category,
    required this.subcategory,
  });

  factory Talent.fromJson(Map<String, dynamic> json) => Talent(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    bio: json["bio"],
    role: json["role"],
    videoPath: json["video_path"],
    verificationVideo: json["verification_video"],
    category: Category.fromJson(json["category"]),
    subcategory: Category.fromJson(json["subcategory"]),
  );
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );
}