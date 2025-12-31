import 'package:flutter/material.dart';

abstract class IEnv {
  EnvModel getEnvModel(EnvType envType);
}

class Env implements IEnv {
  @override
  EnvModel getEnvModel(EnvType envType) {
    switch (envType) {
      case EnvType.developer:
        return EnvModel(
          baseUrl: 'https://dev.example.com',
          devMode: true,
          enableBanner: true,
          bannerColor: Colors.red,
        );
      case EnvType.production:
        return EnvModel(
          baseUrl: 'https://prod.example.com',
          devMode: false,
          enableBanner: false,
          bannerColor: null,
        );
    }
  }
}

class EnvModel {
  final String baseUrl;
  final bool devMode;
  final bool enableBanner;
  final Color? bannerColor;

  EnvModel({
    required this.baseUrl,
    required this.devMode,
    required this.enableBanner,
    required this.bannerColor,
  });
}

enum EnvType {
  developer,
  production,
}
