import 'dart:async';

import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/shared.dart';

class SearchItem extends StatelessWidget {
  final String title;
  final double? width;
  final SearchController searchController;
  final Function(String)? viewOnChanged;
  final Function(String)? onChanged;
  final Function(String)? viewOnSubmitted;
  final FocusNode? focusNode;
  final FutureOr<Iterable<Widget>> Function(BuildContext, SearchController) suggestionsBuilder;
  final bool enabled;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Function(String)? onSubmitted;

  const SearchItem({
    super.key,
    required this.title,
    this.width,
    required this.searchController,
    required this.viewOnChanged,
    required this.onChanged,
    required this.viewOnSubmitted,
    required this.suggestionsBuilder,
    this.focusNode,
    this.enabled = true,
    this.backgroundColor,
    this.onSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.bold),
          ),
          SpaceWidget.small(),
          SearchAnchor(
            enabled: enabled,
            searchController: searchController,
            viewOnChanged: (value) => viewOnChanged!(value),
            keyboardType: TextInputType.number,
            isFullScreen: false,
            headerHeight: 48,
            builder: (BuildContext context, SearchController searchController) {
              return SearchBar(
                constraints: const BoxConstraints(maxHeight: 50, minHeight: 48),
                controller: searchController,
                autoFocus: false,
                enabled: enabled,
                focusNode: focusNode,
                textCapitalization: TextCapitalization.characters,
                elevation: WidgetStateProperty.resolveWith((states) => 0),
                textStyle: WidgetStateProperty.resolveWith((states) {
                  return Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.scrim);
                }),
                shape: WidgetStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: context.theme.colorScheme.primary, width: 2),
                  );
                }),
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  return backgroundColor ?? Theme.of(context).colorScheme.onPrimary;
                }),
                padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                keyboardType: TextInputType.number,
                onChanged: (value) => onChanged!(value),
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  } else {
                    searchController.openView();
                  }
                },
                onSubmitted: (value) => onSubmitted!(value),
                textInputAction: TextInputAction.search,
                leading: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
              );
            },
            viewOnSubmitted: (value) => viewOnSubmitted!(value),
            headerHintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.bold),
            headerTextStyle: Theme.of(context).textTheme.labelSmall!.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.bold),
            viewConstraints: const BoxConstraints(maxHeight: 200),
            textInputAction: TextInputAction.go,
            viewLeading: IconButton(
              onPressed: () {
                searchController.clear();
                Modular.to.pop();
              },
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
            ),
            viewElevation: 0,
            viewShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: context.theme.colorScheme.secondary, width: 2),
            ),
            suggestionsBuilder: (BuildContext context, SearchController searchController) => suggestionsBuilder(context, searchController),
          ),
        ],
      ),
    );
  }
}
