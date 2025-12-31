import 'package:flutter/material.dart';
import '/core/core.dart';

class TextButtonWidget extends StatefulWidget {
  const TextButtonWidget({super.key, this.onPressed, required this.text, this.alignment, this.enable = true});

  final Function()? onPressed;
  final String text;
  final AlignmentGeometry? alignment;
  final bool enable;

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment ?? Alignment.center,
      child: InkWell(
        onTap: widget.enable
            ? () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
              }
            : null,
        onHover: widget.enable
            ? (value) {
                setState(() {
                  isHovering = value;
                });
              }
            : null,
        hoverColor: Colors.transparent,
        child: Text(
          widget.text,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.theme.colorScheme.primary,
            fontSize: 14,
            decoration: isHovering ? TextDecoration.underline : TextDecoration.none,
            decorationColor: context.theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
