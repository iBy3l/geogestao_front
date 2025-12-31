import 'package:flutter/material.dart';
import '/shared/shared.dart';

class TextElementWidget extends StatelessWidget {
  final int index;
  final TextThemeConfig? themeConfigTitle;
  final TextThemeConfig? themeConfigDescription;
  final TextThemeConfig? themeConfigAnswer;
  final TextFieldConfig? fieldConfigTitle;
  final TextFieldConfig? fieldConfigDescription;
  final TextFieldConfig? fieldConfigAnswer;
  final EditableTextMode mode;

  final String initialTextTitle;
  final String initialTextDescription;
  final String initialTextAnswer;

  final ValueChanged<String>? onChanged;

  const TextElementWidget({
    super.key,
    required this.index,
    this.themeConfigTitle,
    this.themeConfigDescription,
    this.themeConfigAnswer,
    this.fieldConfigTitle,
    this.fieldConfigDescription,
    this.fieldConfigAnswer,
    this.mode = EditableTextMode.create,
    this.initialTextTitle = 'Título do formulário',
    this.initialTextDescription = 'Descrição do formulário',
    this.initialTextAnswer = 'Resposta do usuário',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$index',
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500, height: 1.6),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: EditableTextContent(initialText: initialTextTitle, type: EditableTextType.title, mode: mode, isOptional: false, themeConfig: themeConfigTitle, fieldConfig: fieldConfigTitle),
            ),
          ],
        ),
        SpaceWidget.extraSmall(),
        // se o descrição não for vazia, mostra a descrição
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: EditableTextContent(
            initialText: initialTextDescription,
            type: EditableTextType.description,
            mode: mode,
            isOptional: false,
            fieldConfig: fieldConfigDescription,
            themeConfig: themeConfigDescription,
          ),
        ),
        SpaceWidget.medium(),
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: EditableTextContent(
            initialText: initialTextAnswer,
            type: EditableTextType.answer,
            mode: EditableTextMode.answer,
            isOptional: false,
            themeConfig: themeConfigAnswer,
            fieldConfig: fieldConfigAnswer,

            onChanged: onChanged, // 🔹 envia valor atualizado
          ),
        ),
      ],
    );
  }
}
