import 'package:flutter/material.dart';
import '/core/core.dart';

class ImageLoadindWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final double? borderRadius;

  const ImageLoadindWidget({super.key, this.width, this.height, this.borderRadius});

  @override
  State<ImageLoadindWidget> createState() => _ImageLoadindWidgetState();
}

class _ImageLoadindWidgetState extends State<ImageLoadindWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, -0.3),
              end: Alignment(1.0 + 2.0 * _controller.value, 0.3),
              colors: [context.theme.colorScheme.primary.withValues(alpha: 0.1), context.theme.colorScheme.primary.withValues(alpha: 0.3), context.theme.colorScheme.primary.withValues(alpha: 0.5)],
              stops: const [0.1, 0.5, 0.9],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width ?? double.infinity,
            height: widget.height ?? 200,
            decoration: BoxDecoration(color: context.theme.colorScheme.primary.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(widget.borderRadius ?? 12)),
          ),
        );
      },
    );
  }
}
