import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/overlapping_circles.dart';
import 'package:geopattern_flutter/patterns/pattern.dart';

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
            buildDecoratedCard(Colors.red),
            buildDecoratedCard(Colors.blue),
            buildDecoratedCard(Colors.green),
            buildDecoratedCard(Colors.cyan),
            buildDecoratedCard(Colors.teal),
            buildDecoratedCard(Colors.orange),
          ]))
        ],
      ),
    ));
  }

  Widget buildDecoratedCard(Color background) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 200,
        decoration: CustomDecoration(background: background),
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

class CustomDecoration extends Decoration {
  final Color? background;

  const CustomDecoration({this.background});

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
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
    return BoxDecorationPainter(pattern: pattern, background: background);
  }
}

class BoxDecorationPainter extends BoxPainter {
  final Color? background;
  GeoPattern pattern;
  BoxDecorationPainter({required this.pattern, this.background});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    if (background != null) {
      canvas.drawColor(background!, BlendMode.srcOver);
    }

    GeoPainter.drawPattern(canvas, pattern, size);
  }
}
