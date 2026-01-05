import 'package:flutter/material.dart';

class AnimatedMapButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final bool enabled;

  const AnimatedMapButton({super.key, required this.icon, required this.onTap, this.enabled = true});

  @override
  State<AnimatedMapButton> createState() => _AnimatedMapButtonState();
}

class _AnimatedMapButtonState extends State<AnimatedMapButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: widget.enabled ? 1 : 0.4,
          duration: const Duration(milliseconds: 200),
          child: Material(
            elevation: 4,
            color: Colors.white,
            shape: const CircleBorder(),
            child: Padding(padding: const EdgeInsets.all(10), child: widget.icon),
          ),
        ),
      ),
    );
  }
}
