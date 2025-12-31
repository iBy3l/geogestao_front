import '/core/core.dart';

abstract interface class EmailConfirmationState {}

class EmailConfirmationInitialStates extends EmailConfirmationState {}

class EmailConfirmationLoadingStates extends EmailConfirmationState {}

class EmailConfirmationSuccessStates extends EmailConfirmationState {}

class EmailConfirmationErrorStates extends EmailConfirmationState implements ErrorBaseState {
  @override
  final String message;

  EmailConfirmationErrorStates({required this.message});
}
