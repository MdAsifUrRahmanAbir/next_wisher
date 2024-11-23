import 'package:next_wisher/widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class PayoutInfoModel {
  final Data data;

  PayoutInfoModel({
    required this.data,
  });

  factory PayoutInfoModel.fromJson(Map<String, dynamic> json) => PayoutInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<MobilepayCountry> mobilepayCountries;
  final List<String> bankCountriesList;

  Data({
    required this.mobilepayCountries,
    required this.bankCountriesList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mobilepayCountries: List<MobilepayCountry>.from(json["mobilepay_countries"].map((x) => MobilepayCountry.fromJson(x))),
    bankCountriesList: List<String>.from(json["bank_countries_list"].map((x) => x)),
  );
}

class MobilepayCountry extends DropdownModel{
  final String name;
  final String flag;
  final double rate;
  final List<Sim> sim;

  MobilepayCountry({
    required this.name,
    required this.flag,
    required this.rate,
    required this.sim,
  });

  factory MobilepayCountry.fromJson(Map<String, dynamic> json) => MobilepayCountry(
    name: json["name"],
    flag: json["flag"],
    rate: json["rate"].toDouble(),
    sim: List<Sim>.from(json["sim"].map((x) => Sim.fromJson(x))),
  );

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement image
  String get image => "assets/country/$flag.jpeg";
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