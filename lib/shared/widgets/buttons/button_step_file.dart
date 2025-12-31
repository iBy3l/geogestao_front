import 'package:flutter/material.dart';
import '/core/core.dart';
import '/presentations/pages/update_file/controllers/update_file_controller.dart';
import '/shared/shared.dart';

class ButtonStepFile extends StatelessWidget {
  const ButtonStepFile({super.key, required this.onTap, required this.step, required this.color, required this.colorCard, required this.fontWeight, required this.coloricon});
  final UpdateFileStep step;
  final Color colorCard;
  final Color color;
  final Color coloricon;
  final FontWeight? fontWeight;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(8),
      splashColor: context.theme.colorScheme.primary.withAlpha(100),
      highlightColor: context.theme.colorScheme.primary.withAlpha(100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: step.isSelected != true ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: colorCard, width: 3),
            ),
            child: Center(
              child: step.isSelected
                  ? Icon(Icons.check, color: coloricon, size: 24)
                  : Text(
                      step.number,
                      style: context.theme.textTheme.headlineSmall?.copyWith(color: color, fontWeight: fontWeight),
                    ),
            ),
          ),
          SpaceWidget.extraSmall(),
          Text(
            step.title,
            style: context.theme.textTheme.bodyLarge?.copyWith(color: color, fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}
