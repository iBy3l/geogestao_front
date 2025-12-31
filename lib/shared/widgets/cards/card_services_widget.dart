// import 'package:flutter/material.dart';
// import 'package:rural_app/core/helper/extension_theme.dart';
// import 'package:rural_app/domain/entities/entities.dart';
// import 'package:rural_app/shared/shared.dart';

// class CardServiceWidget extends StatelessWidget {
//   const CardServiceWidget({super.key, required this.service, this.onTap});

//   final ServiceEntity service;
//   final Function(ServiceEntity)? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return CardWidget(
//       child: InkWell(
//         splashColor:CustomColorsScheme.primary.withValues(alpha: 0.1),
//         hoverColor:CustomColorsScheme.primary.withValues(alpha: 0.1),
//         borderRadius: const BorderRadius.all(Radius.circular(8)),
//         onTap: () {
//           if (onTap != null) {
//             onTap!(service);
//           }
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   spacing: 4,
//                   children: [
//                     Text(context.text.service, style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline)),
//                     Text(service.code ?? '', style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 BadgeServiceWidget(service: service),
//               ],
//             ),
//             SpaceWidget.small(),
//             Text(service.ruralProperty ?? '', style: context.textTheme.titleLarge?.copyWith(color: context.theme.colorScheme.scrim, fontWeight: FontWeight.bold)),
//             SpaceWidget.small(),
//             BadgeWidget(text: service.serviceType ?? '', color: context.primaryColor),
//             SpaceWidget.small(),
//             Text(service.description ?? '', style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline)),
//             SpaceWidget.small(),
//             Row(
//               spacing: 4,
//               children: [
//                 Icon(context.icon.calendar, color: context.theme.colorScheme.outline, size: 16),
//                 Text(service.createdAt ?? '', style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline)),
//               ],
//             ),
//             SpaceWidget.small(),
//             Row(
//               spacing: 4,
//               children: [
//                 Text("Produtor", style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline)),
//                 Text(service.ruralProperty ?? '', style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
