import 'package:flutter/material.dart';

class HorizontalWavyPathPainter extends CustomPainter {
  final List<Offset> centers;

  HorizontalWavyPathPainter(this.centers);

  @override
  void paint(Canvas canvas, Size size) {
    if (centers.length < 2) return;

    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(centers[0].dx, centers[0].dy);

    // Nối các điểm bằng quadratic Bezier cho mềm mượt
    for (int i = 0; i < centers.length - 1; i++) {
      final p0 = centers[i];
      final p1 = centers[i + 1];

      final control = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);

      path.quadraticBezierTo(control.dx, control.dy, p1.dx, p1.dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant HorizontalWavyPathPainter oldDelegate) {
    return oldDelegate.centers != centers;
  }
}
