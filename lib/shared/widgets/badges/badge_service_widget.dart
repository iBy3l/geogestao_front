// import 'package:flutter/material.dart';

// class BadgeServiceWidget extends StatelessWidget {
//   const BadgeServiceWidget({
//     super.key,
//     required this.service,
//   });

//   final ServiceEntity service;

//   @override
//   Widget build(BuildContext context) {
//     String status = service.status == ServiceStatus.open ? 'Aberto' : 'Fechado';
//     Color color = service.status == ServiceStatus.open ? context.theme.colorScheme.tertiaryContainer : context.theme.colorScheme.tertiary;
//     Icon icon = service.status == ServiceStatus.open ? Icon(context.icon.relogio, color: color, size: 16) : Icon(context.icon.check, color: color, size: 16);
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//       decoration: BoxDecoration(
//         color: service.status == ServiceStatus.open ? context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.3) : context.theme.colorScheme.tertiary.withValues(alpha: 0.3),
//         borderRadius: BorderRadius.circular(45),
//         border: Border.all(color: color),
//       ),
//       child: Row(
//         spacing: 2,
//         children: [
//           icon,
//           Text(
//             status,
//             style: context.textTheme.titleMedium?.copyWith(color: service.status == ServiceStatus.open ? context.theme.colorScheme.tertiaryContainer : context.theme.colorScheme.tertiary),
//           ),
//         ],
//       ),
//     );
//   }
// }
