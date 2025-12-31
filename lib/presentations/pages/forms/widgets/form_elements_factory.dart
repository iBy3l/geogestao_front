// form_elements_factory.dart
import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

/// 🔹 Cria instâncias prontas de elementos para a paleta.
///   Todas seguem o padrão (title + description + answer) e vêm com regras default.
///   Você pode registrar esses elementos no catálogo (FormElementsPaletteWidget).

class FormElementsFactory {
  /// 🟦 Texto (Input)

  static ElementEntity makeWelcomeElement() {
    return ElementEntity(
      id: UniqueKey().toString(),
      type: ElementType.welcome,
      label: 'Boas-vindas',
      title: 'Bem-vindo!',
      description: 'Clique em começar para iniciar o formulário.',
      icon: Icons.waving_hand_outlined,
      color: Colors.green,
      position: 0,
      properties: {},
    );
  }

  // 🟣 Tela de Agradecimento
  static ElementEntity makeEndElement() {
    return ElementEntity(
      id: UniqueKey().toString(),
      type: ElementType.end,
      label: 'Agradecimento',
      title: 'Obrigado!',
      description: 'Suas respostas foram enviadas com sucesso.',
      icon: Icons.emoji_emotions_outlined,
      color: Colors.blueGrey,
      position: 9999,
      properties: {},
    );
  }

  static ElementEntity makeTextElement() {
    return ElementEntity(
      id: UniqueKey().toString(),
      type: ElementType.text,
      label: 'Texto curto',
      icon: Icons.text_fields_rounded,
      color: Colors.blueAccent,
      position: 0,
      title: 'Digite sua pergunta',
      description: 'Descrição opcional para o campo',
      properties: {
        'text_rules': const TextFieldRules(
          required: false,
          minChars: 0,
          maxChars: 200,
          requiredMessage: 'Este campo é obrigatório',
          minMessage: 'Digite pelo menos 1 caractere',
          maxMessage: 'Limite de 200 caracteres',
        ).toJson(),
      },
    );
  }

  /// 🟪 Dropdown (lista de opções)
  static ElementEntity makeDropdownElement() {
    return ElementEntity(
      id: UniqueKey().toString(),
      type: ElementType.dropdown,
      label: 'Escolha uma opção',
      icon: Icons.arrow_drop_down_circle_outlined,
      color: Colors.purple,
      position: 0,
      title: 'Selecione um item da lista',
      description: 'Escolha uma das opções disponíveis',
      options: [
        ContentItem(id: UniqueKey().toString(), label: 'Opção 1'),
        ContentItem(id: UniqueKey().toString(), label: 'Opção 2'),
        ContentItem(id: UniqueKey().toString(), label: 'Opção 3'),
      ],
      properties: {
        'dropdown_rules': const DropdownRules(
          required: false,
          requiredMessage: 'Selecione uma opção antes de prosseguir',
          randomize: false,
          alphabetical: false,
        ).toJson(),
      },
    );
  }

  /// 🟨 Select (múltipla escolha)
  static ElementEntity makeSelectElement() {
    final letters = ['a', 'b', 'c'];
    return ElementEntity(
      id: UniqueKey().toString(),
      type: ElementType.select,
      label: 'Seleção múltipla',
      icon: Icons.checklist_outlined,
      color: Colors.orangeAccent,
      position: 0,
      title: 'Escolha uma ou mais opções',
      description: 'Você pode selecionar várias opções abaixo',
      options: List.generate(
        3,
        (i) => ContentItem(id: UniqueKey().toString(), label: 'Opção ${i + 1}', key: letters[i]),
      ),
      properties: {
        'select_rules': const SelectRules(
          required: false,
          requiredMessage: 'Selecione ao menos uma opção',
          minSelected: 1,
        ).toJson(),
      },
    );
  }

  /// ⬛ Checkbox (simples)
  static ElementEntity makeCheckboxElement() {
    return ElementEntity(
      id: UniqueKey().toString(),
      type: ElementType.checkbox,
      label: 'Confirmação',
      icon: Icons.check_box_outlined,
      color: Colors.teal,
      position: 0,
      title: 'Marque a caixa para confirmar',
      description: 'Marque se concordar com os termos',
      properties: {
        'checkbox_rules': const CheckboxRules(
          required: false,
          requiredMessage: 'É necessário marcar para continuar',
        ).toJson(),
      },
    );
  }
}
