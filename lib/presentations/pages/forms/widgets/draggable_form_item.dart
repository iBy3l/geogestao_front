import 'package:flutter/material.dart';
import '/core/core.dart';

import '../../../../shared/form/forms.dart';

class DraggableFormItem extends StatefulWidget {
  final ElementEntity element;
  final int index;
  final VoidCallback onRemove;
  final ValueChanged<ElementEntity>? onTap;

  const DraggableFormItem({
    super.key,
    required this.element,
    required this.index,
    required this.onRemove,
    this.onTap,
  });

  @override
  State<DraggableFormItem> createState() => _DraggableFormItemState();
}

class _DraggableFormItemState extends State<DraggableFormItem> {
  bool isHovered = false;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final element = widget.element;
    final isFixed = element.label.trim().toLowerCase() == 'alcon' || element.label.trim().toLowerCase() == 'andy';

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Listener(
        onPointerDown: (_) => setState(() => isDragging = true),
        onPointerUp: (_) => setState(() => isDragging = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          transform: Matrix4.identity()
            ..scale(isDragging ? 1.03 : 1.0)
            ..translate(0.0, isDragging ? -2.0 : 0.0),
          child: Material(
            elevation: isDragging ? 8 : (isHovered ? 2 : 0),
            shadowColor: theme.colorScheme.primary.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(6),
            color: isHovered ? theme.colorScheme.primary.withValues(alpha: 0.12) : theme.colorScheme.primary.withValues(alpha: 0.06),
            child: ListTile(
              onTap: () => widget.onTap?.call(element),
              contentPadding: const EdgeInsets.only(left: 8, right: 6),
              leading: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: element.color?.withAlpha(200),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(element.icon, color: theme.colorScheme.scrim, size: 16),
              ),
              title: Text(element.label, style: theme.textTheme.bodyMedium),
              subtitle: Text('Posição ${element.position}', style: theme.textTheme.bodySmall),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isFixed)
                    ReorderableDragStartListener(
                      key: ValueKey(element.id),
                      enabled: !isFixed,
                      index: widget.index,
                      child: Icon(Icons.drag_indicator_outlined, color: theme.colorScheme.outline),
                    )
                  else
                    const SizedBox(width: 24),
                  IconButton(
                    tooltip: context.text.remove,
                    onPressed: widget.onRemove,
                    icon: Icon(Icons.close, color: theme.colorScheme.error),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
