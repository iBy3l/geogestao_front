import '/domain/entities/forms_view/forms_view_entity.dart';

import '../../../../core/core.dart';

abstract interface class CreateFormsStates {}

class CreateFormsInitialStates extends CreateFormsStates {}

class CreateFormsLoadingStates extends CreateFormsStates {}

class CreateFormsSuccessStates extends CreateFormsStates {
  final FormsViewEntity formsView;
  CreateFormsSuccessStates(this.formsView);
}

class CreateFormsErrorStates extends CreateFormsStates implements ErrorBaseState {
  @override
  final String message;

  CreateFormsErrorStates({required this.message});
}
