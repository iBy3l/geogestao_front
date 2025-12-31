import 'package:flutter/material.dart';

import '../forms.dart';

enum EditableTextType {
  title, // título da pergunta

  description, // descrição auxiliar
  answer, // resposta do usuário
}

class EditableTextContent extends StatefulWidget {
  final String initialText;
  final EditableTextType type;
  final EditableTextMode mode;
  final bool isOptional;
  final ValueChanged<String>? onChanged;

  final TextThemeConfig? themeConfig;
  final TextFieldConfig? fieldConfig;

  const EditableTextContent({
    super.key,
    required this.initialText,
    this.type = EditableTextType.description,
    this.mode = EditableTextMode.view,
    this.isOptional = false,
    this.onChanged,
    this.themeConfig,
    this.fieldConfig,
  });

  @override
  State<EditableTextContent> createState() => _EditableTextContentState();
}

class _EditableTextContentState extends State<EditableTextContent> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode = FocusNode()..addListener(() => setState(() => _isFocused = _focusNode.hasFocus));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  TextStyle _resolveStyle(BuildContext context) {
    final theme = widget.themeConfig ?? const TextThemeConfig();
    final style = theme.toTextStyle(context, isFocused: _isFocused);

    switch (widget.type) {
      case EditableTextType.title:
        return style.copyWith(fontWeight: FontWeight.w600);
      case EditableTextType.description:
        return style.copyWith(fontStyle: FontStyle.italic);
      case EditableTextType.answer:
        return style;
    }
  }

  void _validateAnswer() {
    final cfg = widget.fieldConfig;
    if (widget.mode == EditableTextMode.answer && (cfg?.required ?? false)) {
      final isEmpty = _controller.text.trim().isEmpty;
      setState(() => _errorText = isEmpty ? 'Campo obrigatório' : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = _resolveStyle(context);
    final textAlign = widget.themeConfig?.alignment ?? TextAlign.left;
    final cfg = widget.fieldConfig ?? const TextFieldConfig();

    final labelText = _controller.text.isEmpty && widget.mode != EditableTextMode.answer ? (widget.isOptional ? '(opcional)' : '') : _controller.text;

    final showAsterisk = widget.type == EditableTextType.title && (cfg.required == true);
    final isEditable = widget.mode != EditableTextMode.view;

    // 🔸 VISUALIZAÇÃO — apenas texto (preview)
    if (!isEditable && widget.type != EditableTextType.answer) {
      return Align(
        alignment: switch (textAlign) {
          TextAlign.center => Alignment.center,
          TextAlign.right => Alignment.centerRight,
          _ => Alignment.centerLeft,
        },
        child: RichText(
          textAlign: textAlign,
          text: TextSpan(
            text: labelText,
            style: style,
            children: [
              if (showAsterisk)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.redAccent),
                ),
            ],
          ),
        ),
      );
    }

    // 🔸 MODO EDITÁVEL
    final underlineColor = _isFocused ? theme.colorScheme.primary.withOpacity(0.5) : theme.colorScheme.outline.withOpacity(0.2);

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: switch (textAlign) {
          TextAlign.center => CrossAxisAlignment.center,
          TextAlign.right => CrossAxisAlignment.end,
          _ => CrossAxisAlignment.start,
        },
        children: [
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: isEditable,
            textAlign: textAlign,
            style: style,
            maxLength: cfg.maxLength,
            maxLines: widget.type == EditableTextType.answer ? (cfg.maxLines ?? 1) : 1,
            decoration: InputDecoration(
              isDense: true,
              counterText: '',
              hintText: switch (widget.type) {
                EditableTextType.title => 'Digite sua pergunta...',
                EditableTextType.description => 'Descrição (opcional)',
                EditableTextType.answer => cfg.placeholder ?? 'Digite sua resposta...',
              },
              hintStyle: style.copyWith(color: style.color?.withOpacity(0.4)),
              border: InputBorder.none,
              errorText: _errorText,
            ),
            onChanged: (v) {
              widget.onChanged?.call(v);
              if (widget.mode == EditableTextMode.answer) _validateAnswer();
            },
          ),

          // 🔹 Linha inferior (underline)
          if (widget.type == EditableTextType.answer || widget.mode == EditableTextMode.create || widget.mode == EditableTextMode.answer)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 1,
              width: double.infinity,
              color: underlineColor,
              margin: const EdgeInsets.only(top: 4),
            ),
        ],
      ),
    );
  }
}
