import 'package:flutter/material.dart';
import 'package:hcs_mobile/utils/theme.dart';


class ClipPathWidget extends StatelessWidget {
  final Color color;
  const ClipPathWidget({ Key? key,required this.color }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: ShapesPainter(color: color),
        child: Container(height: 150),
      );
  }
}

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  final Color color;
  const ShapesPainter({ Key? key,required this.color }) : super();
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}