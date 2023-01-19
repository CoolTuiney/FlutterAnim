import 'dart:math';

import 'package:flutter/material.dart';

class IconFace extends StatefulWidget {
  IconFace(
      {Key? key,
      required this.selectedTabIndex,
      required this.onTap,
      required this.selectedColor,
      required this.begin,
      required this.end,
      required this.index})
      : super(key: key);

  final Color selectedColor;
  final int index;
  int selectedTabIndex;
  Function(int) onTap;
  double begin;
  double end;

  @override
  State<IconFace> createState() => _IconFaceState();
}

class _IconFaceState extends State<IconFace> {
  double end = 0, begin = 0;

  int x = 0;

  @override
  Widget build(BuildContext context) {
    var color = (widget.selectedTabIndex == widget.index)
        ? widget.selectedColor
        : Colors.white;
    double size = (widget.selectedTabIndex == widget.index) ? 42 : 38;
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.index);
      },
      child: TweenAnimationBuilder<double>(
        curve: Curves.easeIn,
        builder: (context, value, child) {
          return SizedBox(
            height: size,
            width: size,
            child: CustomPaint(
              painter: FacePainter(bgColor: color, moveX: value),
            ),
          );
        },
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: widget.begin, end: widget.end),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final Color bgColor;
  double moveX;
  FacePainter({required this.bgColor, required this.moveX});
  @override
  void paint(Canvas canvas, Size size) {
    var w = size.width;
    var h = size.height;
    var halfW = w / 2 + moveX;
    var halfH = h / 2;
    var diffW = 5.0;
    var diffh = 10.0;
    var paint = Paint()
      ..color = bgColor
      ..strokeWidth = 3.0;
    var paintLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 10.0;
    var paintSmile = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var rect =
        Rect.fromCenter(center: Offset(h / 2, halfH), width: w, height: h);

    var rectEyeL = Rect.fromCenter(
        center: Offset(halfW - 6, halfH - 4), width: diffW, height: diffh);

    var rectEyeR = Rect.fromCenter(
        center: Offset(halfW + 6, halfH - 4), width: diffW, height: diffh);
    var arcOffset = Offset(halfW + 7, halfH + 7);
    var path = Path()
      ..moveTo(halfW - 7, halfH + 7)
      ..arcToPoint(arcOffset,
          radius: const Radius.circular(12), clockwise: false);

    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(15)), paint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rectEyeL, const Radius.circular(10)),
        paintLine);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rectEyeR, const Radius.circular(10)),
        paintLine);
    canvas.drawPath(path, paintSmile);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
