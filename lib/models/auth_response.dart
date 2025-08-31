class AuthResponse {
  final String token;

  AuthResponse({required this.token});

  // Gelen Map<String, dynamic> (JSON) verisinden
  // bir AuthResponse nesnesi oluşturan factory constructor.
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
    );
  }
}