/// Regras base para campos de texto (aplicam à Resposta do tipo "text")
class TextFieldRules {
  final bool required;
  final int? minChars;
  final int? maxChars;
  final String? requiredMessage;
  final String? minMessage;
  final String? maxMessage;

  const TextFieldRules({
    this.required = false,
    this.minChars,
    this.maxChars,
    this.requiredMessage,
    this.minMessage,
    this.maxMessage,
  });

  Map<String, dynamic> toJson() => {
        'required': required,
        'min_chars': minChars,
        'max_chars': maxChars,
        'required_message': requiredMessage,
        'min_message': minMessage,
        'max_message': maxMessage,
      };

  factory TextFieldRules.fromJson(Map<String, dynamic>? j) {
    final json = j ?? const {};
    return TextFieldRules(
      required: json['required'] ?? false,
      minChars: json['min_chars'],
      maxChars: json['max_chars'],
      requiredMessage: json['required_message'],
      minMessage: json['min_message'],
      maxMessage: json['max_message'],
    );
  }
}
