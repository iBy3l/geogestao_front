import '/core/core.dart';

abstract interface class SignInStates {}

class SignInInitialStates extends SignInStates {}

class SignInLoadingStates extends SignInStates {}

class SignInSuccessStates extends SignInStates {}

class SignInSuccessMessageStates extends SignInStates {}

class SignInErrorStates extends SignInStates implements ErrorBaseState {
  @override
  final String message;

  SignInErrorStates({required this.message});
}
