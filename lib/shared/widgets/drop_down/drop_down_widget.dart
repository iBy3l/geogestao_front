import 'package:flutter/material.dart';
import '/core/core.dart';

class DropdownWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final String? value;
  final List<String>? items;
  final IconData? icon;

  const DropdownWidget({super.key, this.hintText, this.value, this.items, this.width, this.height, this.icon});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String? _selectedValue;
  @override
  void initState() {
    _selectedValue = widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String newValue) {
        setState(() {
          _selectedValue = newValue;
        });
      },
      itemBuilder: (BuildContext context) {
        return widget.items?.map((String status) {
              return PopupMenuItem<String>(
                height: widget.height ?? 30,
                mouseCursor: MouseCursor.defer,
                value: status,
                child: SizedBox(width: widget.width ?? 100, child: Text(status)),
              );
            }).toList() ??
            [];
      },
      child: Container(
        width: widget.width ?? 165,
        height: widget.height ?? 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colorScheme.outline, width: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.icon != null
              ? [
                  Icon(widget.icon, color: context.theme.colorScheme.primary),
                  Text(_selectedValue ?? widget.hintText ?? 'Selecione', style: TextStyle(color: context.theme.colorScheme.scrim)),
                  Icon(context.icon.arrowDropdown, color: context.theme.primaryColor),
                ]
              : [Text(_selectedValue ?? widget.hintText ?? 'Selecione', style: TextStyle(color: context.theme.colorScheme.scrim)), Icon(context.icon.arrowDropdown, color: context.theme.primaryColor)],
        ),
      ),
    );
  }
}
