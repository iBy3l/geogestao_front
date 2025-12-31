import 'base_form_theme.dart';
import 'text_theme.dart';

class FormThemeToken {
  final BaseFormTheme baseForm;
  final TextContentThemeToken textElements;

  const FormThemeToken({
    required this.baseForm,
    required this.textElements,
  });

  factory FormThemeToken.fromJson(Map<String, dynamic> json) => FormThemeToken(
        baseForm: BaseFormTheme.fromJson(json['baseFormTheme']),
        textElements: TextContentThemeToken.fromJson(json['textContentTheme']),
      );
}
