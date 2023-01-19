import 'dart:developer';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/Chucker/ch_provider.dart';

import 'package:flutter_animation/TabBarAnim/tab_bar_anim.dart' as tab;
import 'package:flutter_animation/UiChallenge/WeatherRebound/weather_rebound.dart';
import 'package:provider/provider.dart';

import 'Chucker/floating_fab.dart';
import 'FabAnim/fab_anim.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ChuckerHttpProvider(),
      child: MaterialApp(
        navigatorKey: _navKey,
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const tab.TabBarAnim(),
        builder: (context, child) => Stack(
          children: [
            child!,
            FloatingFAB(
              navKey: _navKey,
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: const CircularFabWidget(),
    );
  }
}
