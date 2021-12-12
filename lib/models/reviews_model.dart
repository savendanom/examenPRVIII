import 'dart:convert';

class ReviewsMovie {
  ReviewsMovie({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  String author;
  AuthorDetails authorDetails;
  String content;
  String createdAt;
  String id;
  String updatedAt;
  String url;

  factory ReviewsMovie.fromJson(String str) => ReviewsMovie.fromMap(json.decode(str));

  factory ReviewsMovie.fromMap(Map<String, dynamic> json) => ReviewsMovie(
    author: json["author"],
    authorDetails: AuthorDetails.fromMap(json["author_details"]),
    content: json["content"],
    createdAt: json["created_at"],
    id: json["id"],
    updatedAt: json["updated_at"],
    url: json["url"],
  );
}

class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  String? name;
  String? username;
  String? avatarPath;
  dynamic? rating;

  factory AuthorDetails.fromJson(String str) => AuthorDetails.fromMap(json.decode(str));

  factory AuthorDetails.fromMap(Map<String, dynamic> json) => AuthorDetails(
    name: json["name"] == null ? null : json["name"],
    username: json["username"] == null ? null : json["username"],
    avatarPath: json["avatar_path"] == null ? null : json["avatar_path"],
    rating: json["rating"] == null ? null : json["rating"],
  );
}