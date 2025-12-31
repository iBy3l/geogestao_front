import 'package:flutter/material.dart';
import '/core/core.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(context.icon.arrowLeft),
      onPressed: () {
        Modular.to.pop();
      },
    );
  }
}
