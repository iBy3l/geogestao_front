import '/domain/entities/entities.dart';
import '/domain/usecases/usecases.dart';
import '../../../../core/core.dart';
import '../states/forms_view_state.dart';

class FormsViewController extends BaseController<FormsViewStates> {
  final FormsViewUsecase formsViewUsecase;

  FormsViewController(this.formsViewUsecase) : super(FormsViewInitialStates());

  @override
  void init() {}

  Future<void> fetch(FormsViewParam param) async {
    emit(FormsViewLoadingStates());

    final result = await formsViewUsecase(param);

    result.ways(
      (success) => emit(FormsViewLoadedStates(success)),
      (error) => emit(FormsViewErrorStates(message: error.message)),
    );
  }
}
