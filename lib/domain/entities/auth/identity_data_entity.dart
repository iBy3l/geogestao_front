class IdentityDataEntity {
  final String email;
  final bool emailVerified;
  final bool phoneVerified;
  final String sub;

  IdentityDataEntity({
    required this.email,
    required this.emailVerified,
    required this.phoneVerified,
    required this.sub,
  });

  factory IdentityDataEntity.fromJson(Map<String, dynamic>? json) {
    return IdentityDataEntity(
      email: json?['email'] ?? '',
      emailVerified: json?['email_verified'] ?? false,
      phoneVerified: json?['phone_verified'] ?? false,
      sub: json?['sub'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'email_verified': emailVerified,
      'phone_verified': phoneVerified,
      'sub': sub,
    };
  }

  @override
  String toString() {
    return 'IdentityDataEntity{email: $email, emailVerified: $emailVerified, phoneVerified: $phoneVerified, sub: $sub}';
  }

  IdentityDataEntity copyWith({
    String? email,
    bool? emailVerified,
    bool? phoneVerified,
    String? sub,
  }) {
    return IdentityDataEntity(
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      sub: sub ?? this.sub,
    );
  }
}
