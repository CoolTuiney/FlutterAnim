import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../CartDetails/custom_bottom_nav.dart';

class UploadBtnInteraction extends StatelessWidget {
  const UploadBtnInteraction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Menu Interaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Flexible(child: CircularUploadBtn()),
            UploadBtnWithText(),
          ],
        ),
      ),
    );
  }
}

class UploadBtnWithText extends StatelessWidget {
  const UploadBtnWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: UploadBorderPainter(
        borderColor: Colors.black,
        progress: 0.5,
      ),
      child: const SizedBox(
        width: 100,
        height: 200,
      ),
    );
  }
}

class UploadBorderPainter extends CustomPainter {
  UploadBorderPainter(
      {required this.progress, required this.borderColor, this.strokeWdth});
  double progress; // desirable value for corners side
  double? strokeWdth;
  Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    double x = min(size.height, size.width);
    double x2 = x / 2;
    double x4 = x / 4;

    Paint paintt = Paint()
      ..color = progress == 0 ? Colors.transparent : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWdth ?? 4.0;
    // ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(x2, x)
      ..lineTo(x4, x)
      ..quadraticBezierTo(0, x, 0, x - x4)
      ..lineTo(0, x4)
      ..quadraticBezierTo(0, 0, x4, 0)
      ..lineTo(x - x4, 0)
      ..quadraticBezierTo(x, 0, x, x4)
      ..lineTo(x, x - x4)
      ..quadraticBezierTo(x, x, x - x4, x)
      ..lineTo(x2, x);

    canvas.drawPath(path, paintt);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircularUploadBtn extends StatefulWidget {
  const CircularUploadBtn({
    Key? key,
  }) : super(key: key);

  @override
  State<CircularUploadBtn> createState() => _CircularUploadBtnState();
}

class _CircularUploadBtnState extends State<CircularUploadBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> uploadTween;
  late Widget icon;
  @override
  void initState() {
    icon = const Icon(
      Icons.arrow_upward,
      size: 35,
      color: Colors.white,
    );
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    uploadTween = Tween<double>(begin: 0, end: 1).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: uploadTween,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () => onTap(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: CircularProgressIndicator(
                      value: uploadTween.value,
                      color: primaryColor.withOpacity(0.8),
                      strokeWidth: 6,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: icon,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  onTap() {
    icon = const SizedBox();
    setState(() {});
    _animationController.forward().then((value) {
      setState(() {
        icon = const Icon(
          Icons.check,
          size: 35,
          color: Colors.white,
        );
      });
    });
  }
}
