import '/domain/entities/auth/identity_entity.dart';
import '/domain/entities/auth/user_metadata_entity.dart';

import 'app_metadata_entity.dart';

class SignUpEntity {
  final String id;
  final String aud;
  final String role;
  final String email;

  final String phone;
  final DateTime confirmationSentAt;
  final AppMetadataEntity appMetadata;
  final UserMetadataEntity userMetadata;
  final List<IdentityEntity> identities;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isAnonymous;

  SignUpEntity({
    required this.id,
    required this.aud,
    required this.role,
    required this.email,
    required this.phone,
    required this.confirmationSentAt,
    required this.appMetadata,
    required this.userMetadata,
    required this.identities,
    required this.createdAt,
    required this.updatedAt,
    required this.isAnonymous,
  });

  factory SignUpEntity.fromJson(Map<String, dynamic> json) {
    return SignUpEntity(
      id: json['id'],
      aud: json['aud'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'] ?? '',
      confirmationSentAt: DateTime.parse(json['confirmation_sent_at']),
      appMetadata: AppMetadataEntity.fromJson(json['app_metadata']),
      userMetadata: UserMetadataEntity.fromJson(json['user_metadata']),
      identities: (json['identities'] as List).map((identity) => IdentityEntity.fromJson(identity)).toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isAnonymous: json['is_anonymous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aud': aud,
      'role': role,
      'email': email,
      'phone': phone,
      'confirmation_sent_at': confirmationSentAt.toIso8601String(),
      'app_metadata': appMetadata.toJson(),
      'user_metadata': userMetadata.toJson(),
      'identities': identities.map((identity) => identity.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_anonymous': isAnonymous,
    };
  }

  @override
  String toString() {
    return 'SignUpEntity{id: $id, aud: $aud, role: $role, email: $email, phone: $phone, confirmationSentAt: $confirmationSentAt, appMetadata: $appMetadata, userMetadata: $userMetadata, identities: $identities, createdAt: $createdAt, updatedAt: $updatedAt, isAnonymous: $isAnonymous}';
  }

  SignUpEntity copyWith({
    String? id,
    String? aud,
    String? role,
    String? email,
    bool? emailConfirmed,
    String? phone,
    DateTime? confirmationSentAt,
    DateTime? lastSignInAt,
    AppMetadataEntity? appMetadata,
    UserMetadataEntity? userMetadata,
    List<IdentityEntity>? identities,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isAnonymous,
  }) {
    return SignUpEntity(
      id: id ?? this.id,
      aud: aud ?? this.aud,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      confirmationSentAt: confirmationSentAt ?? this.confirmationSentAt,
      appMetadata: appMetadata ?? this.appMetadata,
      userMetadata: userMetadata ?? this.userMetadata,
      identities: identities ?? this.identities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }
}
