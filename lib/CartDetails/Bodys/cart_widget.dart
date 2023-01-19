import 'dart:ui';

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 16,
          spreadRadius: 16,
          color: Colors.black.withOpacity(0.1),
        )
      ]),
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
    );
  }
}
