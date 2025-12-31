abstract class IResult<FAILURE, SUCCESS> {
  bool get isSuccess;
  bool get isFailure;
  SUCCESS get getSuccess;
  FAILURE get getFailure;
}

class Result<FAILURE extends ApplicationException, SUCCESS> implements IResult<FAILURE, SUCCESS> {
  final SUCCESS? success;
  final FAILURE? failure;

  Result.success(this.success) : failure = null;
  Result.failure(this.failure) : success = null;

  @override
  bool get isSuccess => success != null;

  @override
  bool get isFailure => failure != null;

  @override
  SUCCESS get getSuccess => success!;

  @override
  FAILURE get getFailure => failure!;

  @override
  String toString() => isSuccess ? 'Success: $success' : 'Failure: $failure';
}

class ApplicationException implements Exception {
  final String message;
  ApplicationException(this.message);

  @override
  String toString() => message;
}
