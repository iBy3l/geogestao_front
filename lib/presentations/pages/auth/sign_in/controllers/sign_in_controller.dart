import 'package:flutter/material.dart';

import '/core/core.dart';
import '/domain/domain.dart';
import '../../../pages.dart';

class SignInController extends BaseController<SignInStates> {
  final SignInUsecase _signInUsecase;
  SignInController(this._signInUsecase) : super(SignInInitialStates());

  @override
  void init() async {}

  Meta meta = Meta(
    title: 'Acesse sua conta',
    description: 'Insira suas credenciais para acessar sua conta',
    keywords:
        'GeoGestão, sign in, login, authentication, spreadsheet data analysis',
    author: 'Your Name',
    viewport: 'width=device-width, initial-scale=1',
    robots: 'index, follow',
    ogTitle: 'Auth Template',
    ogDescription: 'This is the auth template',
    ogImage: 'assets/images/logos/logo_GeoGestão.png',
    ogUrl: 'https://GeoGestão.com/auth/sign-in/',
    ogType: 'website',
    ogSiteName: 'GeoGestão',
    ogLocale: 'en_US',
    ogLocaleAlternate: 'es_ES',
    h1: 'GeoGestão',
    h2: 'Welcome to GeoGestão',
    h3: 'Your task management platform',
    h4: 'Get started with GeoGestão',
    h5: 'Manage your tasks and projects efficiently',
    h6: 'Join us today',
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formSignIn = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    if (formSignIn.currentState!.validate()) {
      emit(SignInLoadingStates());
      final result = await _signInUsecase(
        AuthParam(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      result.ways(
        (user) async {
          await storage.saveToken(user.accessToken);
          await storage.saveUuid(user.user.id);
          await storage.saveRefreshToken(user.refreshToken);
          await Modular.to.pushReplacementNamed(HomeDependency.routeName);
        },
        (failure) {
          errorMessage(context, failure.title);
        },
      );
    }
  }

  void toGoRegister() {
    Modular.to.pushReplacementNamed(SignUpDependency.routePath);
  }

  void signInForgotPassword() {}

  void toGoTermsOfService() {}
  void toGoPrivacyPolicy() {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formSignIn.currentState?.reset();
    super.dispose();
  }
}
