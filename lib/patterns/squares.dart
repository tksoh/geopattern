import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A nx x ny repeating grid of squares
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/squares.png
class Squares extends GeoPattern {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Squares(
      {required this.side,
      required this.nx,
      required this.ny,
      required this.fillColors,
      required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  Squares.fromHash(String hash)
      : assert(hash.length == 40),
        side = int.parse(hash[0], radix: 16) / 16.0 * 50 + 10,
        nx = 6,
        ny = 6,
        fillColors = GeoPattern.hashColors(hash),
        strokeColor = Color.fromARGB(50, 0, 0, 0);

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor;
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;
        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];
        final rect = Rect.fromLTWH(
            x * side + offset.dx, y * side + offset.dy, side, side);
        canvas.drawRect(rect, strokePaint);
        canvas.drawRect(rect, fillPaint);
      }
    }
  }

  Size get size => Size(nx * side, ny * side);
}
