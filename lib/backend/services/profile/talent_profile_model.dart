import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class TalentProfileModel {
  final Data data;

  TalentProfileModel({
    required this.data,
  });

  factory TalentProfileModel.fromJson(Map<String, dynamic> json) => TalentProfileModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final UserInfo userInfo;
  final List<Category> category;

  Data({
    required this.userInfo,
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["user_info"]),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );
}

class Category extends DropdownModel{
  final int id;
  final String name;
  final String slug;
  final int isParent;
  final int parentId;
  final int status;
  final List<Child> child;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.isParent,
    required this.parentId,
    required this.status,
    required this.child,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    isParent: json["is_parent"],
    parentId: json["parent_id"] ?? 0,
    status: json["status"],
    child: List<Child>.from(json["child"].map((x) => Child.fromJson(x))),
  );

  @override
  // TODO: implement title
  String get title => name;
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
    parentId: json["parent_id"] ?? 0,
    status: json["status"]
  );

  @override
  // TODO: implement title
  String get title => name;
}

class UserInfo {
  final int id;
  final String name;
  final String username;
  final dynamic country;
  final int categoryId;
  final int subCategoryId;
  final String email;
  final String link;
  final String role;
  final double balance;
  final String coverImage;
  final String profileImage;
  final String verificationVideo;
  final String bio;

  UserInfo({
    required this.id,
    required this.name,
    required this.username,
    required this.country,
    required this.categoryId,
    required this.subCategoryId,
    required this.email,
    required this.link,
    required this.role,
    required this.balance,
    required this.coverImage,
    required this.profileImage,
    required this.verificationVideo,
    required this.bio,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    country: json["country"] ?? "",
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    email: json["email"],
    link: json["link"],
    role: json["role"],
    balance: json["balance"].toDouble(),
    coverImage: json["cover_image"],
    profileImage: json["profile_image"],
    verificationVideo: json["verification_video"],
    bio: json["bio"],
  );
}