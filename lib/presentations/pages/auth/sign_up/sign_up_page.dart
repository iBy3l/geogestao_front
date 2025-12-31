import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/shared.dart';

import 'controllers/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController controller;
  const SignUpPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
      metas: controller.meta,
      child: Form(
        key: controller.formSignUp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(context.text.signInTitle, style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600)),
            SpaceWidget.small(),
            Text(context.text.signInSubtitle2, style: context.textTheme.labelMedium, textAlign: TextAlign.center),
            SpaceWidget.medium(),
            TextFormFieldWidget.name(context, width: 300, controller: controller.nameController, title: context.text.organizationName),
            SpaceWidget.small(),
            AutofillGroup(
              onDisposeAction: AutofillContextAction.commit,
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
            TextFormFieldWidget.passwordConfirm(context, width: 300, controller: controller.confirmPasswordController, passwordProvider: () => controller.passwordController.text),
            SpaceWidget.large(),
            ElevatedButtonWidget(fixedSize: Size(300, 50), text: context.text.signInButton, onPressed: () async => await controller.signUp(context)),
            SpaceWidget.large(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.text.signInAlreadyHaveAccount, style: context.textTheme.labelLarge),
                SpaceWidget.extraSmall(),
                TextButtonWidget(text: context.text.signIn, onPressed: controller.goToSignIn),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
