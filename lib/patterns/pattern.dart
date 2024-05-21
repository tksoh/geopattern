import 'dart:ui';

/// base class for all patterns
abstract class GeoPattern {
  /// paint renders a single instance of the pattern on the passed canvas
  /// at the specified offset.
  void paint(Canvas canvas, Offset offset);

  /// the size of the current pattern
  Size get size;

  static List<Color> hashColors(String hash) {
    return hash.split("").map((String c) {
      final v = int.parse(c, radix: 16);
      final a = ((v / 16.0) * 100 + 50).round();
      final r = 50 + (v % 2) * 150;
      final g = 50 + (v % 3) * 75;
      final b = 50 + (v % 4) * 50;
      return Color.fromARGB(a, r, g, b);
    }).toList();
  }
}
