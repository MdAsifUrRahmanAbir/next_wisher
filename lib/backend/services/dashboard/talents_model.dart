class TalentsModel {
  final Data data;

  TalentsModel({
    required this.data,
  });

  factory TalentsModel.fromJson(Map<String, dynamic> json) => TalentsModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Talent talent;
  final Tips wish;
  final Tips tips;
  final dynamic mylife;

  Data({
    required this.talent,
    required this.wish,
    required this.tips,
    required this.mylife,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    talent: Talent.fromJson(json["talent"]),
    wish: Tips.fromJson(json["wish"]),
    tips: Tips.fromJson(json["tips"]),
    mylife: json["mylife"],
  );
}

class Talent {
  final int id;
  final int totalRating;
  final double ratingPercent;
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
    required this.totalRating,
    required this.ratingPercent,
  });

  factory Talent.fromJson(Map<String, dynamic> json) => Talent(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    bio: json["bio"],
    role: json["role"],
    videoPath: json["video_path"],
    verificationVideo: json["verification_video"],
    totalRating: json["total_rating"],
    ratingPercent: json["rating_percent"].toDouble(),
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

class Tips {
  final int id;
  final int userId;
  final String type;
  final double amount;
  final bool status;

  Tips({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.status,
  });

  factory Tips.fromJson(Map<String, dynamic> json) => Tips(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    status: json["status"],
    amount: json["amount"].toDouble(),
  );
}