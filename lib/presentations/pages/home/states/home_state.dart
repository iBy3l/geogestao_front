import '/core/core.dart';

abstract interface class HomeState {}

class HomeInitialStates extends HomeState {}

class HomeLoadingStates extends HomeState {}

class HomeSuccessStates extends HomeState {}

class HomeErrorStates extends HomeState implements ErrorBaseState {
  @override
  final String message;

  HomeErrorStates({required this.message});
}
