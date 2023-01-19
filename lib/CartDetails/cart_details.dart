import 'package:flutter/material.dart';
import 'package:flutter_animation/CartDetails/Bodys/book_widget.dart';
import 'package:flutter_animation/CartDetails/Bodys/music_widget.dart';
import 'package:flutter_animation/CartDetails/Bodys/rupee_widget.dart';
import 'package:flutter_animation/CartDetails/custom_bottom_nav.dart';
import 'Bodys/cart_widget.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  final PageController _pageController = PageController();
  int currPage = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 74, 84, 236).withOpacity(0.8),
        ),
        backgroundColor:
            const Color.fromARGB(255, 74, 84, 236).withOpacity(0.8),
        body: Column(
          children: [
            // Expanded(child: getBody()),
            Expanded(
              child: Hero(
                tag: "${widget.index}",
                child: getBody(),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 120,
              child: CustomBottomNav(
                currPage: currPage,
                switchScreen: switchScreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (value) => setState(() {
        currPage = value;
      }),
      children: const [
        CardWidget(),
        MusicWidget(),
        RupeeWidget(),
        BookWidget(),
      ],
    );
  }

  switchScreen(int index) {
    setState(() {
      currPage = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
