// import 'package:flutter/material.dart';
// import 'package:math/common/widget/slide_up_route.dart';
// import 'package:math/features/home/models/roadmap.dart';
// import 'package:math/features/video/presentation/pages/video_page.dart';

// class ProgressPopupContent extends StatelessWidget {
//   final Progress progress;

//   const ProgressPopupContent({super.key, required this.progress});

//   @override
//   Widget build(BuildContext context) {
//     final isLocked = progress.isLocked ?? false;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Step ${progress.stepNumber}',
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           progress.contentType?.toUpperCase() ?? 'BÀI HỌC',
//           style: TextStyle(color: Colors.grey.shade600),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: 160,
//           child: ElevatedButton(
//             onPressed: isLocked
//                 ? null
//                 : () {
//                     Navigator.pop(context);

//                     if (progress.contentType?.toLowerCase() == 'video') {
//                       Navigator.of(context).push(
//                         SlideUpRoute(
//                           page: VideoPage(
//                             progressId: progress.id ?? "",
//                             videoId: progress.id ?? "",
//                           ),
//                         ),
//                       );
//                     }
//                   },
//             child: Text(isLocked ? 'Đã khóa 🔒' : 'Bắt đầu'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class PopupWithArrow extends StatelessWidget {
//   final Widget child;

//   const PopupWithArrow({super.key, required this.child});

//   static const double arrowWidth = 10;

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _LeftArrowPainter(),
//       child: Container(
//         margin: const EdgeInsets.only(left: arrowWidth), // chừa chỗ cho mũi tên
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 8,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: child,
//       ),
//     );
//   }
// }

// class _LeftArrowPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.white;

//     final centerY = size.height / 2;

//     final path = Path()
//       ..moveTo(10, centerY - 8)
//       ..lineTo(0, centerY)
//       ..lineTo(10, centerY + 8)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
