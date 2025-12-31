import 'package:flutter/material.dart';

import '/core/core.dart';
import '/domain/usecases/usecases.dart';
import '/presentations/pages/pages.dart';

class SignUpController extends BaseController<SignUpStates> {
  final SignUpUsecase signUpUsecase;
  final InsertDataUserUsecase insertDataUserUsecase;
  SignUpController(this.insertDataUserUsecase, this.signUpUsecase) : super(SignUpInitialStates());

  GlobalKey<FormState> formSignUp = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool termsAccepted = false;
  bool obscurePassword = true;

  Meta meta = Meta(
    title: 'Crie sua conta',
    description: 'Crie sua conta para acessar todos os recursos do Sympllizy',
    keywords: 'sympllizy, sign up, register, authentication, spreadsheet data analysis',
    author: 'Your Name',
    viewport: 'width=device-width, initial-scale=1',
    robots: 'index, follow',
    ogTitle: 'Auth Template',
    ogDescription: 'This is the auth template',
    ogImage: 'assets/images/logos/logo_sympllizy.png',
    ogUrl: 'https://sympllizy.com/auth/sign-up/',
    ogType: 'website',
    ogSiteName: 'Sympllizy',
    ogLocale: 'en_US',
    ogLocaleAlternate: 'es_ES',
    h1: 'Sympllizy',
    h2: 'Welcome to Sympllizy',
    h3: 'Your task management platform',
    h4: 'Get started with Sympllizy',
    h5: 'Manage your tasks and projects efficiently',
    h6: 'Join us today',
  );

  @override
  void init() async {}

  void updateTermsAccepted() {
    termsAccepted = !termsAccepted;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    if (formSignUp.currentState?.validate() == false) return;
    final result = await signUpUsecase(SignUpParamUsername(email: emailController.text, password: passwordController.text));
    result.ways((successs) {
      successMensage(context, context.text.accountCreated);
      formSignUp.currentState?.save();
      formSignUp.currentState?.reset();
      Modular.to.pushNamedAndRemoveUntil(EmailConfirmationDependency.routePath, (_) => false, arguments: {'email': successs.email});
    }, (error) {
      errorMessage(context, error.message);
    });
  }

  Future<void> insertDataUser(BuildContext context, String id) async {
    final result = await insertDataUserUsecase(InsertDataUserParamUsername(id: id, name: nameController.text, accepted: termsAccepted));
    result.ways((successs) {}, (error) {
      errorMessage(context, error.message);
    });
  }

  void goToSignIn() {
    Modular.to.pushReplacementNamed(SignInDependency.routePath);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
