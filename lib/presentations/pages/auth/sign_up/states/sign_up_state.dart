import '/core/core.dart';

abstract interface class SignUpStates {}

class SignUpInitialStates extends SignUpStates {}

class SignUpLoadingStates extends SignUpStates {}

class SignUpSuccessStates extends SignUpStates {}

class SignUpErrorStates extends SignUpStates implements ErrorBaseState {
  @override
  final String message;

  SignUpErrorStates({required this.message});
}
