import 'dart:convert';

class RatingResponse {
  RatingResponse({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
  });

  bool success;
  int statusCode;
  String statusMessage;

  factory RatingResponse.fromJson(String str) => RatingResponse.fromMap(json.decode(str));

  factory RatingResponse.fromMap(Map<String, dynamic> json) => RatingResponse(
    success: json["success"],
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
  );
}
