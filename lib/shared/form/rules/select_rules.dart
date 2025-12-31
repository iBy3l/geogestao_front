/// Regras de Select (múltipla escolha)
class SelectRules {
  final bool required;
  final String? requiredMessage;
  final int? minSelected; // mínimo a selecionar

  const SelectRules({
    this.required = false,
    this.requiredMessage,
    this.minSelected,
  });

  Map<String, dynamic> toJson() => {
        'required': required,
        'required_message': requiredMessage,
        'min_selected': minSelected,
      };

  factory SelectRules.fromJson(Map<String, dynamic>? j) {
    final json = j ?? const {};
    return SelectRules(
      required: json['required'] ?? false,
      requiredMessage: json['required_message'],
      minSelected: json['min_selected'],
    );
  }
}
