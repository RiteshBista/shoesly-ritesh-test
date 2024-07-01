import 'package:flutter/material.dart';

extension NumX on num {
  Widget get verticalSpacer => SizedBox(height: toDouble());
  Widget get horizontalSpacer => SizedBox(width: toDouble());
}

// class VerticalSpacing extends StatelessWidget {
//   const VerticalSpacing(
//     this.height, {
//     super.key,
//   });
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//     );
//   }
// }

// class HorizontalSpacing extends StatelessWidget {
//   const HorizontalSpacing(
//     this.width, {
//     super.key,
//   });
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//     );
//   }
// }
