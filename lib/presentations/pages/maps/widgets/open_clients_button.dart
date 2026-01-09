import 'package:flutter/material.dart';

class OpenClientsButton extends StatelessWidget {
  final VoidCallback onTap;

  const OpenClientsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: 8,
      child: FloatingActionButton(
        mini: true,
        onPressed: onTap,
        child: const Icon(Icons.people),
      ),
    );
  }
}
