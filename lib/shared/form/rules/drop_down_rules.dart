/// Regras de Dropdown
class DropdownRules {
  final bool required;
  final String? requiredMessage;
  final bool randomize;
  final bool alphabetical;

  const DropdownRules({
    this.required = false,
    this.requiredMessage,
    this.randomize = false,
    this.alphabetical = false,
  });

  Map<String, dynamic> toJson() => {
        'required': required,
        'required_message': requiredMessage,
        'randomize': randomize,
        'alphabetical': alphabetical,
      };

  factory DropdownRules.fromJson(Map<String, dynamic>? j) {
    final json = j ?? const {};
    return DropdownRules(
      required: json['required'] ?? false,
      requiredMessage: json['required_message'],
      randomize: json['randomize'] ?? false,
      alphabetical: json['alphabetical'] ?? false,
    );
  }
}
