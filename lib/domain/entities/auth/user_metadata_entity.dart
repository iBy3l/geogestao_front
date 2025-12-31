class UserMetadataEntity {
  final String email;
  final bool emailVerified;
  final bool phoneVerified;
  final String sub;

  UserMetadataEntity({
    required this.email,
    required this.emailVerified,
    required this.phoneVerified,
    required this.sub,
  });

  factory UserMetadataEntity.fromJson(Map<String, dynamic>? json) {
    return UserMetadataEntity(
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
    return 'UserMetadataEntity{email: $email, emailVerified: $emailVerified, phoneVerified: $phoneVerified, sub: $sub}';
  }

  UserMetadataEntity copyWith({
    String? email,
    bool? emailVerified,
    bool? phoneVerified,
    String? sub,
  }) {
    return UserMetadataEntity(
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      sub: sub ?? this.sub,
    );
  }
}
