// element_config_panel.dart
import 'package:flutter/material.dart';

import '../entity/entity.dart';
import '../enum/element_enum.dart';
import '../rules/rules.dart';

class ElementConfigPanel extends StatefulWidget {
  final ElementEntity element;
  final ValueChanged<ElementEntity> onChanged;

  const ElementConfigPanel({super.key, required this.element, required this.onChanged});

  @override
  State<ElementConfigPanel> createState() => _ElementConfigPanelState();
}

class _ElementConfigPanelState extends State<ElementConfigPanel> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;

  // Regras por tipo
  late TextFieldRules _textRules;
  late DropdownRules _dropdownRules;
  late SelectRules _selectRules;
  late CheckboxRules _checkboxRules;

  // Opções (para dropdown/select)
  late List<ContentItem> _options;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.element.title ?? widget.element.label);
    _descCtrl = TextEditingController(text: widget.element.description ?? '');

    _options = [...widget.element.options];

    // carrega regras existentes ou defaults
    _textRules = widget.element.properties.containsKey('text_rules') ? widget.element.textRules : const TextFieldRules();

    _dropdownRules = widget.element.properties.containsKey('dropdown_rules') ? widget.element.dropdownRules : const DropdownRules();

    _selectRules = widget.element.properties.containsKey('select_rules') ? widget.element.selectRules : const SelectRules(minSelected: 1);

    _checkboxRules = widget.element.properties.containsKey('checkbox_rules') ? widget.element.checkboxRules : const CheckboxRules();
  }

  void _commit() {
    final newProps = Map<String, dynamic>.from(widget.element.properties);
    switch (widget.element.type) {
      case ElementType.welcome:
        newProps['welcome_config'] = {
          'title': _titleCtrl.text.trim(),
          'description': _descCtrl.text.trim(),
          'button_text': 'Começar', // você pode trocar por um campo editável depois
        };
        break;

      case ElementType.end:
        newProps['end_config'] = {
          'title': _titleCtrl.text.trim(),
          'description': _descCtrl.text.trim(),
          'button_text': 'Finalizar',
        };
        break;
      case ElementType.text:
        newProps['text_rules'] = _textRules.toJson();
        break;
      case ElementType.dropdown:
        newProps['dropdown_rules'] = _dropdownRules.toJson();
        break;
      case ElementType.select:
        newProps['select_rules'] = _selectRules.toJson();
        break;
      case ElementType.checkbox:
        newProps['checkbox_rules'] = _checkboxRules.toJson();
        break;
    }

    widget.onChanged(
      widget.element.copyWith(
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
        options: _options,
        properties: newProps,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text('Configurações do elemento', style: th.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        TextField(
          controller: _titleCtrl,
          decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
          onChanged: (_) => _commit(),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descCtrl,
          maxLines: 2,
          decoration: const InputDecoration(labelText: 'Descrição (opcional)', border: OutlineInputBorder()),
          onChanged: (_) => _commit(),
        ),
        const SizedBox(height: 16),
        switch (widget.element.type) {
          ElementType.welcome => _buildWelcome(context),
          ElementType.end => _buildEnd(context),
          ElementType.text => _buildTextConfig(context),
          ElementType.dropdown => _buildDropdownConfig(context),
          ElementType.select => _buildSelectConfig(context),
          ElementType.checkbox => _buildCheckboxConfig(context),
        },
        const SizedBox(height: 16),
        if (widget.element.type == ElementType.dropdown || widget.element.type == ElementType.select) _buildOptionsManager(context),
      ],
    );
  }

  // ------- WELCOME -------
  Widget _buildWelcome(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tela de Boas-Vindas', style: Theme.of(c).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: _titleCtrl,
          decoration: const InputDecoration(labelText: 'Título da tela de boas-vindas', border: OutlineInputBorder()),
          onChanged: (_) => _commit(),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descCtrl,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Descrição da tela de boas-vindas', border: OutlineInputBorder()),
          onChanged: (_) => _commit(),
        ),
      ],
    );
  }

  // ------- END -------
  Widget _buildEnd(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tela de Agradecimento', style: Theme.of(c).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: _titleCtrl,
          decoration: const InputDecoration(labelText: 'Título da tela de agradecimento', border: OutlineInputBorder()),
          onChanged: (_) => _commit(),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descCtrl,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Descrição da tela de agradecimento', border: OutlineInputBorder()),
          onChanged: (_) => _commit(),
        ),
      ],
    );
  }

  // ------- TEXT -------
  Widget _buildTextConfig(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _switchRow('Obrigatório', _textRules.required, (v) {
          _textRules = TextFieldRules(
            required: v,
            minChars: _textRules.minChars,
            maxChars: _textRules.maxChars,
            requiredMessage: _textRules.requiredMessage,
            minMessage: _textRules.minMessage,
            maxMessage: _textRules.maxMessage,
          );
          _commit();
        }),
        const SizedBox(height: 4),
        _intField('Mínimo de caracteres', _textRules.minChars, (n) {
          _textRules = TextFieldRules(
            required: _textRules.required,
            minChars: n,
            maxChars: _textRules.maxChars,
            requiredMessage: _textRules.requiredMessage,
            minMessage: _textRules.minMessage,
            maxMessage: _textRules.maxMessage,
          );
          _commit();
        }),
        const SizedBox(height: 8),
        _intField('Máximo de caracteres', _textRules.maxChars, (n) {
          _textRules = TextFieldRules(
            required: _textRules.required,
            minChars: _textRules.minChars,
            maxChars: n,
            requiredMessage: _textRules.requiredMessage,
            minMessage: _textRules.minMessage,
            maxMessage: _textRules.maxMessage,
          );
          _commit();
        }),
        const SizedBox(height: 8),
        _stringField('Mensagem de obrigatório', _textRules.requiredMessage, (s) {
          _textRules = TextFieldRules(
            required: _textRules.required,
            minChars: _textRules.minChars,
            maxChars: _textRules.maxChars,
            requiredMessage: s,
            minMessage: _textRules.minMessage,
            maxMessage: _textRules.maxMessage,
          );
          _commit();
        }),
        _stringField('Mensagem para mínimo', _textRules.minMessage, (s) {
          _textRules = TextFieldRules(
            required: _textRules.required,
            minChars: _textRules.minChars,
            maxChars: _textRules.maxChars,
            requiredMessage: _textRules.requiredMessage,
            minMessage: s,
            maxMessage: _textRules.maxMessage,
          );
          _commit();
        }),
        _stringField('Mensagem para máximo', _textRules.maxMessage, (s) {
          _textRules = TextFieldRules(
            required: _textRules.required,
            minChars: _textRules.minChars,
            maxChars: _textRules.maxChars,
            requiredMessage: _textRules.requiredMessage,
            minMessage: _textRules.minMessage,
            maxMessage: s,
          );
          _commit();
        }),
      ],
    );
  }

  // ------- DROPDOWN -------
  Widget _buildDropdownConfig(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _switchRow('Obrigatório', _dropdownRules.required, (v) {
          _dropdownRules = DropdownRules(
            required: v,
            requiredMessage: _dropdownRules.requiredMessage,
            randomize: _dropdownRules.randomize,
            alphabetical: _dropdownRules.alphabetical,
          );
          _commit();
        }),
        _stringField('Mensagem de obrigatório', _dropdownRules.requiredMessage, (s) {
          _dropdownRules = DropdownRules(
            required: _dropdownRules.required,
            requiredMessage: s,
            randomize: _dropdownRules.randomize,
            alphabetical: _dropdownRules.alphabetical,
          );
          _commit();
        }),
        _switchRow('Randomizar opções', _dropdownRules.randomize, (v) {
          _dropdownRules = DropdownRules(
            required: _dropdownRules.required,
            requiredMessage: _dropdownRules.requiredMessage,
            randomize: v,
            alphabetical: false, // não combina com alfabética
          );
          _commit();
        }),
        _switchRow('Ordem alfabética', _dropdownRules.alphabetical, (v) {
          _dropdownRules = DropdownRules(
            required: _dropdownRules.required,
            requiredMessage: _dropdownRules.requiredMessage,
            randomize: false, // não combina com random
            alphabetical: v,
          );
          _commit();
        }),
      ],
    );
  }

  // ------- SELECT (múltipla) -------
  Widget _buildSelectConfig(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _switchRow('Obrigatório', _selectRules.required, (v) {
          _selectRules = SelectRules(
            required: v,
            requiredMessage: _selectRules.requiredMessage,
            minSelected: _selectRules.minSelected,
          );
          _commit();
        }),
        _stringField('Mensagem de obrigatório', _selectRules.requiredMessage, (s) {
          _selectRules = SelectRules(
            required: _selectRules.required,
            requiredMessage: s,
            minSelected: _selectRules.minSelected,
          );
          _commit();
        }),
        _intField('Mínimo de opções selecionadas', _selectRules.minSelected, (n) {
          _selectRules = SelectRules(
            required: _selectRules.required,
            requiredMessage: _selectRules.requiredMessage,
            minSelected: n,
          );
          _commit();
        }),
      ],
    );
  }

  // ------- CHECKBOX -------
  Widget _buildCheckboxConfig(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _switchRow('Obrigatório', _checkboxRules.required, (v) {
          _checkboxRules = CheckboxRules(required: v, requiredMessage: _checkboxRules.requiredMessage);
          _commit();
        }),
        _stringField('Mensagem de obrigatório', _checkboxRules.requiredMessage, (s) {
          _checkboxRules = CheckboxRules(required: _checkboxRules.required, requiredMessage: s);
          _commit();
        }),
      ],
    );
  }

  // ------- GESTÃO DE OPÇÕES (Dropdown/Select) -------
  Widget _buildOptionsManager(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Row(
          children: [
            Text('Opções', style: Theme.of(c).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Spacer(),
            TextButton.icon(
              onPressed: () async {
                final text = await _openOptionsDialog(c, _options.map((o) => o.label).toList());
                if (text == null) return;

                // Converte linhas/vírgulas em lista
                final raw = text.split(RegExp(r'[,\n]')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                // Atribui letras (a, b, c, ...)
                final letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
                final list = <ContentItem>[];
                for (int i = 0; i < raw.length; i++) {
                  final k = i < letters.length ? letters[i] : '${i + 1}';
                  list.add(ContentItem(id: UniqueKey().toString(), label: raw[i], key: k));
                }
                setState(() => _options = list);
                _commit();
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar lista'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _options
              .map((o) => Chip(
                    label: Text(o.key != null ? '(${o.key}) ${o.label}' : o.label),
                    onDeleted: () {
                      setState(() => _options.removeWhere((x) => x.id == o.id));
                      _commit();
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        if (_options.isEmpty) Text('Sem opções. Clique em "Editar lista" para adicionar.', style: Theme.of(c).textTheme.bodySmall),
      ],
    );
  }

  // ------- Helpers UI -------
  Widget _switchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Switch(value: value, onChanged: (v) => setState(() => onChanged(v))),
        Expanded(child: Text(label)),
      ],
    );
  }

  Widget _intField(String label, int? value, ValueChanged<int?> onChanged) {
    final ctrl = TextEditingController(text: value?.toString() ?? '');
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: (v) => onChanged(int.tryParse(v)),
    );
  }

  Widget _stringField(String label, String? value, ValueChanged<String?> onChanged) {
    final ctrl = TextEditingController(text: value ?? '');
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        onChanged: (v) => onChanged(v.trim().isEmpty ? null : v),
      ),
    );
  }

  Future<String?> _openOptionsDialog(BuildContext context, List<String> current) async {
    final controller = TextEditingController(text: current.join('\n'));
    return showDialog<String?>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar opções'),
        content: SizedBox(
          width: 420,
          child: TextFormField(
            controller: controller,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Uma opção por linha ou separado por vírgulas',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Salvar')),
        ],
      ),
    );
  }
}
