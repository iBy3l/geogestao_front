// form_viewer.dart
import 'package:flutter/material.dart';

import '../../../../shared/form/forms.dart';

// Reusa seu EditableTextContent se quiser. Abaixo uso Text/Inputs diretos p/ clareza.

class FormViewer extends StatefulWidget {
  final List<ElementEntity> elements;
  final EditableTextMode mode;
  final GlobalFormTheme globalTheme;

  /// Welcome (opcional). Se não quiser, passe null.
  final String? welcomeTitle;
  final String? welcomeDescription;
  final String startButtonText;

  /// Callback quando respostas mudam (no modo Answer ou Create).
  final ValueChanged<Map<String, dynamic>>? onChanged;

  /// AutoFocus no título do elemento ao abrir (para Create)
  final bool autoFocus;
  final String? endTitle;
  final String? endDescription;

  const FormViewer({
    super.key,
    required this.elements,
    this.mode = EditableTextMode.view,
    this.globalTheme = const GlobalFormTheme(),
    this.welcomeTitle,
    this.welcomeDescription,
    this.startButtonText = 'Iniciar',
    this.onChanged,
    this.autoFocus = false,
    this.endTitle,
    this.endDescription,
  });

  @override
  State<FormViewer> createState() => _FormViewerState();
}

class _FormViewerState extends State<FormViewer> with SingleTickerProviderStateMixin {
  late PageController _page;
  int _index = 0; // inclui a página de welcome como índice 0 (se existir)
  final Map<String, dynamic> _answers = {};
  final Map<String, String?> _errors = {};
  late final AnimationController _highlight;

  bool get hasWelcome => widget.elements.any((e) => e.type == ElementType.welcome);
  bool get hasEnd => widget.elements.any((e) => e.type == ElementType.end);

  int get totalPages => widget.elements.length + (hasWelcome ? 1 : 0) + (hasEnd ? 1 : 0);

  @override
  void initState() {
    super.initState();
    _page = PageController();
    _highlight = AnimationController(vsync: this, duration: const Duration(milliseconds: 240));
  }

  @override
  void dispose() {
    _page.dispose();
    _highlight.dispose();
    super.dispose();
  }

