import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/shared.dart';

class CardHomeSimplesWidget extends StatelessWidget {
  const CardHomeSimplesWidget({super.key, required this.count, required this.icon, required this.title, this.onTap});

  final int count;
  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: count > 0 ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40, // Reduzido
                    height: 40, // Reduzido
                    decoration: BoxDecoration(color: count > 0 ? context.theme.colorScheme.primary : context.theme.colorScheme.onPrimary, borderRadius: BorderRadius.circular(8)),
                    child: Icon(icon, color: count > 0 ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onPrimary.withAlpha((0.5 * 255).round()), size: 24),
                  ),
                  if (count > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(color: context.theme.colorScheme.tertiary, borderRadius: BorderRadius.circular(8)),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          count.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              SpaceWidget.small(),
              Text(
                title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: count > 0 ? CustomColors.preto : CustomColors.cinza),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
