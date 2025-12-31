import 'package:flutter/material.dart';

import 'env.dart';

class FlavorBanner extends StatefulWidget {
  final Widget child;
  final EnvType envType;

  const FlavorBanner({
    super.key,
    required this.child,
    required this.envType,
  });

  @override
  State<FlavorBanner> createState() => _FlavorBannerState();
}

class _FlavorBannerState extends State<FlavorBanner> {
  late EnvType envType;
  late String bannerText;
  late Color bannerColor;

  @override
  void initState() {
    super.initState();
    envType = widget.envType;
    if (envType == EnvType.developer) {
      bannerText = 'DEV';
      bannerColor = Colors.red;
    } else {
      bannerText = '';
      bannerColor = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: envType == EnvType.developer,
      replacement: widget.child,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          color: bannerColor,
          message: bannerText,
          location: BannerLocation.topEnd,
          textStyle: TextStyle(
            color: (HSLColor.fromColor(bannerColor).lightness < 0.8) ? Colors.white : Colors.black87,
            fontSize: 12.0 * 0.85,
            fontWeight: FontWeight.w900,
            height: 1.0,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
