/// Regras de Checkbox (simples)
class CheckboxRules {
  final bool required;
  final String? requiredMessage;

  const CheckboxRules({
    this.required = false,
    this.requiredMessage,
  });

  Map<String, dynamic> toJson() => {
        'required': required,
        'required_message': requiredMessage,
      };

  factory CheckboxRules.fromJson(Map<String, dynamic>? j) {
    final json = j ?? const {};
    return CheckboxRules(
      required: json['required'] ?? false,
      requiredMessage: json['required_message'],
    );
  }
}
