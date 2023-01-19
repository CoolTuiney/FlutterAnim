import 'dart:math';

import 'package:flutter/material.dart';

import '../../CartDetails/custom_bottom_nav.dart';
import '../../FabAnim/fab_anim.dart';

class WeatherRebound extends StatelessWidget {
  const WeatherRebound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Weather Rebound'),
      ),
      body: const WeatherBody(),
    );
  }
}

class WeatherBody extends StatefulWidget {
  const WeatherBody({Key? key}) : super(key: key);

  @override
  State<WeatherBody> createState() => _WeatherBodyState();
}

class _WeatherBodyState extends State<WeatherBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  IconData menu = Icons.menu;

  late Animation<double> curveAnimation;

  late Animation<double> animation;

  int anim_duration = 450;
  @override
  void initState() {
    menu = Icons.menu;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: anim_duration));
    curveAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutSine));
    animation = curveAnimation;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: PopupMenuButton(
        icon: Icon(Icons.person_outline),
        offset: Offset(-55, -40),
        // shape: const TooltipShape(),
        elevation: 0,
        color: Colors.transparent,

        itemBuilder: (_) => <PopupMenuEntry>[
          PopupMenuItem(
              child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(25)),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.music_note),
                    Icon(Icons.music_note),
                    Icon(Icons.music_note),
                  ],
                ),
              ),
              CustomPaint(size: const Size(10, 10), painter: DrawTriangle())
            ],
          )),
        ],
      ),
    );
  }
}

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    // path.moveTo(size.width / 2, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.amber);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
