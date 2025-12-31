// create_forms_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import '/core/core.dart';
import '/domain/entities/forms/access_mode.dart';
import '/domain/entities/forms/forms_param.dart';
import '/domain/entities/forms_view/forms_view_entity.dart';
import '/domain/entities/forms_view/forms_view_param.dart';
import '/domain/usecases/usecases.dart';
import '/presentations/pages/forms/widgets/form_elements_palette_widget.dart';
import '/shared/shared.dart';

import '../states/create_forms_state.dart';
import '../widgets/form_viewer_widget.dart';

class CreateFormsController extends BaseController<CreateFormsStates> {
  final FormsViewUsecase formsViewUsecase;
  final CreateFormsUsecase formsUsecase;
  final UpdateFormsUsecase updateFormsUsecase;
  CreateFormsController(this.formsUsecase, this.formsViewUsecase, this.updateFormsUsecase) : super(CreateFormsInitialStates());

  /// Lista de elementos do formulário
  final ValueNotifier<List<ElementEntity>> selectedElementsNotifier = ValueNotifier<List<ElementEntity>>([]);

  /// Elemento atualmente selecionado
  final ValueNotifier<ElementEntity?> selectedElementNotifier = ValueNotifier<ElementEntity?>(null);

  /// Tema global do formulário
  final ValueNotifier<GlobalFormTheme> globalTheme = ValueNotifier(const GlobalFormTheme());

  ValueNotifier<FormsViewEntity?> formDataNotifier = ValueNotifier<FormsViewEntity?>(null);

  /// Página de boas-vindas (opcional)
  String? welcomeTitle;
  String? welcomeDescription;
  String? endTitle;
  String? endDescription;
  String? id;

  @override
  void init() async {
    if (id != null) {
      await getDataForm(FormsViewParam(instanceId: id!));
    }
  }

  bool _isAlcon(ElementEntity e) => (e.label.trim().toLowerCase() == 'alcon');
  bool _isAndy(ElementEntity e) => (e.label.trim().toLowerCase() == 'andy');

  List<ElementEntity> _normalizeAlconAndyOrder(List<ElementEntity> src) {
    ElementEntity? alcon;
    ElementEntity? andy;
    final others = <ElementEntity>[];

    for (final e in src) {
      if (_isAlcon(e)) {
        alcon = e;
      } else if (_isAndy(e)) {
        andy = e;
      } else {
        others.add(e);
      }
    }

    final ordered = <ElementEntity>[];
    if (alcon != null) ordered.add(alcon); // Alcon sempre 1º
    ordered.addAll(others); // Todos os demais no meio
    if (andy != null) ordered.add(andy); // Andy sempre último

    // reindexa positions
    for (int i = 0; i < ordered.length; i++) {
      ordered[i] = ordered[i].copyWith(position: i);
    }
    return ordered;
  }

  void _applyNormalized(List<ElementEntity> list) {
    selectedElementsNotifier.value = _normalizeAlconAndyOrder(list);
  }

  Future<void> getDataForm(FormsViewParam param) async {
    emit(CreateFormsLoadingStates());

    final result = await formsViewUsecase(param);

    result.ways((success) {
      formDataNotifier.value = success;
      final loaded = success.config.questions;
      _applyNormalized(loaded); // <-- garante a ordem logo na chegada
      globalTheme.value = success.theme ?? const GlobalFormTheme();
      notifyListeners();
      emit(CreateFormsSuccessStates(success));
    }, (error) => emit(CreateFormsErrorStates(message: error.message)));
  }

  // =====================================================
  // MUTATIONS
  // =====================================================

  void addElement(ElementEntity element) {
    final list = [...selectedElementsNotifier.value, element];
    _applyNormalized(list);
    // Seleciona o item recém adicionado (ele pode “mover” após normalizar)
    final added = selectedElementsNotifier.value.firstWhere((e) => e.id == element.id, orElse: () => element);
    selectedElementNotifier.value = added;
  }

  void removeAt(int index) {
    final list = [...selectedElementsNotifier.value];
    final removed = list.removeAt(index);
    if (selectedElementNotifier.value?.id == removed.id) {
      selectedElementNotifier.value = null;
    }
    _applyNormalized(list);
  }

