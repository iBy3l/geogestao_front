import 'package:flutter/material.dart';
import '/presentations/pages/forms/widgets/form_elements_factory.dart';
import '/shared/shared.dart';

/// Paleta de elementos disponíveis para adicionar ao formulário.
/// Agora totalmente integrada com o novo sistema de factories (FormElementsFactory)
class FormElementsPaletteWidget extends StatefulWidget {
  final void Function(ElementEntity element) onSelect;

  const FormElementsPaletteWidget({
    super.key,
    required this.onSelect,
  });

  @override
  State<FormElementsPaletteWidget> createState() => _FormElementsPaletteWidgetState();
}

class _FormElementsPaletteWidgetState extends State<FormElementsPaletteWidget> {
  String search = '';

  /// 🔹 Categorias e tipos de elementos
  late final Map<String, List<_PaletteItem>> categories = {
    'Estrutura': [
      _PaletteItem(
        label: 'Tela de boas-vindas',
        icon: Icons.waving_hand_outlined,
        color: Colors.green.shade400,
        factory: FormElementsFactory.makeWelcomeElement,
      ),
      _PaletteItem(
        label: 'Tela de agradecimento',
        icon: Icons.emoji_emotions_outlined,
        color: Colors.blueGrey.shade400,
        factory: FormElementsFactory.makeEndElement,
      ),
    ],
    'Texto': [
      _PaletteItem(
        label: 'Texto curto',
        icon: Icons.text_fields_outlined,
        color: Colors.blue.shade400,
        factory: FormElementsFactory.makeTextElement,
      ),
    ],
    'Escolhas': [
      _PaletteItem(
        label: 'Dropdown',
        icon: Icons.arrow_drop_down_circle_outlined,
        color: Colors.purple.shade400,
        factory: FormElementsFactory.makeDropdownElement,
      ),
      _PaletteItem(
        label: 'Seleção múltipla',
        icon: Icons.checklist_outlined,
        color: Colors.orangeAccent.shade200,
        factory: FormElementsFactory.makeSelectElement,
      ),
      _PaletteItem(
        label: 'Checkbox',
        icon: Icons.check_box_outlined,
        color: Colors.teal.shade400,
        factory: FormElementsFactory.makeCheckboxElement,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filtered = categories.map((category, items) {
      final filteredItems = items.where((e) => e.label.toLowerCase().contains(search.toLowerCase()) || search.isEmpty).toList();
      return MapEntry(category, filteredItems);
    });

    return Container(
      width: 360,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 Campo de busca
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar elementos...',
              prefixIcon: Icon(Icons.search, color: theme.colorScheme.outline),
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => setState(() => search = value),
          ),
          const SizedBox(height: 16),

          // 🔹 Lista de categorias
          Expanded(
            child: ListView(
              children: filtered.entries.map((entry) {
                final category = entry.key;
                final items = entry.value;
                if (items.isEmpty) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: items.map((item) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {
                              final element = item.factory();
                              widget.onSelect(
                                element.copyWith(
                                  id: UniqueKey().toString(),
                                  position: DateTime.now().millisecondsSinceEpoch,
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: item.color.withAlpha(30),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: item.color.withAlpha(100),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(item.icon, color: item.color, size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      item.label,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Classe auxiliar para definir visualmente um item da paleta
class _PaletteItem {
  final String label;
  final IconData icon;
  final Color color;
  final ElementEntity Function() factory;

  _PaletteItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.factory,
  });
}
