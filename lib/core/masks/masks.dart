import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CustomMasks {
  CustomMasks._();

  static final CustomMasks _instance = CustomMasks._();

  factory CustomMasks() {
    return _instance;
  }

  static final cpfMaskFormatter = MaskedInputFormatter('000.000.000-00');

  static final phoneMaskFormatter = MaskedInputFormatter('00 0000-0000');

  static final phoneMaskFormatterWithDDD = MaskedInputFormatter('(00) 00000-0000');

  static final cnpjMaskFormatter = MaskedInputFormatter('00.000.000/0000-00');

  static final cepMaskFormatter = MaskedInputFormatter('00000-000');

  static final dateMaskFormatter = MaskedInputFormatter('00/00/0000');
  static final timeMaskFormatter = MaskedInputFormatter('00:00');
  static final dateTimeMaskFormatter = MaskedInputFormatter('00/00/0000 00:00');
}
