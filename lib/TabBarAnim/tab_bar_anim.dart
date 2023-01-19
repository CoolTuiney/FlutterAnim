import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/CartDetails/cart_details.dart';
import 'package:flutter_animation/UiChallenge/ui_challenge_screen.dart';
import 'package:flutter_animation/api_calls.dart';

class TabBarAnim extends StatefulWidget {
  const TabBarAnim({Key? key}) : super(key: key);

  @override
  State<TabBarAnim> createState() => _TabBarAnimState();
}

class _TabBarAnimState extends State<TabBarAnim>
    with SingleTickerProviderStateMixin {
  double spaceBetween = 10.0;
  final _duration = const Duration(milliseconds: 150);
  late AnimationController animController;
  late Animation<double> scaleT;
  late Animation<Color?> colorT;
  Color leftIcon = Colors.black;
  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animController = AnimationController(vsync: this, duration: _duration);

    colorT = ColorTween(begin: Colors.grey, end: Colors.black)
        .animate(animController);
    scaleT = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 1, end: 1.6), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 1.6, end: 1), weight: 50),
    ]).animate(animController);

    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isSelected = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isSelected = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ApiClass apiClass = ApiClass();
      apiClass.callSampleAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 74, 84, 236).withOpacity(0.8),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Flexible(
            child: HomeScreenBody(),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                animController.reverse();
                              } else {
                                animController.forward();
                              }
                            });
                          },
                          child: ScaleTransition(
                            scale: scaleT,
                            child: Icon(
                              Icons.face,
                              size: iconSize,
                              color: colorT.value,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UiChallengeScreen())),
                          child: Icon(
                            Icons.person_outline,
                            size: iconSize,
                          ),
                        )
                      ]),
                ),
              )),
        ],
      ),
      floatingActionButton: const CircularFabWidget(),
    );
  }
}

double buttonSizes = 68;
double iconSize = 38;

class CircularFabWidget extends StatefulWidget {
  const CircularFabWidget({Key? key}) : super(key: key);

  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late IconData menu;
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
    return Flow(
      delegate: FlowMenuDelegate(animation: animation),
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
        heroTag: UniqueKey(),
        backgroundColor: getColor(e),
        onPressed: () {
          if (e == menu) {
            if (animationController.status == AnimationStatus.completed) {
              animation = animationController;
              setState(() {});
              animationController.duration = const Duration(milliseconds: 250);
              animationController.reverse();

              menu = Icons.menu;
              setState(() {});
            } else {
              animation = curveAnimation;
              setState(() {});
              animationController.duration =
                  Duration(milliseconds: anim_duration);
              animationController.forward();
              menu = Icons.close;
              setState(() {});
            }
          } else {
            animation = animationController;
            setState(() {});
            animationController.duration = const Duration(milliseconds: 250);
            animationController.reverse();
            menu = Icons.menu;
            setState(() {});
          }
        },
        elevation: 0,
        splashColor: Colors.black,
        child: Icon(
          e,
          color: Colors.black.withOpacity(0.8),
          size: iconSize,
        ),
      ),
    );
  }

  Color getColor(IconData e) {
    if (e == Icons.mail) {
      return Colors.yellow;
    } else if (e == Icons.call) {
      return Colors.lightGreen;
    } else if (e == Icons.notifications) {
      return Colors.red;
    } else if (e == Icons.sms) {
      return Colors.lightBlue;
    } else if (e == Icons.close) {
      return Colors.white;
    } else {
      return Colors.blue;
    }
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> animation;
  FlowMenuDelegate({required this.animation}) : super(repaint: animation);
  @override
  void paintChildren(FlowPaintingContext context) {
    Size size = context.size;
    double xStart = (size.width / 2) - 20;
    double yStart = size.height - 90;
    var n = context.childCount;

    for (var i = 0; i < n; i++) {
      bool isLastItem = i == context.childCount - 1;
      Function(double value) setValue;
      setValue = (value) => isLastItem ? 0.0 : value;

      double radius = 120 * animation.value;
      double theta = ((i * pi * 0.6 / (n / 2)) * animation.value) + 0.4;
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

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  List<Widget> cards = [];
  List<Widget> items = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late Animatable<Offset> _offSet;

  double spaceBetween = 10.0;
  final _duration = const Duration(milliseconds: 150);
  late AnimationController animController;
  // late Animation<double> sizeAnim;
  bool showAnim = false;

  double scaleSize = 375;

  @override
  void initState() {
    super.initState();
    _offSet = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
    animController = AnimationController(vsync: this, duration: _duration);
    // sizeAnim = Tween<double>(begin: 375, end: 320).animate(animController);
    List.generate(4, (index) => items.addAll(getBody(index)));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addList();
    });
  }

  void addList() {
    Future ft = Future(() {});
    for (int i = 0; i < items.length; i++) {
      ft = ft.then((value) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          cards.add(items[i]);
          listKey.currentState!.insertItem(cards.length - 1);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          _onStartScroll(scrollNotification.metrics);
        } else if (scrollNotification is ScrollUpdateNotification) {
          _onUpdateScroll(scrollNotification.metrics);
        } else if (scrollNotification is ScrollEndNotification) {
          _onEndScroll(scrollNotification.metrics);
        }
        return true;
      },
      child: (!showAnim)
          ? AnimatedList(
              key: listKey,
              initialItemCount: cards.length,
              itemBuilder: (context, index, animation) {
                if (index == cards.length - 1) {
                  Future.delayed(Duration(milliseconds: 800), () {
                    setState(() {
                      showAnim = true;
                      items = [];
                    });
                  });
                }
                return SlideTransition(
                    key: UniqueKey(),
                    position: animation.drive(_offSet),
                    child: cards[index]);
              })
          : ListView(
              // physics: ClampingScrollPhysics(),
              children: [
                ...getBody(10),
                ...getBody(20),
                ...getBody(30),
                ...getBody(40),
              ],
            ),
    );
  }

  List<Widget> getBody(int index) {
    return [
      Center(
        child: Hero(
          tag: "$index",
          child: GestureDetector(
            onTap: () {
              ApiClass apiClass = ApiClass();
              apiClass.callSampleAPI(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartDetails(
                      index: index,
                    );
                  },
                ),
              );
            },
            child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 200,
              width: scaleSize,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
              duration: _duration,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20.0,
                    sigmaY: 20.0,
                  ),
                  child: Container(
                    width: 360,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.3),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white.withOpacity(0.75)),
                                child: const Text('Card'),
                              ),
                              Icon(
                                Icons.credit_card_sharp,
                                size: 30,
                                color: Colors.white.withOpacity(0.75),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.75)),
                                child: const Text('TL Templates'),
                              ),
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.75)),
                                child: const Text('07/25'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.75)),
                                child: const Text('5555 5555 5555 4444'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: _duration,
          height: spaceBetween),
    ];
  }

  _onStartScroll(ScrollMetrics metrics) {
    // if you need to do something at the start

    if (spaceBetween == 25.0) return;
    spaceBetween = 25.0;
    scaleSize = 320;

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
    scaleSize = 375;
    animController.forward();
    setState(() {});
  }
}
