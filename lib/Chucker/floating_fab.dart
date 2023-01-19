import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/Chucker/ch_home_screen.dart';
import 'package:flutter_animation/Chucker/ch_provider.dart';
import 'package:flutter_animation/main.dart';
import 'package:provider/provider.dart';

import '../UiChallenge/WeatherRebound/weather_rebound.dart';

class FloatingFAB extends StatefulWidget {
  const FloatingFAB({
    Key? key,
    required this.navKey,
  }) : super(key: key);
  final GlobalKey<NavigatorState>? navKey;

  @override
  State<FloatingFAB> createState() => _FloatingFABState();
}

class _FloatingFABState extends State<FloatingFAB> {
  var _offset = Offset.zero;
  bool willShow = true;

  @override
  Widget build(BuildContext context) {
    var chuckerHttpProvider = Provider.of<ChuckerHttpProvider>(context);
    return Visibility(
      visible: willShow,
      child: Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
            onPanUpdate: (d) {
              setState(() => _offset += Offset(d.delta.dx, d.delta.dy));
            },
            child: ChuckerFlutter.chuckerButton,

            // child: FloatingActionButton(
            //   backgroundColor: Colors.amber,
            //   onPressed: () {

            //     // debugPrint('${chuckerHttpProvider.getHttpResList}');
            //     // setState(() {
            //     //   willShow = false;
            //     // });
            //     // widget.navKey.currentState!
            //     //     .push(MaterialPageRoute(
            //     //         builder: (context) => const ChuckerHomeScreen()))
            //     //     .whenComplete(() => setState(() {
            //     //           willShow = true;
            //     //         }));
            //   },
            //   child: const Icon(
            //     Icons.settings,
            //     color: Colors.black,
            //   ),
            // ),
          )),
    );
  }
}
