import 'package:flutter/material.dart';

class ImportClientsWidget extends StatelessWidget {
  const ImportClientsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.size!.width * 0.8,
      height: context.size!.height * 0.6,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
