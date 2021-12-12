import 'dart:convert';

class TokenResponse {
  TokenResponse({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  bool success;
  String expiresAt;
  String requestToken;

  factory TokenResponse.fromJson(String str) => TokenResponse.fromMap(json.decode(str));

  factory TokenResponse.fromMap(Map<String, dynamic> json) => TokenResponse(
    success: json["success"],
    expiresAt: json["expires_at"],
    requestToken: json["request_token"],
  );

}
