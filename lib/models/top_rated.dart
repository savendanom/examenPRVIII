import 'dart:convert';

import 'package:project_movies/models/models.dart';

class TopratedResponse {
  TopratedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<TopRatedMovie> results;
  int totalPages;
  int totalResults;

  factory TopratedResponse.fromJson(String str) => TopratedResponse.fromMap(json.decode(str));

  factory TopratedResponse.fromMap(Map<String, dynamic> json) => TopratedResponse(
    page: json["page"],
    results: List<TopRatedMovie>.from(json["results"].map((x) => TopRatedMovie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
