import 'dart:convert';

class GuestSessionResponse {
  GuestSessionResponse({
    required this.success,
    required this.expiresAt,
    required this.guestSessionId,
  });

  bool success;
  String expiresAt;
  String guestSessionId;

  factory GuestSessionResponse.fromJson(String str) => GuestSessionResponse.fromMap(json.decode(str));

  factory GuestSessionResponse.fromMap(Map<String, dynamic> json) => GuestSessionResponse(
    success: json["success"],
    expiresAt: json["expires_at"],
    guestSessionId: json["guest_session_id"],
  );

}
