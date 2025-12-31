class TextFieldConfig {
  final bool required;
  final int? maxLength;
  final int? maxLines;
  final String? placeholder;

  const TextFieldConfig({
    this.required = false,
    this.maxLength,
    this.maxLines,
    this.placeholder,
  });

  factory TextFieldConfig.fromJson(Map<String, dynamic>? json) {
    return TextFieldConfig(
      required: json?['required'] ?? false,
      maxLength: json?['max_length'],
      maxLines: json?['max_lines'],
      placeholder: json?['placeholder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'required': required,
      'max_length': maxLength,
      'max_lines': maxLines,
      'placeholder': placeholder,
    };
  }

  TextFieldConfig copyWith({
    bool? required,
    int? maxLength,
    int? maxLines,
    String? placeholder,
  }) {
    return TextFieldConfig(
      required: required ?? this.required,
      maxLength: maxLength ?? this.maxLength,
      maxLines: maxLines ?? this.maxLines,
      placeholder: placeholder ?? this.placeholder,
    );
  }
}
