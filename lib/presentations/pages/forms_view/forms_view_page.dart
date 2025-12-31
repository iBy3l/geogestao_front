import 'package:flutter/material.dart';

import '/core/sdk/src/reactive_state_manager/reactive_state_manager.dart';
import '/domain/entities/entities.dart';
import '/presentations/pages/forms/widgets/form_viewer_widget.dart';
import '../../../shared/shared.dart';
import 'controllers/forms_view_controller.dart';
import 'states/forms_view_state.dart';

class FormsViewScreen extends StatefulWidget {
  final FormsViewController controller;
  final bool isClientMode; // se true => cliente final respondendo

  const FormsViewScreen({super.key, required this.controller, this.isClientMode = false});

  @override
  State<FormsViewScreen> createState() => _FormsViewScreenState();
}

class _FormsViewScreenState extends State<FormsViewScreen> {
  String? formId;

  @override
  void initState() {
    super.initState();
    final uri = Uri.base;
    final segments = uri.pathSegments;
    formId = segments.isNotEmpty ? segments.last : null;

    if (formId != null) {
      widget.controller.fetch(FormsViewParam(instanceId: formId!));
    } else {
      debugPrint('⚠️ Nenhum ID encontrado na URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SelectionArea(
        child: BaseBuilder<FormsViewController, FormsViewStates>(
          controller: widget.controller,
          build: (context, state) {
            if (state is FormsViewLoadingStates) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (state is FormsViewErrorStates) {
              return Scaffold(body: Center(child: Text('Erro ao carregar formulário.')));
            }

            if (state is FormsViewLoadedStates) {
              final form = state.formsView;

              return FormViewer(
                elements: form.config.questions,
                mode: widget.isClientMode
                    ? EditableTextMode
                          .answer // cliente final
                    : EditableTextMode.answer, // usuário/membro
              );
            }

            return const Scaffold(body: Center(child: Text('Carregando formulário...')));
          },
        ),
      ),
    );
  }
}
