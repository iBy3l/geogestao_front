import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/shared.dart';

import 'controllers/email_confirmation_controller.dart';

class EmailConfirmationPage extends StatefulWidget {
  final String email;
  final EmailConfirmationController controller;
  const EmailConfirmationPage({super.key, required this.controller, required this.email});

  @override
  State<EmailConfirmationPage> createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  @override
  void initState() {
    if (widget.email.isEmpty) {
      widget.controller.goToSignIn();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(context.icon.email, color: context.theme.colorScheme.primary),
              SpaceWidget.extraSmall(),
              Text(context.text.verifyYourEmail, style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          SpaceWidget.small(),
          Text('${context.text.verifyYourEmailSubtitle}:', style: context.textTheme.labelMedium, textAlign: TextAlign.center),
          SpaceWidget.medium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.email, style: context.textTheme.labelMedium!.copyWith(color: context.theme.colorScheme.primary))],
          ),
          SpaceWidget.medium(),
          Container(
            width: context.sizewidth * 0.8,
            decoration: BoxDecoration(color: context.theme.colorScheme.tertiary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: context.theme.colorScheme.tertiary),
                SpaceWidget.medium(),
                Expanded(
                  child: Text(context.text.accountCreatedSuccessfully, style: context.textTheme.labelMedium!.copyWith(color: context.theme.colorScheme.tertiary)),
                ),
              ],
            ),
          ),
          SpaceWidget.medium(),
          Container(
            width: context.sizewidth * 0.8,
            decoration: BoxDecoration(color: context.theme.colorScheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceWidget.extraSmall(),
                Text(
                  context.text.nextSteps,
                  style: context.textTheme.labelLarge!.copyWith(color: context.theme.colorScheme.primary, fontWeight: FontWeight.bold),
                ),
                SpaceWidget.medium(),
                Text(context.text.checkYourEmail, style: context.textTheme.labelLarge!.copyWith(color: context.theme.colorScheme.primary)),
                SpaceWidget.small(),
                Text(context.text.openVerificationEmail, style: context.textTheme.labelLarge!.copyWith(color: context.theme.colorScheme.primary)),
                SpaceWidget.small(),
                Text(context.text.clickVerificationLink, style: context.textTheme.labelLarge!.copyWith(color: context.theme.colorScheme.primary)),
                SpaceWidget.extraSmall(),
              ],
            ),
          ),
          SpaceWidget.large(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.text.signInBackToLogin, style: context.textTheme.labelLarge),
              SpaceWidget.extraSmall(),
              TextButtonWidget(text: context.text.signIn, onPressed: widget.controller.goToSignIn),
            ],
          ),
        ],
      ),
    );
  }
}
