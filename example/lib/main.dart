import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/chevrons.dart';
import 'package:geopattern_flutter/patterns/concentric_circles.dart';
import 'package:geopattern_flutter/patterns/diamonds.dart';
import 'package:geopattern_flutter/patterns/hexagons.dart';
import 'package:geopattern_flutter/patterns/mosaic_squares.dart';
import 'package:geopattern_flutter/patterns/nested_squares.dart';
import 'package:geopattern_flutter/patterns/octagons.dart';
import 'package:geopattern_flutter/patterns/overlapping_circles.dart';
import 'package:geopattern_flutter/patterns/overlapping_rings.dart';
import 'package:geopattern_flutter/patterns/pattern.dart';
import 'package:geopattern_flutter/patterns/plaid.dart';
import 'package:geopattern_flutter/patterns/plus_signs.dart';
import 'package:geopattern_flutter/patterns/sine_waves.dart';
import 'package:geopattern_flutter/patterns/squares.dart';
import 'package:geopattern_flutter/patterns/triangles.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const hash = '3ddf120b430021c36c232c99ef8d926aea2acd6b';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Geo Patterns')),
        body: ListView(
          children: [
            _buildPatternTile(Chevrons.fromHash(hash)),
            _buildPatternTile(ConcentricCircles.fromHash(hash)),
            _buildPatternTile(Diamonds.fromHash(hash)),
            _buildPatternTile(Hexagons.fromHash(hash)),
            _buildPatternTile(MosaicSquares.fromHash(hash)),
            _buildPatternTile(NestedSquares.fromHash(hash)),
            _buildPatternTile(Octagons.fromHash(hash)),
            _buildPatternTile(OverlappingCircles.fromHash(hash)),
            _buildPatternTile(OverlappingRings.fromHash(hash)),
            _buildPatternTile(Plaid.fromHash(hash)),
            _buildPatternTile(PlusSigns.fromHash(hash)),
            _buildPatternTile(SineWaves.fromHash(hash)),
            _buildPatternTile(Squares.fromHash(hash)),
            _buildPatternTile(Triangles.fromHash(hash)),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternTile(GeoPattern pattern, {Color? background}) {
    return ListTile(
      title: Text(pattern.runtimeType.toString()),
      subtitle: Container(
        height: 200,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: CustomPaint(
          painter: GeoPainter(
            pattern: pattern,
            background: background ?? Colors.transparent,
          ),
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
      final gen = Random();
      final pattern = OverlappingCircles(
          radius: 60,
          nx: 6,
          ny: 6,
          fillColors: List.generate(
              36,
              (int i) => Color.fromARGB(
                  10 + (gen.nextDouble() * 100).round(),
                  50 + gen.nextInt(2) * 150,
                  50 + gen.nextInt(2) * 150,
                  50 + gen.nextInt(2) * 150)));
      return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: GeoPainter(pattern: pattern, background: Colors.yellow));
    });
  }
}
