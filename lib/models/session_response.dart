import 'dart:convert';

class SessionResponse {
  SessionResponse({
    required this.success,
    this.sessionId,
  });

  bool success;
  String? sessionId;

  factory SessionResponse.fromJson(String str) => SessionResponse.fromMap(json.decode(str));

  factory SessionResponse.fromMap(Map<String, dynamic> json) => SessionResponse(
    success: json["success"],
    sessionId: json["session_id"] == null ? null : json["session_id"],
  );
}
