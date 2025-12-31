class PasswordValidator {
  static const String _passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  static bool validatePasswordLength(String value) => value.length >= 8;

  static bool hasSpecialCharacter(String password) {
    final isValidatePassword = RegExp(_passwordPattern).hasMatch(password);
    return isValidatePassword;
  }

  static bool passwordConfirm(String passwordConfirm, String password) => passwordConfirm == password;
}
