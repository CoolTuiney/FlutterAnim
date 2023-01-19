import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/api_calls.dart';

double buttonSizes = 60;
double iconSize = 30;

class CircularFabWidget extends StatefulWidget {
  const CircularFabWidget({Key? key}) : super(key: key);

  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late IconData menu;

  @override
  void initState() {
    menu = Icons.menu;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ApiClass api = ApiClass();
      api.callSampleAPI(context);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(animation: animationController),
      children: [Icons.mail, Icons.call, Icons.notifications, Icons.sms, menu]
          .map<Widget>(buildFAB)
          .toList(),
    );
  }

  Widget buildFAB(IconData e) {
    return SizedBox(
      width: buttonSizes,
      height: buttonSizes,
      child: FloatingActionButton(
        onPressed: () {
          if (e == menu) {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();

              menu = Icons.menu;
              setState(() {});
            } else {
              animationController.forward();
              menu = Icons.close;
              setState(() {});
            }
          }
        },
        elevation: 0,
        splashColor: Colors.black,
        child: Icon(
          e,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> animation;
  FlowMenuDelegate({required this.animation}) : super(repaint: animation);
  @override
  void paintChildren(FlowPaintingContext context) {
    Size size = context.size;
    double xStart = size.width - 60;
    double yStart = size.height - 60;
    var n = context.childCount;

    for (var i = 0; i < n; i++) {
      bool isLastItem = i == context.childCount - 1;
      Function(double value) setValue;
      setValue = (value) => isLastItem ? 0.0 : value;

      double radius = 140 * animation.value;
      double theta = i * pi * 0.4 / (n / 2);
      double x = xStart - setValue(radius * cos(theta));
      double y = yStart - setValue(radius * sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(buttonSizes / 2, buttonSizes / 2)
          ..rotateZ(isLastItem
              ? 180 * (1 - animation.value / 2) * pi / 180
              : 180 * (1 - animation.value) * pi / 180)
          ..scale(isLastItem ? 1.0 : max(animation.value, 0.5))
          ..translate(-buttonSizes / 2, -buttonSizes / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
