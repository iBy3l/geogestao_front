// import 'package:flutter/material.dart';

// class DatalilsInterationWidget extends StatelessWidget {
//   const DatalilsInterationWidget({super.key, required this.interaction});

//   final Interaction interaction;

//   @override
//   Widget build(BuildContext context) {
//     return CardWidget(
//       child: Column(
//         spacing: 4,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             spacing: 8,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(interaction.name ?? '', style: context.textTheme.titleMedium?.copyWith(color: context.primaryColor).copyWith(fontWeight: FontWeight.bold)),
//               Row(
//                 spacing: 4,
//                 children: [
//                   Icon(context.icon.check, color: context.theme.primaryColor),
//                   Text(convertDateTime(interaction.date ?? DateTime.now()), style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline)),
//                 ],
//               ),
//             ],
//           ),
//           Text(interaction.description ?? '', style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.outline).copyWith(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

// String convertData(DateTime date) {
//   return '${date.day}/${date.month}/${date.year}';
// }

// String convertTime(DateTime time) {
//   return '${time.hour}:${time.minute}';
// }

// String convertDateTime(DateTime date) {
//   return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
// }
