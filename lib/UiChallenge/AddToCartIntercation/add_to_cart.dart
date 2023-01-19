import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/CartDetails/custom_bottom_nav.dart';

import 'adding_to_cart_anim.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool isAddingToCart = false;
  Widget body = const AddToCartWidget();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add To Cart'),
        backgroundColor: primaryColor,
      ),
      body: GestureDetector(
        onTap: () {
          onClickAddToCart();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeOutBack,
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, 0.5), end: const Offset(0, 0))
                    .animate(animation),
                child: child,
              ),
              child: body,
            ),
          ),
        ),
      ),
    );
  }

  void onClickAddToCart() {
    body = const SizedBox();
    setState(() {});
    Future.delayed(Duration(milliseconds: 200), () {
      body = AddingToCartAnim(
        onAdded: onAdded,
      );
      setState(() {});
    });
  }

  void onAdded() {
    body = const AddedToCart();
    setState(() {});
  }
}

class AddedToCart extends StatelessWidget {
  const AddedToCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.check, size: 30, color: Colors.green),
        SizedBox(
          width: 20,
        ),
        Text(
          'Added',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green),
        ),
      ],
    );
  }
}

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 35,
        ),
        Icon(Icons.add, size: 30, color: Colors.grey.shade700),
        const SizedBox(
          width: 20,
        ),
        Text(
          'Add To Cart',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
