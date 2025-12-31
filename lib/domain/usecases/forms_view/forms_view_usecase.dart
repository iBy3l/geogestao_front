import '../../../core/core.dart';
import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

abstract class FormsViewUsecase extends BaseUsecase<FormsViewParam, FormsViewEntity> {}

class FormsViewUsecaseImpl extends FormsViewUsecase {
  final FormsViewRepository repository;

  FormsViewUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, FormsViewEntity>> call(FormsViewParam param) async {
    return await repository.getFormGate(param: param);
  }
}
