import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class ProgressRingPainter extends CustomPainter {
  late Paint _paint;

  final Animation<double> progress;

  late PathMetric pathMetric;

  final double strokeW;
  //圆框颜色
  final Color circularRingColor;
  //圆环颜色
  final Color progressColor;

  final Size size;

  ProgressRingPainter(
      {required this.progress,
      this.circularRingColor = Colors.black38,
      this.progressColor = Colors.pinkAccent,
      required this.size,
      this.strokeW = 10})
      : super(repaint: progress) {
    Path _path = Path();
    _path.addOval(
        Rect.fromCenter(center: const Offset(0, 0),
         width: size.width-strokeW, height: size.height-strokeW));
    pathMetric = _path.computeMetrics().first;
    _paint = Paint()
      ..color = circularRingColor
      ..strokeWidth = strokeW
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    //绘制完整的圆环
    canvas.drawCircle(Offset.zero, (size.width - strokeW) / 2, _paint);
    canvas.rotate(-pi / 2);
    //绘制进度条
    canvas.drawPath(
        pathMetric.extractPath(0, pathMetric.length * progress.value),
        Paint()
          ..color = progressColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeW
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant ProgressRingPainter oldDelegate) {
    return progress.value != oldDelegate.progress.value;
  }
}
