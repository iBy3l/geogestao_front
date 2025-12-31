import '/core/core.dart';

abstract interface class UpdateFileStates {}

class UpdateFileInitialStates extends UpdateFileStates {}

class UpdateFileLoadingStates extends UpdateFileStates {}

class UpdateFileSuccessStates extends UpdateFileStates {}

class UpdateFileErrorStates extends UpdateFileStates implements ErrorBaseState {
  @override
  final String message;

  UpdateFileErrorStates({required this.message});
}
