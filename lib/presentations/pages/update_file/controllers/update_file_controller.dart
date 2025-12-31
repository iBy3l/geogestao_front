import 'dart:html' as html;

import '/core/core.dart';
import '/domain/entities/entities.dart';
import '/domain/usecases/usecases.dart';
import '../states/update_file_state.dart';

class UpdateFileController extends BaseController<UpdateFileStates> {
  final UpdateFileUsecase updateFileUsecase;
  UpdateFileController(this.updateFileUsecase) : super(UpdateFileInitialStates());

  int selectedStepIndex = 0;

  html.File? selectedFile;
  html.File? selectedFileFinal;
  List<UpdateFileStep> steps = [
    UpdateFileStep(number: '1', title: 'Upload', isSelected: false),
    UpdateFileStep(number: '2', title: 'Configurar Colunas', isSelected: false),
    UpdateFileStep(number: '3', title: 'Regras', isSelected: false),
  ];
  void onStepSelected(int index) {
    if (index < 0 || index >= steps.length) return;
    selectedStepIndex = index;
  }

  @override
  void init() {}

  Future<void> fetch() async {
    final result = await updateFileUsecase(UpdateFileParam());
    result.ways((successs) {}, (error) {});
  }
}

class UpdateFileStep {
  final String number;
  final String title;
  bool isSelected;

  UpdateFileStep({required this.number, required this.title, this.isSelected = false});
}
