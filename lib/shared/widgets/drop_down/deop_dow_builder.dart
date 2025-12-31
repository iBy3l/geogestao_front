import 'package:flutter/material.dart';
import '/core/core.dart';
import '/domain/entities/entities.dart';
import '/shared/shared.dart';

class BuilderDropDown<T extends DropItemEntity> extends StatelessWidget {
  final String title;
  final String hintText;
  final double? width;
  final List<T>? list;
  final T? value;
  final Function(T value)? onSelected;
  final TextEditingController? controller;
  final Color? fillColor;
  final bool enabled;

  final double? menuHeight;
  final int? Function(List<DropdownMenuEntry<T>>, String)? searchCallback;
  const BuilderDropDown({
    super.key,
    required this.title,
    required this.hintText,
    this.width,
    this.value,
    this.list,
    this.onSelected,
    this.controller,
    this.fillColor,
    this.enabled = true,
    this.menuHeight,
    this.searchCallback,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropDownMenu<T>(
      enabled: enabled,
      controller: controller ?? TextEditingController(),
      title: title.toUpperCase(),
      hintText: hintText.toUpperCase(),
      width: width,
      menuHeight: 100,
      focusNode: FocusNode(),
      initialSelection: value,
      fillColor: fillColor,
      searchCallback: searchCallback,
      enableFilter: false,
      enableSearch: true,
      dropdownMenuEntries:
          list
              ?.map(
                (e) => DropdownMenuEntry<T>(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(context.theme.colorScheme.primary.withValues(alpha: 0.1))),
                  leadingIcon: const Icon(Icons.location_city, color: CustomColors.laranja),
                  label: e.name.toUpperCase() ?? '',
                  value: e,
                  labelWidget: Text(
                    e.name.toUpperCase() ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, color: context.theme.colorScheme.scrim),
                  ),
                ),
              )
              .toList() ??
          [],
      onSelected: (value) => onSelected?.call(value),
    );
  }
}
