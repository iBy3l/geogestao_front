interface class BaseState {}

interface class LoadingBaseState extends BaseState {}

interface class ErrorBaseState extends BaseState {
  final String message;

  ErrorBaseState({required this.message});
}

interface class SuccessBaseState extends BaseState {}