  // =============== Navegação ===============
  void _goNext() {
    // 🟢 Caso especial: primeira tela (welcome)
    if (hasWelcome && _index == 0) {
      setState(() => _index = 1);
      _page.animateToPage(_index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
      return;
    }

    // 🟣 Última pergunta antes do "End"
    if (_index == totalPages - 2 && hasEnd) {
      setState(() => _index++);
      _page.animateToPage(_index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
      return;
    }

    // ✅ Validação normal
    final el = _currentElement();
    if (!_validateElement(el)) {
      _blink();
      return;
    }

    // Próxima página
    if (_index < totalPages - 1) {
      setState(() => _index++);
      _page.animateToPage(_index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    // Aqui você pode enviar os dados para onde quiser.
    // Por enquanto, apenas exibo no console.
    debugPrint('Formulário concluído! Respostas: $_answers');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Formulário concluído! Veja o console para as respostas.')));
  }

  void _goPrev() {
    if (_index > 0) {
      setState(() => _index--);
      _page.animateToPage(_index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    }
  }

  ElementEntity _currentElement() {
    final contentIndex = hasWelcome ? _index - 1 : _index;
    return widget.elements[contentIndex];
  }

  // =============== Validação por tipo ===============
  bool _validateElement(ElementEntity el) {
    _errors.clear();

    switch (el.type) {
      case ElementType.welcome:
        // Sem validação necessária
        break;
      case ElementType.end:
        // Sem validação necessária
        break;

      case ElementType.text:
        final rules = el.textRules;
        final v = (_answers[el.id] ?? '').toString();
        if (rules.required && v.trim().isEmpty) {
          _errors[el.id] = rules.requiredMessage ?? 'Campo obrigatório';
        } else if (rules.minChars != null && v.trim().length < rules.minChars!) {
          _errors[el.id] = rules.minMessage ?? 'Mínimo de ${rules.minChars} caracteres';
        } else if (rules.maxChars != null && v.length > rules.maxChars!) {
          _errors[el.id] = rules.maxMessage ?? 'Máximo de ${rules.maxChars} caracteres';
        }
        break;

      case ElementType.dropdown:
        final rules = el.dropdownRules;
        final v = _answers[el.id] as String?;
        if (rules.required && (v == null || v.isEmpty)) {
          _errors[el.id] = rules.requiredMessage ?? 'Selecione uma opção';
        }
        break;

      case ElementType.select:
        final rules = el.selectRules;
        final list = (_answers[el.id] as List<String>?) ?? const [];
        if (rules.required && list.isEmpty) {
          _errors[el.id] = rules.requiredMessage ?? 'Selecione ao menos uma opção';
        } else if ((rules.minSelected ?? 0) > 0 && list.length < (rules.minSelected!)) {
          _errors[el.id] = 'Selecione ao menos ${rules.minSelected} opções';
        }
        break;

      case ElementType.checkbox:
        final rules = el.checkboxRules;
        final v = (_answers[el.id] ?? false) as bool;
        if (rules.required && v == false) {
          _errors[el.id] = rules.requiredMessage ?? 'Deve marcar para continuar';
        }
        break;
    }

    setState(() {});
    return _errors.isEmpty;
  }

  void _setAnswer(String id, dynamic v) {
    setState(() {
      _answers[id] = v;
      _errors[id] = null;
    });
    widget.onChanged?.call(_answers);
  }

  void _blink() async {
    await _highlight.forward();
    await _highlight.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // 🔹 Corpo principal (páginas)
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 720,
                    maxHeight: constraints.maxHeight * 0.9, // centraliza verticalmente
                  ),
                  child: PageView.builder(
                    controller: _page,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalPages,
                    itemBuilder: (_, i) {
                      // 🔹 Caso a lista possua elementos "reais" mistos (welcome, end, etc)
                      if (i < 0 || i >= widget.elements.length) {
                        return const SizedBox.shrink();
                      }

                      final el = widget.elements[i];

                      switch (el.type) {
                        case ElementType.welcome:
                          final cfg = el.properties['welcome_config'] ?? {};
                          return _buildWelcome(
                            th,
                            title: cfg['title'] ?? el.title ?? 'Bem-vindo!',
                            description: cfg['description'] ?? el.description ?? '',
                            buttonText: cfg['button_text'] ?? 'Começar',
                          );

                        case ElementType.end:
                          final cfg = el.properties['end_config'] ?? {};
                          return _buildEnd(
                            th,
                            title: cfg['title'] ?? el.title ?? 'Obrigado!',
                            description: cfg['description'] ?? el.description ?? '',
                            buttonText: cfg['button_text'] ?? 'Finalizar',
                          );

                        default:
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            physics: const BouncingScrollPhysics(),
                            child: _CenteredFormCard(
                              animation: _highlight,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildElement(context, th, el),
                                  const Divider(height: 1),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (_index > 0)
                                          OutlinedButton.icon(
                                            onPressed: _goPrev,
                                            icon: const Icon(Icons.arrow_back),
                                            label: const Text('Voltar'),
                                          ),
                                        ElevatedButton.icon(
                                          onPressed: _goNext,
                                          icon: Icon(_index == totalPages - 1 ? Icons.check : Icons.arrow_forward),
                                          label: Text(
                                            _index == totalPages - 1 ? 'Concluir' : 'Avançar',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                      }
                    },
                  ),
                ),
              ),
            ),

            // 🔹 Rodapé de navegação
          ],
        );
      },
    );
  }

