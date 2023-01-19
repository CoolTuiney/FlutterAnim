import 'package:flutter/material.dart';

Color primaryColor = const Color.fromARGB(255, 74, 84, 236);

class CustomBottomNav extends StatefulWidget {
  CustomBottomNav(
      {Key? key, required this.currPage, required this.switchScreen})
      : super(key: key);
  int currPage;
  final Function switchScreen;
  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late ScrollController _scrollController;
  late double _scrollPositon;
  late int currentIndex;
  int pv = 85;
  bool isScrolling = false;
  List<IconData> icList = [
    Icons.person,
    Icons.music_note_sharp,
    Icons.currency_rupee_sharp,
    Icons.book
  ];

  @override
  void initState() {
    currentIndex = widget.currPage;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollPositon = _scrollController.position.pixels;

      setCurrentIndex();
    });
    super.initState();
  }

  void setCurrentIndex() {
    for (int i = 0; i < 5; i++) {
      if (willSetState() &&
          _scrollPositon >= pv * (i) &&
          _scrollPositon < pv * (i + 1)) {
        setState(() {
          currentIndex = i;
        });
      }
    }
  }

  bool willSetState() {
    for (int i = 0; i < 5; i++) {
      if (currentIndex == i &&
          _scrollPositon >= (pv * i) - 1 &&
          _scrollPositon <= pv * (i + 1) - 1) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size.width * 0.39,
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, i) => NavBtn(
                        index: i,
                        selectedIndex: currentIndex,
                        willfocus: !isScrolling,
                        icon: icList[i],
                      )),
            ),
            SizedBox(
              width: size.width * 0.42,
            ),
          ],
        ),
      ),
    );
  }

  bool onNotification(scrollNotification) {
    if (scrollNotification is ScrollStartNotification) {
      _onStartScroll(scrollNotification.metrics);
    } else if (scrollNotification is ScrollUpdateNotification) {
      _onUpdateScroll(scrollNotification.metrics);
    } else if (scrollNotification is ScrollEndNotification) {
      _onEndScroll(scrollNotification.metrics);
    }
    return true;
  }

  void _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      isScrolling = true;
    });
  }

  void _onUpdateScroll(ScrollMetrics metrics) {}

  void _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      isScrolling = false;
      widget.switchScreen(currentIndex);
    });
    Scrollable.ensureVisible(
      context,
    );
  }
}

class NavBtn extends StatelessWidget {
  const NavBtn({
    Key? key,
    required this.index,
    required this.selectedIndex,
    required this.willfocus,
    required this.icon,
  }) : super(key: key);
  final int index;
  final int selectedIndex;
  final bool willfocus;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(right: (index != 3) ? 30 : 0),
      decoration: BoxDecoration(
        color: getBgColor(),
        shape: BoxShape.circle,
        boxShadow: getShadow(),
      ),
      child: Icon(
        icon,
        size: 40,
        color: getIconColor(),
      ),
    );
  }

  List<BoxShadow> getShadow() {
    var bgColor = getBgColor();
    // if (selectedIndex != index) {
    //   return [];
    // }
    if (selectedIndex == index && willfocus) {
      return [
        BoxShadow(
            color: bgColor.withOpacity(0.5), spreadRadius: 7, blurRadius: 0),
      ];
    }
    return [
      const BoxShadow(
          color: Colors.black12,
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 2)),
    ];
  }

  Color getBgColor() {
    if (selectedIndex != index) {
      return primaryColor.withOpacity(0.3);
    }
    if (willfocus) {
      return Colors.white;
    }
    return const Color.fromARGB(255, 74, 84, 236);
  }

  Color getIconColor() {
    if (selectedIndex != index) {
      return Colors.grey.shade300;
    }
    if (willfocus) {
      return Colors.grey.shade700;
    }
    return Colors.white;
  }
}
