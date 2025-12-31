import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geogestao_front/core/core.dart';

// 1. Classes de identificação
abstract class KeyIdentifier {
  String get mask;
  String removeMask(String value);
}

class CPFKeyIdentifier extends KeyIdentifier {
  @override
  String get mask => '###.###.###-##';

  @override
  String removeMask(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

class PhoneKeyIdentifier extends KeyIdentifier {
  @override
  String get mask => '(##) #####-####';

  @override
  String removeMask(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

class EmailKeyIdentifier extends KeyIdentifier {
  @override
  String get mask => '****************************';

  @override
  String removeMask(String value) {
    return value;
  }
}

// 2. Estratégia de identificação corrigida
class KeyStrategy {
  static KeyIdentifier getKeyIdentifier(String value) {
    final unmasked = value.replaceAll(RegExp(r'[^0-9a-zA-Z@]'), '');

    // Ordem de verificação importante!
    if (_isProbablyEmail(value)) {
      return EmailKeyIdentifier();
    } else if (_isProbablyPhone(unmasked)) {
      return PhoneKeyIdentifier();
    } else if (_isProbablyCPF(unmasked)) {
      return CPFKeyIdentifier();
    }
    return EmailKeyIdentifier(); // padrão
  }

  static bool _isProbablyPhone(String value) {
    if (value.length != 11) return false;

    // Verifica se é um telefone válido (DDD + número)
    final ddd = int.tryParse(value.substring(0, 2));
    final firstDigit = value[2];
    final result = ddd != null && ddd >= 11 && ['6', '7', '8', '9'].contains(firstDigit);

    debugPrint('Telefone válido: $value');
    return result;
  }

  static bool _isProbablyCPF(String value) {
    if (value.length != 11) return false;

    // Verifica se não é um telefone
    if (_isProbablyPhone(value)) return false;

    return int.tryParse(value) != null;
  }

  static bool _isProbablyEmail(String value) {
    return value.contains('@') && value.split('@').length == 2 && value.split('@').last.contains('.');
  }
}

// 3. Controller corrigido
class KeyController {
  MaskedTextController updateMaskBasedOnInput(String value, MaskedTextController controller) {
    final keyIdentifier = KeyStrategy.getKeyIdentifier(value);
    final unmaskedValue = keyIdentifier.removeMask(controller.text.isEmpty ? value : controller.text);
    debugPrint('key Identifier: ${keyIdentifier.mask}');

    if (controller.mask != keyIdentifier.mask) {
      debugPrint('Atualizando máscara para: ${keyIdentifier.mask}');
      debugPrint('Valor sem máscara: $unmaskedValue');

      // Preserva o cursor position
      final cursorPosition = controller.selection.baseOffset;

      // Atualiza o controller existente
      controller
        ..updateMask(keyIdentifier.mask)
        ..text = unmaskedValue;

      // Restaura a posição do cursor
      if (cursorPosition > -1) {
        controller.selection = TextSelection.collapsed(offset: cursorPosition > unmaskedValue.length ? unmaskedValue.length : cursorPosition);
      }

      debugPrint('Valor após atualização: ${controller.text}');
      return controller;
    }

    debugPrint('Mantendo máscara atual: ${controller.mask}');
    return controller;
  }
}

// 4. Tela corrigida
class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  State<KeyPage> createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  final _formKey = GlobalKey<FormState>();
  late MaskedTextController _controller;
  final KeyController _keyController = KeyController();
  String _currentType = 'Nenhum';

  @override
  void initState() {
    super.initState();
    _controller = MaskedTextController(mask: '****************************');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Chave Pix')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Digite sua chave Pix', hintText: 'CPF, Telefone ou Email'),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _controller = _keyController.updateMaskBasedOnInput(value, _controller);
                    _currentType = KeyStrategy.getKeyIdentifier(value).runtimeType.toString();
                  });
                },
                validator: (value) {
                  final unmasked = _controller.text;
                  final keyType = KeyStrategy.getKeyIdentifier(unmasked);

                  if (unmasked.isEmpty) return 'Digite uma chave válida';

                  if (keyType is CPFKeyIdentifier && unmasked.length != 11) {
                    return 'CPF precisa ter 11 dígitos';
                  } else if (keyType is PhoneKeyIdentifier && unmasked.length != 11) {
                    return 'Telefone precisa ter 11 dígitos';
                  } else if (keyType is EmailKeyIdentifier && !unmasked.contains('@')) {
                    return 'Email inválido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text('Tipo detectado: $_currentType'),
              Text('Valor sem máscara: ${_controller.text}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Chave válida: ${_controller.text}');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chave válida!'), backgroundColor: Colors.green));
                  }
                },
                child: const Text('Validar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
