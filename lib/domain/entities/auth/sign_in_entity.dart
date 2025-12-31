import '/domain/entities/user/user_entity.dart';

class SignInEntity {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int expiresAt;
  final String refreshToken;
  final UserEntity user;

  SignInEntity({required this.accessToken, required this.tokenType, required this.expiresIn, required this.expiresAt, required this.refreshToken, required this.user});

  factory SignInEntity.fromJson(Map<String, dynamic>? json) {
    return SignInEntity(
      accessToken: json?['access_token'] ?? '',
      tokenType: json?['token_type'] ?? '',
      expiresIn: json?['expires_in'] ?? 0,
      expiresAt: json?['expires_at'] ?? 0,
      refreshToken: json?['refresh_token'] ?? '',
      user: UserEntity.fromJson(json?['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'token_type': tokenType, 'expires_in': expiresIn, 'expires_at': expiresAt, 'refresh_token': refreshToken, 'user': user.toJson()};
  }

  @override
  String toString() {
    return 'SignInEntity{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, expiresAt: $expiresAt, refreshToken: $refreshToken, user: $user}';
  }
}
