import 'package:flutter/material.dart';
import '/shared/shared.dart';

class DropdownElementWidget extends StatefulWidget {
  final int index;
  final EditableTextMode mode;

  final String initialTextTitle;
  final String initialTextDescription;
  final List<String> options;

  final TextThemeConfig? themeConfigTitle;
  final TextThemeConfig? themeConfigDescription;
  final TextThemeConfig? themeConfigAnswer;

  final TextFieldConfig? fieldConfigTitle;
  final TextFieldConfig? fieldConfigDescription;
  final TextFieldConfig? fieldConfigAnswer;

  final bool required;
  final bool randomizeOrder;
  final bool alphabeticalOrder;

  final ValueChanged<String?>? onChanged;

  const DropdownElementWidget({
    super.key,
    this.index = 1,
    this.mode = EditableTextMode.answer,
    this.initialTextTitle = 'Selecione uma opção',
    this.initialTextDescription = 'Escolha uma opção da lista abaixo',
    this.options = const ['Opção 1', 'Opção 2', 'Opção 3'],
    this.themeConfigTitle,
    this.themeConfigDescription,
    this.themeConfigAnswer,
    this.fieldConfigTitle,
    this.fieldConfigDescription,
    this.fieldConfigAnswer,
    this.required = false,
    this.randomizeOrder = false,
    this.alphabeticalOrder = false,
    this.onChanged,
  });

  @override
  State<DropdownElementWidget> createState() => _DropdownElementWidgetState();
}

class _DropdownElementWidgetState extends State<DropdownElementWidget> {
  String? _selectedOption;
  late List<String> _options;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _options = [...widget.options];
    _prepareOptions();
  }

  void _prepareOptions() {
    if (widget.alphabeticalOrder) {
      _options.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    } else if (widget.randomizeOrder) {
      _options.shuffle();
    }
  }

  Future<void> _openEditDialog(BuildContext context) async {
    final controller = TextEditingController(text: _options.join('\n'));

    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar opções do dropdown'),
        content: SizedBox(
          width: 400,
          child: TextFormField(
            controller: controller,
            maxLines: 10,
            decoration: const InputDecoration(hintText: 'Digite uma opção por linha ou use vírgulas (,)', border: OutlineInputBorder()),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return Navigator.pop(context, []);
              final opts = text.split(RegExp(r'[,|\n]')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

              Navigator.pop(context, opts);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        _options = result;
        _prepareOptions();
      });
    }
  }

  void _validateAnswer() {
    if (widget.mode == EditableTextMode.answer && widget.required) {
      setState(() {
        _errorText = (_selectedOption == null || _selectedOption!.isEmpty) ? 'Selecione uma opção' : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showRequired = widget.required && widget.mode != EditableTextMode.create;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Cabeçalho
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.index}',
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500, height: 1.6),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: EditableTextContent(
                initialText: widget.initialTextTitle,
                type: EditableTextType.title,
                mode: widget.mode,
                isOptional: !showRequired,
                themeConfig: widget.themeConfigTitle ?? TextThemeConfig(color: theme.colorScheme.onSurface, alignment: TextAlign.left, size: TextSize.large),
                fieldConfig: widget.fieldConfigTitle ?? TextFieldConfig(required: widget.required),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // 🔹 Descrição
        if (widget.mode != EditableTextMode.create && widget.initialTextDescription.isNotEmpty || widget.initialTextDescription == '')
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: EditableTextContent(
              initialText: widget.initialTextDescription,
              type: EditableTextType.description,
              mode: widget.mode,
              isOptional: true,
              themeConfig: widget.themeConfigDescription ?? TextThemeConfig(color: theme.colorScheme.outline, alignment: TextAlign.left, size: TextSize.medium),
              fieldConfig: widget.fieldConfigDescription ?? const TextFieldConfig(required: false, maxLength: 200),
            ),
          ),

        const SizedBox(height: 16),

        // 🔹 Campo Dropdown
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.mode == EditableTextMode.create ? () => _openEditDialog(context) : null,
                child: AbsorbPointer(
                  absorbing: widget.mode == EditableTextMode.create,
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedOption,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.colorScheme.primary),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: widget.mode == EditableTextMode.create ? 'Clique para editar opções...' : 'Selecione...',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.outline.withOpacity(0.8)),
                      errorText: _errorText,
                    ),
                    items: _options
                        .map(
                          (opt) => DropdownMenuItem(
                            value: opt,
                            child: Text(opt, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface)),
                          ),
                        )
                        .toList(),
                    onChanged: widget.mode == EditableTextMode.create
                        ? null
                        : (value) {
                            widget.onChanged?.call(value);
                            setState(() => _selectedOption = value);
                            _validateAnswer();
                          },
                  ),
                ),
              ),

              // 🔹 Linha inferior
              // AnimatedContainer(
              //   duration: const Duration(milliseconds: 200),
              //   height: 1,
              //   width: double.infinity,
              //   color: theme.colorScheme.outline.withOpacity(0.2),
              //   margin: const EdgeInsets.only(top: 4),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
