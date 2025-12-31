import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const SpaceWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) => SizedBox(height: height, width: width);

  factory SpaceWidget.extraSmall({double size = 4.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.small({double size = 10.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.medium({double size = 20.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.large({double size = 30.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.extraLarge({double size = 40.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.extraExtraLarge({double size = 50.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.extraExtraExtraLarge({double size = 60.0}) => SpaceWidget(height: size, width: size);
  factory SpaceWidget.expanded({double size = 1.0}) => SpaceWidget(height: size, width: size);
}
