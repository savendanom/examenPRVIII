import 'dart:convert';

import 'package:project_movies/models/models.dart';

class SimilarResponse {
  SimilarResponse({
      required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults,
  });

  int page;
  List<SimilarMovie> results;
  int totalPages;
  int totalResults;

  factory SimilarResponse.fromJson(String str) => SimilarResponse.fromMap(json.decode(str));

  factory SimilarResponse.fromMap(Map<String, dynamic> json) => SimilarResponse(
    page: json["page"],
    results: List<SimilarMovie>.from(json["results"].map((x) => SimilarMovie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
