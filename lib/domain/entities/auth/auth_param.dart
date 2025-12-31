class AuthParam {
  final String email;
  final String password;

  AuthParam({required this.email, required this.password});

  factory AuthParam.fromJson(Map<String, dynamic>? json) {
    return AuthParam(email: json?['email'] ?? '', password: json?['password'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
