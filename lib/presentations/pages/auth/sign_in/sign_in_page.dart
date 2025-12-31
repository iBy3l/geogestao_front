import 'package:flutter/material.dart';

import '/core/core.dart';
import '/shared/shared.dart';
import 'controllers/sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  final SignInController controller;
  const SignInPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      metas: controller.meta,
      child: Form(
        key: controller.formSignIn,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(context.text.signInTitle, style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600)),
            SpaceWidget.small(),
            Text(context.text.signInSubtitle2, style: context.textTheme.labelMedium, textAlign: TextAlign.center),
            SpaceWidget.medium(),
            AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormFieldWidget.email(context, width: 300, controller: controller.emailController),
                  SpaceWidget.small(),
                  TextFormFieldWidget.password(context, width: 300, controller: controller.passwordController),
                ],
              ),
            ),
            SpaceWidget.small(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextButtonWidget(alignment: Alignment.centerRight, text: context.text.signInForgotPassword, onPressed: controller.signInForgotPassword),
            ),
            SpaceWidget.large(),
            ElevatedButtonWidget(fixedSize: Size(300, 50), text: context.text.signInButton, onPressed: () async => await controller.login(context)),
            SpaceWidget.large(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.text.signInRegister, style: context.textTheme.labelLarge),
                SpaceWidget.extraSmall(),
                TextButtonWidget(text: context.text.signInRegisterButton, onPressed: controller.toGoRegister),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
