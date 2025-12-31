import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/shared.dart';

class CardCountNewWidget extends StatelessWidget {
  final int countNewDeliveries;
  final IconData? icon;
  final String? title;

  final Function? onTap;
  const CardCountNewWidget({super.key, this.countNewDeliveries = 0, this.onTap, this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    String title = this.title ?? context.text.email;
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: countNewDeliveries > 0 ? () => onTap?.call() : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon ?? Icons.local_shipping_outlined, color: countNewDeliveries > 0 ? context.theme.colorScheme.tertiary : context.theme.colorScheme.onPrimary, size: 24),
              SpaceWidget.small(),
              Expanded(
                child: Text(
                  '$countNewDeliveries $title',
                  style: const TextStyle(color: CustomColors.cinza, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: countNewDeliveries > 0 ? context.theme.colorScheme.tertiary : context.theme.colorScheme.onPrimary, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
