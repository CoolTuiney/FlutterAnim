import 'package:flutter/material.dart';
import 'package:flutter_animation/CartDetails/custom_bottom_nav.dart';

import '../../color_constants.dart';
import 'face_icon_anim.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedTabIndex = 3;
  double begin = 0;
  double end = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Bar'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Container(
          height: 75,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: tabBarBgColor, borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TabIcon(
                icon: Icons.home,
                selectedTabIndex: selectedTabIndex,
                selectedColor: yellow,
                index: 0,
                onTap: changeSelectedTabIndex,
              ),
              TabIcon(
                icon: Icons.music_note,
                selectedTabIndex: selectedTabIndex,
                selectedColor: green,
                index: 1,
                onTap: changeSelectedTabIndex,
              ),
              // ignore: avoid_types_as_parameter_names
              IconFace(
                index: 2,
                onTap: changeSelectedTabIndex,
                selectedColor: blue,
                selectedTabIndex: selectedTabIndex,
                begin: begin,
                end: end,
              ),
              TabIcon(
                icon: Icons.search,
                selectedTabIndex: selectedTabIndex,
                selectedColor: red,
                onTap: changeSelectedTabIndex,
                index: 3,
              ),
              TabIcon(
                icon: Icons.notifications_active,
                selectedTabIndex: selectedTabIndex,
                selectedColor: purple,
                onTap: changeSelectedTabIndex,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeSelectedTabIndex(int index) {
    setState(() {
      selectedTabIndex = index;
      setAnimTweenValue();
    });
  }

  void setAnimTweenValue() {
    double endVal = -4;
    for (int i = 0; i < 5; i++) {
      if (selectedTabIndex == i) {
        begin = end;
        end = endVal;
        break;
      }
      endVal += 2;
    }
    setState(() {});
  }
}

class TabIcon extends StatefulWidget {
  TabIcon(
      {Key? key,
      required this.icon,
      required this.selectedColor,
      required this.index,
      required this.selectedTabIndex,
      required this.onTap})
      : super(key: key);
  final IconData icon;
  final Color selectedColor;
  final int index;
  int selectedTabIndex;
  Function(int) onTap;

  @override
  State<TabIcon> createState() => _TabIconState();
}

class _TabIconState extends State<TabIcon> {
  final inActiveColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      child: Icon(
        widget.icon,
        color: (widget.selectedTabIndex == widget.index)
            ? widget.selectedColor
            : inActiveColor,
        size: (widget.selectedTabIndex == widget.index) ? 40 : 35,
      ),
    );
  }
}
