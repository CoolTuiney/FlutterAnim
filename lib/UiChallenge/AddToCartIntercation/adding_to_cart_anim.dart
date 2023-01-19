import 'dart:math';

import 'package:flutter/material.dart';

class AddingToCartAnim extends StatefulWidget {
  AddingToCartAnim({Key? key, required this.onAdded}) : super(key: key);
  Function onAdded;

  @override
  State<AddingToCartAnim> createState() => _AddingToCartAnimState();
}

class _AddingToCartAnimState extends State<AddingToCartAnim>
    with SingleTickerProviderStateMixin {
  Alignment align = Alignment.centerLeft;
  late AnimationController _animcontroller;
  late Animation _angleAnim;
  late bool isEndAnimCompleted = false;
  late bool isCartVisible = true;
  Color icColor = Colors.grey.shade700;

  @override
  void initState() {
    super.initState();
    _animcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _angleAnim = Tween<double>(begin: 0, end: 0.3).animate(_animcontroller);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animcontroller.forward().then((value) {
        _animcontroller.reverse();
        alignToCenter();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(children: [
          const SizedBox(
            width: 35,
          ),
          Expanded(
            child: AnimatedAlign(
                onEnd: () {
                  if (isEndAnimCompleted) {
                    setState(() {
                      isCartVisible = false;
                    });
                    widget.onAdded();
                    return;
                  }
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _animcontroller.forward().then((value) {
                      _animcontroller.reverse();
                      setState(() {
                        isEndAnimCompleted = true;
                        align = Alignment.centerRight;
                      });
                    });
                  });
                },
                alignment: align,
                duration: const Duration(milliseconds: 400),
                child: Visibility(
                  visible: isCartVisible,
                  child: AnimatedBuilder(
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: pi * 2 - _angleAnim.value,
                        child: Icon(Icons.shopping_cart_outlined,
                            size: 30, color: icColor),
                      );
                    },
                    animation: _angleAnim,
                  ),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
        ]),
        const Center(child: ColorBallDropingAnim()),
      ],
    );
  }

  void alignToCenter() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        align = Alignment.center;
      });
      Future.delayed(
          const Duration(
            milliseconds: 500,
          ), () {
        setState(() {
          icColor = Colors.green;
          isEndAnimCompleted = true;
        });
      });
    });
  }
}

class ColorBallDropingAnim extends StatefulWidget {
  const ColorBallDropingAnim({Key? key}) : super(key: key);

  @override
  State<ColorBallDropingAnim> createState() => _ColorBallDropingAnimState();
}

class _ColorBallDropingAnimState extends State<ColorBallDropingAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation _droppingAnim,
      _droppingAnim1,
      _droppingAnim2,
      _droppingAnim3;
  double x = 7;
  bool isBallsVisible = true;
  @override
  void initState() {
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _droppingAnim = _droppingTween(0, 1, 0.65, 1);
    _droppingAnim1 = _droppingTween(0.25, 1, 0.45, 1);
    _droppingAnim2 = _droppingTween(0.45, 1, 0.25, 1);
    _droppingAnim3 = _droppingTween(0.65, 1, 0, 1);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animController.forward().whenComplete(() {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isBallsVisible = false;
          });
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          _animController.reverse();
        });
      });
    });
  }

  Animation<double> _droppingTween(
    double beginI,
    double endI,
    double b,
    double e,
  ) {
    return Tween<double>(begin: 0, end: 25).animate(CurvedAnimation(
        parent: _animController,
        curve: Interval(beginI, endI, curve: Curves.easeOutBack),
        reverseCurve: Interval(b, e, curve: Curves.easeOutBack)));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isBallsVisible,
      child: AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: BallPainter(
                      index: 0,
                      val: _droppingAnim.value,
                      x: resetOffsetToCenter(0)),
                ),
                CustomPaint(
                  painter: BallPainter(
                      index: 1,
                      val: _droppingAnim1.value,
                      x: resetOffsetToCenter(1)),
                ),
                CustomPaint(
                  painter: BallPainter(
                      index: 2,
                      val: _droppingAnim2.value,
                      x: resetOffsetToCenter(2)),
                ),
                CustomPaint(
                  painter: BallPainter(
                      index: 3,
                      val: _droppingAnim3.value,
                      x: resetOffsetToCenter(3)),
                ),
              ],
            );
          }),
    );
  }

  double resetOffsetToCenter(int multiplier) {
    if (_animController.status == AnimationStatus.reverse && multiplier == 0) {
      return x * multiplier + (_animController.value * 4);
    } else if (_animController.status == AnimationStatus.reverse &&
        multiplier == 3) {
      return x * multiplier - (_animController.value * 4);
    }
    return x * multiplier;
  }
}

class BallPainter extends CustomPainter {
  BallPainter({required this.x, required this.val, required this.index});
  double val;
  double x;
  int index;
  var colorList = [Colors.blue, Colors.green, Colors.orange, Colors.red];
  @override
  void paint(Canvas canvas, Size size) {
    var paintBalls = Paint()..strokeWidth = 10;
    var w = size.width;
    var h = size.height;

    paintBalls.color = colorList[index];
    var offset = Offset(w + x, h - val);
    
    canvas.drawCircle(offset, 2.5, paintBalls);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
