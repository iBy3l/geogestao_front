class AppMetadataEntity {
  final String provider;
  final List<String> providers;

  AppMetadataEntity({
    required this.provider,
    required this.providers,
  });

  factory AppMetadataEntity.fromJson(Map<String, dynamic>? json) {
    return AppMetadataEntity(
      provider: json?['provider'] ?? '',
      providers: List<String>.from(json?['providers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'providers': providers,
    };
  }

  @override
  String toString() {
    return 'AppMetadataEntity{provider: $provider, providers: $providers}';
  }
}
