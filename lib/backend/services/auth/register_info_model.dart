import 'package:next_wisher/widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class SignupInfoModel {
  final Data data;

  SignupInfoModel({
    required this.data,
  });

  factory SignupInfoModel.fromJson(Map<String, dynamic> json) => SignupInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Country> country;
  final List<Category> category;

  Data({
    required this.country,
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    country: List<Country>.from(json["country"].map((x) => Country.fromJson(x))),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );
}

class Category extends DropdownModel{
  final int id;
  final String name;
  final String slug;
  final int isParent;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Child> child;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.isParent,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.child,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    isParent: json["is_parent"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    child: List<Child>.from(json["child"].map((x) => Child.fromJson(x))),
  );

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement image
  String get image => "";
}

class Child extends DropdownModel{
  final int id;
  final String name;
  final String slug;
  final int isParent;
  final int parentId;
  final int status;

  Child({
    required this.id,
    required this.name,
    required this.slug,
    required this.isParent,
    required this.parentId,
    required this.status,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    isParent: json["is_parent"],
    parentId: json["parent_id"],
    status: json["status"],
  );

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement image
  String get image => "";
}

class Country extends DropdownModel{
  final int id;
  final String name;
  final String slug;
  final String phoneCode;
  final String countryCode;
  final int status;

  Country({
    required this.id,
    required this.name,
    required this.slug,
    required this.phoneCode,
    required this.countryCode,
    required this.status,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    phoneCode: json["phone_code"] ?? "",
    countryCode: json["country_code"] ?? "",
    status: json["status"],
  );

  @override
  // TODO: implement title
  String get title => name ;

  @override
  // TODO: implement image
  String get image => "";
}