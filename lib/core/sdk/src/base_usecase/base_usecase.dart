import '/core/core.dart';

abstract class BaseUsecase<Params, Result> {
  Future<BaseWhich<BaseFailure, Result>> call(Params param);
}