  void selectForEdit(ElementEntity el) {
    selectedElementNotifier.value = el;
    notifyListeners();
  }

  void updateElement(ElementEntity updated) {
    final list = [...selectedElementsNotifier.value];
    final idx = list.indexWhere((e) => e.id == updated.id);
    if (idx != -1) {
      list[idx] = updated;
      _applyNormalized(list);
      selectedElementNotifier.value = updated;
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    final list = [...selectedElementsNotifier.value];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    _applyNormalized(list);
  }

  // =====================================================
  // ELEMENTOS: adicionar a partir da paleta
  // =====================================================

  void openPalette(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 480,
          height: 600,
          child: FormElementsPaletteWidget(
            onSelect: (element) {
              addElement(element);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  // =====================================================
  // TEMA GLOBAL
  // =====================================================

  void setTheme(GlobalFormTheme theme) {
    globalTheme.value = theme;
  }

  // =====================================================
  // PREVIEW
  // =====================================================

  void openPreview(BuildContext context) {
    final elements = selectedElementsNotifier.value;
    if (elements.isEmpty) return;
    showDialog(
      context: context,
      builder: (_) => Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pré-visualização'),
            leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
          ),
          body: FormViewer(elements: elements, mode: EditableTextMode.answer, globalTheme: globalTheme.value, welcomeTitle: welcomeTitle, welcomeDescription: welcomeDescription),
        ),
      ),
    );
  }

  // =====================================================
  // PERSISTÊNCIA / SUPABASE
  // =====================================================

  // Future<void> fetch() async {
  //   await saveForm();
  //   final result = await formsUsecase(
  //     FormsParam(
  //       name: formDataNotifier.value?.name ?? '',
  //       config: {'questions': stepsJson},
  //       accessMode: accessMode,
  //     ),
  //   );

  //   result.ways((success) => debugPrint('✅ Form enviado com sucesso'), (error) {
  //     emit(CreateFormsErrorStates(message: error.message));
  //   });
  // }

  final AccessMode accessMode = AccessMode.public;

  Future<void> updateForm() async {
    await saveForm();
    final result = await updateFormsUsecase(FormsParam(id: id, name: formDataNotifier.value?.name ?? '', config: {'questions': stepsJson}, accessMode: accessMode));

    result.ways((success) => debugPrint('✅ Form atualizado com sucesso'), (error) {
      emit(CreateFormsErrorStates(message: error.message));
    });
  }

  /// JSON pronto para enviar ao Supabase
  final List<Map<String, dynamic>> stepsJson = [];

  Future<void> saveForm() async {
    stepsJson.clear();

    for (final el in selectedElementsNotifier.value) {
      final elementJson = {
        'id': el.id,
        'type': el.type.asString,
        'position': el.position,
        'label': el.label,
        'title': el.title,
        'description': el.description,
        'icon': el.icon.codePoint,
        'color': el.color?.value,
        'options': el.options.map((e) => e.toJson()).toList(),
        'properties': el.properties,
      };

      stepsJson.add(elementJson);
    }

    final formJson = {
      'form': {
        'name': formDataNotifier.value?.name ?? 'Untitled Form',
        'welcome_title': welcomeTitle,
        'welcome_description': welcomeDescription,
        'theme': {
          'font_family': globalTheme.value.fontFamily,
          'color_title': globalTheme.value.colorTitle.value,
          'color_description': globalTheme.value.colorDescription.value,
          'color_answer': globalTheme.value.colorAnswer.value,
          'size_title': globalTheme.value.sizeTitle.name,
          'size_description': globalTheme.value.sizeDescription.name,
          'size_answer': globalTheme.value.sizeAnswer.name,
        },
        'steps': stepsJson,
      },
    };

    final jsonString = jsonEncode(formJson);
    debugPrint(jsonString);
    // await supabase.from('forms').insert({'data': formJson});
  }

  // =====================================================
  // PUBLICAR (exemplo)
  // =====================================================

  Future<void> publishForm(BuildContext context) async {
    await saveForm();
    await updateForm();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Formulário publicado!')));
  }
}
