library geopattern_flutter;

import 'package:flutter/widgets.dart';

import 'patterns/pattern.dart';

/// A CustomPainter that takes a single pattern and draws it across the entire canvas.
class GeoPainter extends CustomPainter {
  Color background;
  GeoPattern pattern;

  GeoPainter({required this.pattern, required this.background});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(background, BlendMode.color);
    drawPattern(canvas, pattern, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  static drawPattern(Canvas canvas, GeoPattern pattern, Size size) {
    for (var i = 0.0; i < size.height; i += pattern.size.height) {
      for (var j = 0.0; j < size.width; j += pattern.size.width) {
        pattern.paint(canvas, Offset(j, i));
      }
    }
  }
}
