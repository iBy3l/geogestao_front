import '/domain/entities/auth/identity_data_entity.dart';

class IdentityEntity {
  final String identityId;
  final String id;
  final String userId;
  final IdentityDataEntity identityData;
  final String provider;
  final DateTime lastSignInAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;

  IdentityEntity({
    required this.identityId,
    required this.id,
    required this.userId,
    required this.identityData,
    required this.provider,
    required this.lastSignInAt,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
  });

  factory IdentityEntity.fromJson(Map<String, dynamic>? json) {
    return IdentityEntity(
      identityId: json?['identity_id'],
      id: json?['id'],
      userId: json?['user_id'],
      identityData: IdentityDataEntity.fromJson(json?['identity_data']),
      provider: json?['provider'],
      lastSignInAt: DateTime.parse(json?['last_sign_in_at']),
      createdAt: DateTime.parse(json?['created_at']),
      updatedAt: DateTime.parse(json?['updated_at']),
      email: json?['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identity_id': identityId,
      'id': id,
      'user_id': userId,
      'identity_data': identityData.toJson(),
      'provider': provider,
      'last_sign_in_at': lastSignInAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'email': email,
    };
  }

  @override
  String toString() {
    return 'IdentityEntity{identityId: $identityId, id: $id, userId: $userId, identityData: $identityData, provider: $provider, lastSignInAt: $lastSignInAt, createdAt: $createdAt, updatedAt: $updatedAt, email: $email}';
  }

  IdentityEntity copyWith({
    String? identityId,
    String? id,
    String? userId,
    IdentityDataEntity? identityData,
    String? provider,
    DateTime? lastSignInAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? email,
  }) {
    return IdentityEntity(
      identityId: identityId ?? this.identityId,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      identityData: identityData ?? this.identityData,
      provider: provider ?? this.provider,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      email: email ?? this.email,
    );
  }
}
