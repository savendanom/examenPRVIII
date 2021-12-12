import 'dart:convert';

import 'package:project_movies/models/models.dart';

class ReviewsResponse {
  ReviewsResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int id;
  int page;
  List<ReviewsMovie> results;
  int totalPages;
  int totalResults;

  factory ReviewsResponse.fromJson(String str) => ReviewsResponse.fromMap(json.decode(str));

  factory ReviewsResponse.fromMap(Map<String, dynamic> json) => ReviewsResponse(
    id: json["id"],
    page: json["page"],
    results: List<ReviewsMovie>.from(json["results"].map((x) => ReviewsMovie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
