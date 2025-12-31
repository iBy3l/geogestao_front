import '/domain/entities/entities.dart';

class UserEntity {
  final String id;
  final String aud;
  final String role;
  final String email;
  final String? phone;
  final DateTime? emailConfirmedAt;
  final DateTime? confirmationSentAt;
  final DateTime? confirmedAt;
  final DateTime? lastSignInAt;
  final AppMetadataEntity appMetadata;
  final UserMetadataEntity userMetadata;
  final List<IdentityEntity> identities;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isAnonymous;

  UserEntity({
    required this.id,
    required this.aud,
    required this.role,
    required this.email,
    this.phone,
    this.emailConfirmedAt,
    this.confirmationSentAt,
    this.confirmedAt,
    this.lastSignInAt,
    required this.appMetadata,
    required this.userMetadata,
    required this.identities,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
  });

  factory UserEntity.fromJson(Map<String, dynamic>? json) {
    return UserEntity(
      id: json?['id'] ?? '',
      aud: json?['aud'] ?? '',
      role: json?['role'] ?? '',
      email: json?['email'] ?? '',
      phone: json?['phone'],
      emailConfirmedAt: json?['email_confirmed_at'] != null ? DateTime.tryParse(json!['email_confirmed_at']) : null,
      confirmationSentAt: json?['confirmation_sent_at'] != null ? DateTime.tryParse(json!['confirmation_sent_at']) : null,
      confirmedAt: json?['confirmed_at'] != null ? DateTime.tryParse(json!['confirmed_at']) : null,
      lastSignInAt: json?['last_sign_in_at'] != null ? DateTime.tryParse(json!['last_sign_in_at']) : null,
      appMetadata: AppMetadataEntity.fromJson(json?['app_metadata']),
      userMetadata: UserMetadataEntity.fromJson(json?['user_metadata']),
      identities: (json?['identities'] as List<dynamic>? ?? []).map((e) => IdentityEntity.fromJson(e)).toList(),
      createdAt: DateTime.parse(json?['created_at'] ?? ''),
      updatedAt: DateTime.parse(json?['updated_at'] ?? ''),
      isAnonymous: json?['is_anonymous'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aud': aud,
      'role': role,
      'email': email,
      'phone': phone,
      'email_confirmed_at': emailConfirmedAt?.toIso8601String(),
      'confirmation_sent_at': confirmationSentAt?.toIso8601String(),
      'confirmed_at': confirmedAt?.toIso8601String(),
      'last_sign_in_at': lastSignInAt?.toIso8601String(),
      'app_metadata': appMetadata.toJson(),
      'user_metadata': userMetadata.toJson(),
      'identities': identities.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_anonymous': isAnonymous,
    };
  }

  @override
  String toString() {
    return 'UserEntity{id: $id, email: $email, role: $role}';
  }
}
