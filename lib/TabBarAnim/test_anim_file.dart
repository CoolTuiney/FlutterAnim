import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> with SingleTickerProviderStateMixin {
  double spaceBetween = 10.0;
  final _duration = const Duration(milliseconds: 100);
  late AnimationController animController;
  late Animation sizeAnim;

  @override
  void initState() {
    super.initState();

    animController = AnimationController(vsync: this, duration: _duration);
    sizeAnim = Tween<double>(begin: 375, end: 300).animate(animController);
  }

  _onStartScroll(ScrollMetrics metrics) {
    // if you need to do something at the start
    if (spaceBetween == 25.0) return;
    spaceBetween = 25.0;

    animController.reverse();
    setState(() {});
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    // do your magic here to change the value
    // if (spaceBetween == 15.0) return;
    // spaceBetween = 15.0;
    // setState(() {});
  }

  _onEndScroll(ScrollMetrics metrics) {
    // do your magic here to return the value to normal
    spaceBetween = 10.0;

    animController.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(sizeAnim.value);
    print("Size:" + MediaQuery.of(context).size.width.toString());

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            _onStartScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            _onEndScroll(scrollNotification.metrics);
          }
          return true; // see docs
        },
        child: ListView(
          children: [
            ...getContent(),
            ...getContent(),
            ...getContent(),
            ...getContent(),
          ],
        ),
      ),
    );
  }

  List<Widget> getContent() {
    return [
      Center(
          child: AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: 20),
              duration: _duration,
              height: 200,
              width: sizeAnim.value,
              color: Colors.red)),
      AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: _duration,
          height: spaceBetween),
      Center(
          child: AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: 20),
              duration: _duration,
              height: 200,
              width: sizeAnim.value,
              color: Colors.blue)),
      AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: _duration,
          height: spaceBetween),
    ];
  }
}
