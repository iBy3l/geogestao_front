import 'package:flutter/material.dart';
import '/core/core.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isBoxShadow;
  const CardWidget({super.key, this.child, this.width, this.height, this.padding, this.isBoxShadow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: .5),
        boxShadow: isBoxShadow ? [BoxShadow(color: context.theme.colorScheme.outline, blurRadius: 4, offset: const Offset(0, 2))] : [],
      ),
      padding: padding ?? const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
