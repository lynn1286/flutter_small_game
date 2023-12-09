import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:small_game/canvas/models/line.dart';

class PaperPainter extends CustomPainter {
  late Paint _paint;
  final List<Line> lines;

  PaperPainter({
    required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke // 级联操作符
      ..strokeCap = StrokeCap.round;

    // 跟上面代码相同
    // _paint = Paint();
    // _paint.style = PaintingStyle.stroke;
    // _paint.strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  ///根据点位绘制线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
