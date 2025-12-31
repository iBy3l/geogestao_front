import '/domain/entities/forms_view/forms_view_entity.dart';

import '../../../../core/core.dart';

abstract interface class FormsViewStates {}

class FormsViewInitialStates extends FormsViewStates {}

class FormsViewLoadingStates extends FormsViewStates {}

class FormsViewSuccessStates extends FormsViewStates {}

class FormsViewLoadedStates extends FormsViewStates {
  final FormsViewEntity formsView;

  FormsViewLoadedStates(this.formsView);
}

class FormsViewErrorStates extends FormsViewStates implements ErrorBaseState {
  @override
  final String message;

  FormsViewErrorStates({required this.message});
}
