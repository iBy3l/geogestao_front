import 'package:flutter/material.dart';
import '/core/core.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.title,
    required this.controller,
    this.width,
    this.menuHeight,
    this.enableFilter = true,
    this.hintText,
    this.enabled = true,
    this.enableSearch = true,
    this.onSelected,
    required this.dropdownMenuEntries,
    this.initialSelection,
    this.searchCallback,
    this.focusNode,
    this.fillColor,
  });
  final String title;
  final TextEditingController controller;
  final double? width;
  final double? menuHeight;
  final bool enableFilter;
  final String? hintText;
  final bool enabled;
  final bool enableSearch;
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final T? initialSelection;
  final int? Function(List<DropdownMenuEntry<T>>, String)? searchCallback;
  final FocusNode? focusNode;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      width: width,
      focusNode: focusNode,
      controller: controller,
      enableFilter: enableFilter,
      enableSearch: enableSearch,
      hintText: hintText,
      enabled: enabled,
      onSelected: onSelected,
      menuHeight: menuHeight,
      initialSelection: initialSelection,
      menuStyle: MenuStyle(fixedSize: WidgetStateProperty.resolveWith((_) => Size(width ?? 300, menuHeight ?? 40))),
      searchCallback: searchCallback,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: fillColor,
        hoverColor: fillColor,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        fillColor: fillColor,
        filled: true,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.theme.colorScheme.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.theme.colorScheme.primary, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.theme.colorScheme.primary, width: 1),
        ),
      ),
      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
