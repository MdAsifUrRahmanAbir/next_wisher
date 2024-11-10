
class HomeModel {
  final Data data;

  HomeModel({
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Country> countries;
  final List<CategoriesWithChild> categoriesWithChild;
  final List<HomeTalent> homeTalents;
  final List<FeaturedVideo> featuredVideos;

  Data({
    required this.countries,
    required this.categoriesWithChild,
    required this.homeTalents,
    required this.featuredVideos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    categoriesWithChild: List<CategoriesWithChild>.from(json["categories_with_child"].map((x) => CategoriesWithChild.fromJson(x))),
    homeTalents: List<HomeTalent>.from(json["homeTalents"].map((x) => HomeTalent.fromJson(x))),
    featuredVideos: List<FeaturedVideo>.from(json["featured_videos"].map((x) => FeaturedVideo.fromJson(x))),
  );
}

class CategoriesWithChild {
  final String name;
  final String slug;
  final int status;
  final String categoryUrl;

  CategoriesWithChild({
    required this.name,
    required this.slug,
    required this.status,
    required this.categoryUrl,
  });

  factory CategoriesWithChild.fromJson(Map<String, dynamic> json) => CategoriesWithChild(
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    categoryUrl: json["category_url"],
  );
}

class Country {
  final int id;
  final String name;
  final String slug;
  final String phoneCode;
  final String countryCode;
  final int status;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  Country({
    required this.id,
    required this.name,
    required this.slug,
    required this.phoneCode,
    required this.countryCode,
    required this.status,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    phoneCode: json["phone_code"] ?? "",
    countryCode: json["country_code"] ?? "",
    status: json["status"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class FeaturedVideo {
  final String path;
  final String thumbnail;

  FeaturedVideo({
    required this.path,
    required this.thumbnail,
  });

  factory FeaturedVideo.fromJson(Map<String, dynamic> json) => FeaturedVideo(
    path: json["path"],
    thumbnail: json["thumbnail"],
  );
}

class HomeTalent {
  final int userId;
  final int boxIndex;
  final String name;
  final String role;
  final int status;
  final List<Amount> amount;
  final String profileImage;
  final String talentUrl;

  HomeTalent({
    required this.userId,
    required this.boxIndex,
    required this.name,
    required this.role,
    required this.status,
    required this.amount,
    required this.profileImage,
    required this.talentUrl,
  });

  factory HomeTalent.fromJson(Map<String, dynamic> json) => HomeTalent(
    userId: json["user_id"],
    boxIndex: json["box_index"],
    name: json["name"],
    role: json["role"],
    status: json["status"],
    amount: List<Amount>.from(json["amount"].map((x) => Amount.fromJson(x))),
    profileImage: json["profile_image"],
    talentUrl: json["talent_url"],
  );
}

class Amount {
  final int id;
  final int userId;
  final String type;
  final double amount;
  final int status;

  Amount({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.status
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    amount: json["amount"].toDouble(),
    status: json["status"]
  );

}