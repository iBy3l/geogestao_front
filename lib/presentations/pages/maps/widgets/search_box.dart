import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;

  const SearchBox({super.key, required this.onChanged, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: TextField(
          onChanged: onChanged,
          onSubmitted: onSubmit,
          decoration: InputDecoration(
            hintText: 'Buscar endereço',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            filled: true,
          ),
        ),
      ),
    );
  }
}
