import 'package:flutter/material.dart';

import 'validator.dart';

class ValidatorValue {
  //Contexto adicionado para ser possível buscar string no applocalization
  final BuildContext context;
  final String? value;
  String? _message;

  ValidatorValue({required this.context, this.value});
  String? get message => _message;

  String? validateEmptyField({String? errorText}) {
    if (value?.isEmpty ?? true) {
      return _message = errorText ?? 'Campo obrigatório';
    }
    return _message;
  }

  String? validateCep({String? errorText}) {
    RegExp regex = RegExp(r'^[0-9]{5}-[0-9]{3}$');
    if (!regex.hasMatch(value ?? '')) {
      return _message = errorText ?? "CEP inválido";
    }
    return null;
  }

  String? validateMaxLength(int maxLength, {String? errorText}) {
    if ((value?.length ?? 0) > maxLength) {
      return _message = errorText ?? "Esse campo deve ter no máximo $maxLength caractere(s)";
    }
    return _message;
  }

  String? validateMinLength(int minLength, {String? errorText}) {
    if ((value?.length ?? 0) < minLength) {
      return _message = errorText ?? "Esse campo deve ter no mínimo $minLength caractere(s)";
    }
    return _message;
  }

  String? validatePassword({String? errorText}) {
    if (!PasswordValidator.validatePasswordLength(value ?? '')) {
      _message = errorText ?? "Senha deve conter pelo menos uma letra, um número e caracteres especiais";
      return message;
    }
    _message = '';
    return null;
  }

  String? validatePasswordConfirmation(String password, {String? errorText}) {
    if (value != password) {
      _message = errorText ?? "As senhas não coincidem";
      return message;
    }
    _message = '';
    return null;
  }

  String? validatePhoneNumber({String? errorText}) {
    if (value?.replaceAll(RegExp(r'[^\w+]|_'), '').length != 14 || !value!.contains('+')) {
      return _message = errorText ?? "Por favor insira um número de telefone válido";
    }
    return _message;
  }

  String? validateEmail({String? errorText}) {
    if (!EmailValidator.validate(value ?? '')) {
      return _message = errorText ?? "Por favor insira um email válido";
    }
    return _message;
  }

  String? validateFullName({String? errorText}) {
    if (value!.split(' ').length < 2) {
      return _message = errorText ?? "Por favor insira seu nome completo";
    }
    return _message;
  }
}
