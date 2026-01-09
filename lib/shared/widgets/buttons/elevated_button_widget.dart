import 'package:flutter/material.dart';

import '/core/core.dart';

class ElevatedButtonWidget extends StatefulWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.iconSufix,
    this.iconPrefix,
    this.fixedSize,
    this.enable = true,
    this.style,
  });

  final Future<void> Function()? onPressed;
  final String? text;
  final Widget? child;
  final IconData? iconSufix;
  final IconData? iconPrefix;
  final Size? fixedSize;
  final bool enable;
  final ButtonStyle? style;
  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  bool _isLoading = false;

  void _handlePress() async {
    if (_isLoading || widget.onPressed == null) return;
    setState(() => _isLoading = true);

    try {
      await widget.onPressed!();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    ButtonStyle styleFrom() {
      return ElevatedButton.styleFrom(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: widget.fixedSize ?? const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        fixedSize: widget.fixedSize,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return theme.colorScheme.outline.withValues(alpha: 0.5);
          }
          if (states.contains(WidgetState.hovered)) {
            return theme.colorScheme.primary.withValues(alpha: 0.85);
          }
          if (states.contains(WidgetState.pressed)) {
            return theme.colorScheme.primary.withValues(alpha: 0.75);
          }
          return theme.colorScheme.primary;
        }),
        foregroundColor: WidgetStateProperty.all(CustomColors.white),
        overlayColor: WidgetStateProperty.all(
          theme.colorScheme.primary.withValues(
            alpha: 0.1,
          ), // efeito de clique suave
        ),
      );
    }

    final child = _isLoading
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: theme.colorScheme.outline,
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              if (widget.iconPrefix != null)
                Icon(widget.iconPrefix, color: theme.colorScheme.onPrimary),
              if (widget.text != null)
                Text(
                  widget.text!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              if (widget.iconSufix != null)
                Icon(widget.iconSufix, color: theme.colorScheme.onPrimary),
            ],
          );

    return ElevatedButton(
      style: widget.style ?? styleFrom(),
      onPressed: widget.enable ? _handlePress : null,
      child: widget.child ?? child,
    );
  }
}
