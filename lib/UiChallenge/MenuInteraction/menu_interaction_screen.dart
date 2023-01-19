import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animation/CartDetails/custom_bottom_nav.dart';

class MenuInteractionScreen extends StatefulWidget {
  const MenuInteractionScreen({Key? key}) : super(key: key);

  @override
  State<MenuInteractionScreen> createState() => _MenuInteractionScreenState();
}

class _MenuInteractionScreenState extends State<MenuInteractionScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  bool showMenuItem = false;
  List<Widget> menuItem = [];

  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Menu Interaction'),
      ),
      body: Align(
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          width: isCollapsed ? 55 : 220,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(50)),
          duration: const Duration(milliseconds: 200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    // size: (isCollapsed) ? 35 : 25,
                    size: 35,
                    color: Colors.white,
                    progress: _animationController),
              ),
              ...menuItem
            ],
          ),
        ),
      ),
    );
  }

  Container customIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon),
    );
  }

  onTap() {
    int duration = 200;
    setState(() {
      if (isCollapsed) {
        _animationController.forward();
        addItemToList();
      } else {
        duration = 0;
        menuItem.clear();
        _animationController.reverse();
      }
      isCollapsed = !isCollapsed;
    });
    Future.delayed(Duration(milliseconds: duration), () {
      showMenuItem = !showMenuItem;
      setState(() {});
    });
  }

  void addItemToList() {
    var items = [
      customIcon(Icons.search),
      customIcon(Icons.person_outline),
      customIcon(Icons.music_note_outlined),
    ];
    for (var e in items) {
      Future.delayed(const Duration(milliseconds: 100), () {
        menuItem.add(e);
      });
    }
  }
}
