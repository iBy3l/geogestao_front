sealed class BaseWhich<TError, TResult> {
  const BaseWhich();

  T ways<T>(T Function(TResult result) ifResult, T Function(TError erro) ifError) {
    return switch (this) {
      IsError error => ifError(error.value),
      IsResult result => ifResult(result.value),
    };
  }

  BaseWhich<TError, T> map<T>(T Function(TResult result) ifResult) {
    return switch (this) {
      IsResult result => IsResult(result.value),
      IsError error => IsError(error.value),
    };
  }

  BaseWhich<T, TResult> mapError<T>(T Function(TError erro) ifError) {
    return switch (this) {
      IsError error => IsError(error.value),
      IsResult result => IsResult(result.value),
    };
  }

  TResult getResultOrThrow() {
    return switch (this) {
      IsError error => throw error.value,
      IsResult result => result.value,
    };
  }

  TResult getResultOrDefault(TResult Function(TError erro) ifError) {
    return switch (this) {
      IsError error => ifError(error.value),
      IsResult result => result.value,
    };
  }

  TResult? getResultOrNull() {
    return switch (this) {
      IsError _ => null,
      IsResult result => result.value,
    };
  }

  TError? exceptionOrNull() {
    return switch (this) {
      IsError erro => erro.value,
      IsResult _ => null,
    };
  }

  BaseWhich<TError, TResult> recovery(BaseWhich<TError, TResult> Function(TError erro) ifError) {
    return switch (this) {
      IsError erro => ifError(erro.value),
      IsResult result => IsResult(result.value),
    };
  }

  BaseWhich<TResult, TError> swap() {
    return switch (this) {
      IsError erro => IsResult(erro.value),
      IsResult result => IsError(result.value),
    };
  }

  void onFailure(Function(TError erro) ifError) {
    if (isError()) {
      ifError((this as IsError).value);
    }
  }

  void onSuccess(Function(TResult result) ifResult) {
    if (isSuccess()) {
      ifResult((this as IsResult).value);
    }
  }

  BaseWhich<TError, TResult> flatMap(
    void Function(TResult result) ifResult,
    void Function(TError erro) ifError,
  ) {
    return switch (this) {
      IsError erro => IsError(erro.value),
      IsResult result => IsResult(result.value),
    };
  }

  bool isSuccess() => this is IsResult;

  bool isError() => this is IsError;
}

class IsError<TError, TResult> extends BaseWhich<TError, TResult> {
  final TError value;
  const IsError(this.value);
}

class IsResult<TError, TResult> extends BaseWhich<TError, TResult> {
  final TResult value;
  const IsResult(this.value);
}
