import 'package:flutter/material.dart';
import '/core/extensions/context_extensions.dart';

import '../themes/themes.dart';

class BaseForm extends StatelessWidget {
  final Widget child;
  final BaseFormTheme? theme;

  const BaseForm({super.key, required this.child, this.theme});

  bool _isMobile(BuildContext context) => MediaQuery.of(context).size.width < 700;

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);
    final activeTheme = theme ?? BaseFormTheme.defaultTheme(context);

    return Container(
      width: context.sizewidth,
      height: context.sizeheight,
      color: activeTheme.backgroundColor,
      child: SafeArea(
        child: SelectionArea(
          child: Center(
            child: SingleChildScrollView(
              padding: isMobile ? const EdgeInsets.all(16) : activeTheme.padding,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: activeTheme.maxWidth, minHeight: context.sizeheight * 0.7),
                  child: AnimatedContainer(duration: const Duration(milliseconds: 300), alignment: activeTheme.alignment, child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
