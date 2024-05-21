import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/diamonds.dart';
import 'package:geopattern_flutter/patterns/mosaic_squares.dart';
import 'package:geopattern_flutter/patterns/overlapping_circles.dart';
import 'package:geopattern_flutter/patterns/pattern.dart';
import 'package:geopattern_flutter/patterns/triangles.dart';

typedef PatternCallback = GeoPattern Function();

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Colors.yellow,
            expandedHeight: 256,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("AppBar"),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AppBarBackground(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            buildDecoratedCard(Colors.yellow, diamonds),
            buildDecoratedCard(Colors.blue, triangles),
            buildDecoratedCard(Colors.green, overlappingCircles),
            buildDecoratedCard(Colors.cyan, mosaicSquares),
          ]))
        ],
      ),
    ));
  }

  Widget buildDecoratedCard(Color background, PatternCallback pat) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 200,
        decoration: PatternDecoration(
          background: background,
          patType: pat,
        ),
      ),
    );
  }
}

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final pattern = overlappingCircles();
      return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: GeoPainter(pattern: pattern, background: Colors.yellow));
    });
  }
}

class PatternDecoration extends Decoration {
  final Color? background;
  final PatternCallback patType;

  const PatternDecoration({this.background, required this.patType});

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
    final pattern = patType();
    return BoxPatternPainter(pattern: pattern, background: background);
  }
}

class BoxPatternPainter extends BoxPainter {
  final Color? background;
  GeoPattern pattern;
  BoxPatternPainter({required this.pattern, this.background});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    if (background != null) {
      canvas.drawColor(background!, BlendMode.srcOver);
    }

    GeoPainter.drawPattern(canvas, pattern, size);
  }
}

GeoPattern overlappingCircles() {
  final gen = Random();
  return OverlappingCircles(
    radius: 60,
    nx: 6,
    ny: 6,
    fillColors: List.generate(
      36,
      (int i) => Color.fromARGB(
          10 + (gen.nextDouble() * 100).round(),
          50 + gen.nextInt(2) * 150,
          50 + gen.nextInt(2) * 150,
          50 + gen.nextInt(2) * 150),
    ),
  );
}

GeoPattern triangles() {
  final hash = sha1.convert(utf8.encode("flutter")).toString();
  return Triangles.fromHash(hash);
}

GeoPattern diamonds() {
  final hash = sha1.convert(utf8.encode("flutter")).toString();
  return Diamonds.fromHash(hash);
}

GeoPattern mosaicSquares() {
  final hash = sha1.convert(utf8.encode("flutter")).toString();
  return MosaicSquares.fromHash(hash);
}
