import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animation/Chucker/ch_provider.dart';
import 'package:flutter_animation/Chucker/network_screen.dart';
import 'package:provider/provider.dart';

class ChuckerHomeScreen extends StatelessWidget {
  const ChuckerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chucker'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'NETWORK',
            ),
            Tab(
              text: 'ERROR',
            )
          ]),
        ),
        body: const TabBarView(children: [
          ChNetworkScreen(),
          Center(
            child: Text('2'),
          )
        ]),
      ),
    );
  }
}