  Widget _buildWelcome(ThemeData th, {required String title, required String description, required String buttonText}) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: widget.globalTheme.titleStyle(context), textAlign: widget.globalTheme.alignTitle),
              const SizedBox(height: 8),
              Text(description, style: widget.globalTheme.descriptionStyle(context), textAlign: widget.globalTheme.alignDescription),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _goNext,
                icon: const Icon(Icons.play_arrow),
                label: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnd(ThemeData th, {required String title, required String description, required String buttonText}) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: widget.globalTheme.titleStyle(context), textAlign: widget.globalTheme.alignTitle),
              const SizedBox(height: 8),
              Text(description, style: widget.globalTheme.descriptionStyle(context), textAlign: widget.globalTheme.alignDescription),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _submitForm(),
                icon: const Icon(Icons.done_all),
                label: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============== Render por tipo ===============
  Widget _buildElement(BuildContext context, ThemeData th, ElementEntity el) {
    final t = widget.globalTheme;
    final title = el.title ?? el.label;
    final descr = el.description;

    final titleRow = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${el.position + 1}', style: th.textTheme.titleMedium?.copyWith(color: th.colorScheme.primary, fontWeight: FontWeight.w500, height: 1.6)),
        const SizedBox(width: 6),
        Expanded(child: Text(title, style: t.titleStyle(context), textAlign: t.alignTitle)),
      ],
    );

    final descriptionWidget = (descr != null && descr.trim().isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 2),
            child: Text(descr, style: t.descriptionStyle(context), textAlign: t.alignDescription),
          )
        : const SizedBox.shrink();

    // Display error (se houver)
    final errorText = _errors[el.id];

    switch (el.type) {
      case ElementType.welcome:
        return _buildWelcome(
          th,
          title: el.title ?? 'Bem-vindo!',
          description: el.description ?? '',
          buttonText: 'Começar',
        );
      case ElementType.end:
        return _buildEnd(
          th,
          title: el.title ?? 'Obrigado!',
          description: el.description ?? '',
          buttonText: 'Finalizar',
        );
      case ElementType.text:
        final isEditable = widget.mode != EditableTextMode.view;
        final controller = TextEditingController(text: (_answers[el.id] ?? '').toString());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow,
            const SizedBox(height: 4),
            descriptionWidget,
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    onChanged: (v) => _setAnswer(el.id, v),
                    style: t.answerStyle(context),
                    decoration: InputDecoration(
                      hintText: widget.mode == EditableTextMode.create ? 'Escreva o placeholder...' : 'Digite sua resposta...',
                      border: InputBorder.none,
                      errorText: errorText,
                    ),
                  ),
                  if (isEditable) Padding(padding: const EdgeInsets.only(left: 0.0, top: 4), child: Container(height: 1, color: th.colorScheme.outline.withOpacity(0.2))),
                ],
              ),
            ),
          ],
        );

      case ElementType.dropdown:
        final isCreate = widget.mode == EditableTextMode.create;
        // prepara as opções conforme regras
        final rules = el.dropdownRules;
        List<ContentItem> opts = [...el.options];
        if (rules.alphabetical) {
          opts.sort((a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()));
        } else if (rules.randomize) {
          opts.shuffle();
        }
        final selected = _answers[el.id] as String?;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow,
            const SizedBox(height: 4),
            descriptionWidget,
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: isCreate
                        ? () async {
                            // 🔧 evita o erro de FocusNode sem contexto
                            FocusScope.of(context).unfocus();
                            await Future.delayed(Duration.zero);
                            // Você pode abrir o Dialog externo do painel (preferível).
                            // Aqui apenas informo ao criador que as opções são editadas no painel "Ações".
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Edite as opções no painel "Ações" à direita.'),
                            ));
                          }
                        : null,
                    child: AbsorbPointer(
                      absorbing: isCreate,
                      child: DropdownButtonFormField<String>(
                        initialValue: selected,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: th.colorScheme.primary),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: isCreate ? 'Clique no painel "Ações" para editar opções' : 'Selecione...',
                          hintStyle: widget.globalTheme.answerStyle(context).copyWith(color: th.colorScheme.outline.withOpacity(0.8)),
                          errorText: errorText,
                        ),
                        items: opts.map((o) => DropdownMenuItem(value: o.label, child: Text(o.label))).toList(),
                        onChanged: isCreate ? null : (v) => _setAnswer(el.id, v),
                      ),
                    ),
                  ),
                  if (!isCreate)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(height: 1, color: th.colorScheme.outline.withOpacity(0.2)),
                    ),
                ],
              ),
            ),
          ],
        );

      case ElementType.select:
        final isCreate = widget.mode == EditableTextMode.create;
        final selected = Set<String>.from((_answers[el.id] as List<String>?) ?? const <String>[]);
        final chips = el.options.isNotEmpty
            ? el.options
            : [
                // fallback com 2 opções padrão para entendimento
                ContentItem(id: 'a', key: 'a', label: 'Opção A'),
                ContentItem(id: 'b', key: 'b', label: 'Opção B'),
              ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow,
            const SizedBox(height: 4),
            descriptionWidget,
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: chips.map((o) {
                      final isSel = selected.contains(o.id);
                      return FilterChip(
                        selected: isSel,
                        onSelected: (v) {
                          if (v) {
                            selected.add(o.id);
                          } else {
                            selected.remove(o.id);
                          }
                          _setAnswer(el.id, selected.toList());
                        },
                        label: Text(o.key != null ? '(${o.key}) ${o.label}' : o.label),
                      );
                    }).toList(),
                  ),
                  if (!isCreate)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(errorText ?? '', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    ),
                ],
              ),
            ),
          ],
        );

      case ElementType.checkbox:
        final isChecked = (_answers[el.id] ?? false) as bool;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow,
            const SizedBox(height: 4),
            descriptionWidget,
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: CheckboxListTile(
                value: isChecked,
                onChanged: widget.mode == EditableTextMode.view ? null : (v) => _setAnswer(el.id, v ?? false),
                title: Text('Marcar', style: widget.globalTheme.answerStyle(context)),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.only(left: 10),
                subtitle: _errors[el.id] != null ? Text(_errors[el.id]!, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
              ),
            ),
          ],
        );
    }
  }
}

// Cartão centralizado com highlight sutil em erro
class _CenteredFormCard extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  const _CenteredFormCard({required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);
    final colorTween = ColorTween(begin: Colors.transparent, end: th.colorScheme.error.withOpacity(0.08)).animate(animation);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 720),
        child: AnimatedBuilder(
          animation: animation,
          builder: (_, __) => Container(
            decoration: BoxDecoration(
              color: colorTween.value,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
