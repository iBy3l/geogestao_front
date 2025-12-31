import 'package:flutter/material.dart';

import '/core/core.dart';
import '/presentations/pages/forms/controllers/create_forms_controller.dart';
import '/presentations/pages/forms/widgets/draggable_form_item.dart';
import '/presentations/pages/forms/widgets/form_viewer_widget.dart';
import '/shared/shared.dart';

class CreateFormsPage extends StatefulWidget {
  final CreateFormsController controller;
  const CreateFormsPage({super.key, required this.controller});

  @override
  State<CreateFormsPage> createState() => _CreateFormsPageState();
}

class _CreateFormsPageState extends State<CreateFormsPage> {
  late CreateFormsController controller;
  @override
  void initState() {
    final args = Modular.args;
    controller = widget.controller;
    controller.id = args.params['id'];
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBuilder(
      controller: controller,
      build: (context, state) {
        return ResponsiveLayout(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _TopBar(controller: widget.controller),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SidebarList(controller: widget.controller),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.outline.withAlpha(100)),
                          ),
                          child: ValueListenableBuilder<List<ElementEntity>>(
                            valueListenable: widget.controller.selectedElementsNotifier,
                            builder: (_, list, __) {
                              if (list.isEmpty) {
                                return Center(child: Text('Adicione campos para começar', style: theme.textTheme.bodyMedium));
                              }
                              return FormViewer(elements: list, mode: EditableTextMode.create, globalTheme: widget.controller.globalTheme.value, onChanged: (answers) {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _ActionsPanel(controller: widget.controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//
// ================== TOPO ==================
//
class _TopBar extends StatelessWidget {
  final CreateFormsController controller;
  const _TopBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: t.colorScheme.primary.withAlpha(150), borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ElevatedButton.icon(icon: const Icon(Icons.add), label: const Text('Adicionar conteúdo'), onPressed: () => controller.openPalette(context)),
              const SizedBox(width: 8),

              // 🎨 Tema global — abre o diálogo
              ElevatedButton.icon(icon: const Icon(Icons.settings_applications_outlined), label: const Text('Configuração'), onPressed: () => _showThemeDialog(context, controller)),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              ElevatedButton.icon(icon: const Icon(Icons.remove_red_eye), label: const Text('Pré-visualizar'), onPressed: () => controller.openPreview(context)),
              ElevatedButton.icon(icon: const Icon(Icons.save), label: const Text('Rascunho'), onPressed: controller.saveForm),
              ElevatedButton.icon(icon: const Icon(Icons.publish), label: const Text('Publicar'), onPressed: () => controller.publishForm(context)),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Abre o Dialog de edição global de tema
  void _showThemeDialog(BuildContext context, CreateFormsController controller) {
    showDialog(
      context: context,
      builder: (context) => DefaultTabController(
        length: 2,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          insetPadding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
            child: Column(
              children: [
                // 🔹 Cabeçalho com abas
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(140),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(icon: Icon(Icons.tune), text: 'Opções'),
                      Tab(icon: Icon(Icons.color_lens), text: 'Tema'),
                    ],
                  ),
                ),

                // 🔹 Conteúdo
                Expanded(
                  child: TabBarView(
                    children: [
                      // ====== ABA 1 - OPÇÕES GERAIS ======
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: _FormOptionsEditor(controller: controller),
                      ),

                      // ====== ABA 2 - THEME EDITOR ======
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: _GlobalThemeEditor(controller: controller),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(240),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: ElevatedButton.icon(icon: const Icon(Icons.check), label: Text(context.text.saveChanges), onPressed: () => Navigator.pop(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// ================== SIDEBAR ==================

class _SidebarList extends StatelessWidget {
  final CreateFormsController controller;
  const _SidebarList({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SizedBox(
      width: 240,
      child: Container(
        decoration: BoxDecoration(
          color: t.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: t.colorScheme.outline.withAlpha(100)),
        ),
        child: Column(
          children: [
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: t.colorScheme.primary.withAlpha(140),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Text(context.text.fields, style: t.textTheme.titleMedium?.copyWith(color: t.colorScheme.onPrimary)),
            ),
            Expanded(
              child: ValueListenableBuilder<List<ElementEntity>>(
                valueListenable: controller.selectedElementsNotifier,
                builder: (_, list, __) {
                  if (list.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(context.text.addFields, style: t.textTheme.bodyMedium),
                      ),
                    );
                  }
                  return ReorderableListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: list.length,
                    buildDefaultDragHandles: false,
                    onReorder: controller.onReorder,
                    itemBuilder: (context, index) {
                      final element = list[index];
                      return DraggableFormItem(key: ValueKey(element.id), element: element, index: index, onRemove: () => controller.removeAt(index), onTap: (v) => controller.selectForEdit(v));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ================== AÇÕES ==================
//
class _ActionsPanel extends StatelessWidget {
  final CreateFormsController controller;
  const _ActionsPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SizedBox(
      width: 280,
      child: Container(
        decoration: BoxDecoration(
          color: t.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: t.colorScheme.outline.withAlpha(100)),
        ),
        child: Column(
          children: [
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: t.colorScheme.primary.withAlpha(140),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Text('Ações', style: t.textTheme.titleMedium?.copyWith(color: t.colorScheme.onPrimary)),
            ),
            Expanded(
              child: ValueListenableBuilder<ElementEntity?>(
                valueListenable: controller.selectedElementNotifier,
                builder: (_, el, __) {
                  if (el == null) {
                    return Center(child: Text('Selecione um campo', style: t.textTheme.bodyMedium));
                  }
                  return ElementConfigPanel(element: el, onChanged: controller.updateElement);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlobalThemeEditor extends StatefulWidget {
  final CreateFormsController controller;
  const _GlobalThemeEditor({required this.controller});

  @override
  State<_GlobalThemeEditor> createState() => _GlobalThemeEditorState();
}

class _GlobalThemeEditorState extends State<_GlobalThemeEditor> with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    _tab = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return ValueListenableBuilder<GlobalFormTheme>(
      valueListenable: widget.controller.globalTheme,
      builder: (_, theme, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Configurações de Tema', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(height: 24),
            TabBar(
              controller: _tab,
              labelColor: t.colorScheme.primary,
              indicatorColor: t.colorScheme.primary,
              tabs: const [
                Tab(icon: Icon(Icons.text_fields), text: 'Texto'),
                Tab(icon: Icon(Icons.format_paint), text: 'Fundo'),
                Tab(icon: Icon(Icons.radio_button_checked), text: 'Botão'),
              ],
            ),

            // Título
            _sectionTitle('Título'),
            _sizeRow(context, theme.sizeTitle, (v) => widget.controller.setTheme(theme.copyWith(sizeTitle: v))),
            _alignRow(context, theme.alignTitle, (v) => widget.controller.setTheme(theme.copyWith(alignTitle: v))),
            const SizedBox(height: 12),

            // Descrição
            _sectionTitle('Descrição'),
            _sizeRow(context, theme.sizeDescription, (v) => widget.controller.setTheme(theme.copyWith(sizeDescription: v))),
            _alignRow(context, theme.alignDescription, (v) => widget.controller.setTheme(theme.copyWith(alignDescription: v))),
            const SizedBox(height: 12),

            // Resposta
            _sectionTitle('Resposta'),
            _sizeRow(context, theme.sizeAnswer, (v) => widget.controller.setTheme(theme.copyWith(sizeAnswer: v))),
            _alignRow(context, theme.alignAnswer, (v) => widget.controller.setTheme(theme.copyWith(alignAnswer: v))),
            const SizedBox(height: 24),

            // Botão fechar
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(icon: const Icon(Icons.check), label: const Text('Aplicar'), onPressed: () => Navigator.pop(context)),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String label) => Align(
    alignment: Alignment.centerLeft,
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
  );

  Widget _sizeRow(BuildContext c, TextSize current, ValueChanged<TextSize> onChanged) {
    return Row(
      children: [
        const SizedBox(width: 88, child: Text('Tamanho')),
        const SizedBox(width: 8),
        DropdownButton<TextSize>(
          value: current,
          items: const [
            DropdownMenuItem(value: TextSize.small, child: Text('Pequeno')),
            DropdownMenuItem(value: TextSize.medium, child: Text('Médio')),
            DropdownMenuItem(value: TextSize.large, child: Text('Grande')),
          ],
          onChanged: (v) => onChanged(v ?? current),
        ),
      ],
    );
  }

  Widget _alignRow(BuildContext c, TextAlign current, ValueChanged<TextAlign> onChanged) {
    return Row(
      children: [
        const SizedBox(width: 88, child: Text('Alinhamento')),
        const SizedBox(width: 8),
        DropdownButton<TextAlign>(
          value: current,
          items: const [
            DropdownMenuItem(value: TextAlign.left, child: Text('Esquerda')),
            DropdownMenuItem(value: TextAlign.center, child: Text('Centro')),
            DropdownMenuItem(value: TextAlign.right, child: Text('Direita')),
          ],
          onChanged: (v) => onChanged(v ?? current),
        ),
      ],
    );
  }
}

class _FormOptionsEditor extends StatelessWidget {
  final CreateFormsController controller;
  const _FormOptionsEditor({required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.text.formSettings, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

        // 🔹 Nome do formulário
        TextField(
          controller: TextEditingController(text: controller.formDataNotifier.value?.name ?? ''),
          decoration: InputDecoration(labelText: context.text.formTitle, border: InputBorder.none),
          onChanged: (v) => controller.formDataNotifier.value = controller.formDataNotifier.value?.copyWith(name: v),
        ),

        // 🔹 Descrição opcional
        TextField(
          controller: TextEditingController(text: controller.welcomeDescription ?? ''),
          maxLines: 3,
          decoration: InputDecoration(labelText: context.text.formDescription, border: OutlineInputBorder()),
          onChanged: (v) => controller.welcomeDescription = v,
        ),

        // 🔹 Opção de branding
        SwitchListTile(title: const Text('Mostrar marca Sympllizy no rodapé'), value: false, onChanged: (v) => {}),

        // 🔹 Botão de boas-vindas
        // SwitchListTile(
        //   title: const Text('Usar tela de boas-vindas'),
        //   value: controller.useWelcome,
        //   onChanged: (v) {
        //     controller.useWelcome = v;
        //     controller.notifyListeners();
        //   },
        // ),
        // if (controller.useWelcome) ...[
        //   const SizedBox(height: 12),
        //   TextField(
        //     controller: TextEditingController(text: controller.welcomeTitle ?? ''),
        //     decoration: const InputDecoration(
        //       labelText: 'Título da tela inicial',
        //       border: OutlineInputBorder(),
        //     ),
        //     onChanged: (v) => controller.welcomeTitle = v,
        //   ),
        //   const SizedBox(height: 12),
        //   TextField(
        //     controller: TextEditingController(text: controller.welcomeDescription ?? ''),
        //     maxLines: 3,
        //     decoration: const InputDecoration(
        //       labelText: 'Descrição da tela inicial',
        //       border: OutlineInputBorder(),
        //     ),
        //     onChanged: (v) => controller.welcomeDescription = v,
        //   ),
        // ],
      ],
    );
  }
}
