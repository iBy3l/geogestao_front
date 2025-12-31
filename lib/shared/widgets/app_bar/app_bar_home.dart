import 'package:flutter/material.dart';
import '/core/core.dart';

class AppBarPageHome extends StatelessWidget {
  final String nameuser;
  const AppBarPageHome({super.key, required this.nameuser});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: context.theme.primaryColor,
          child: Icon(context.icon.user, color: context.theme.colorScheme.onPrimary),
        ),
        Row(
          spacing: 4,
          children: [
            Text(
              "${context.text.hello},",
              style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline, fontWeight: FontWeight.bold),
            ),
            Text(
              nameuser,
              style: context.textTheme.titleMedium?.copyWith(color: context.theme.primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
