import 'package:flutter/material.dart';
import 'package:flutter_animation/CartDetails/custom_bottom_nav.dart';
import 'package:flutter_animation/UiChallenge/CustomTabBar/custom_tab_bar.dart';
import 'package:flutter_animation/UiChallenge/MenuInteraction/menu_interaction_screen.dart';
import 'package:flutter_animation/UiChallenge/SubscribeInteraction/subscribe_interaction.dart';
import 'package:flutter_animation/UiChallenge/UploadBtnInteraction/upload_btn_screen.dart';

import 'AddToCartIntercation/add_to_cart.dart';
import 'WeatherRebound/weather_rebound.dart';

class UiChallengeScreen extends StatefulWidget {
  const UiChallengeScreen({Key? key}) : super(key: key);

  @override
  State<UiChallengeScreen> createState() => _UiChallengeScreenState();
}

class _UiChallengeScreenState extends State<UiChallengeScreen> {
  List<ListItemModel> items = [];
  @override
  void initState() {
    items = getItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.8),
      appBar: AppBar(
          backgroundColor: primaryColor, title: const Text('UI CHALLENGE')),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListItem(
              item: items[index],
            );
          }),
    );
  }

  navigateTo(dynamic screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  getItemList() {
    return [
      ListItemModel(
          icon: Icons.menu,
          onTap: () => navigateTo(const MenuInteractionScreen()),
          title: "Menu Interaction"),
      ListItemModel(
          icon: Icons.arrow_upward,
          onTap: () => navigateTo(const UploadBtnInteraction()),
          title: "Upload Button Interaction"),
      ListItemModel(
          icon: Icons.subscriptions,
          onTap: () => navigateTo(const SubscribeInteraction()),
          title: "Subscribe Button Interaction"),
      ListItemModel(
          icon: Icons.tab,
          onTap: () => navigateTo(const CustomTabBar()),
          title: "Custom Tab Bar"),
      ListItemModel(
          icon: Icons.shopping_cart_outlined,
          onTap: () => navigateTo(const AddToCart()),
          title: "Add To Cart"),
      ListItemModel(
          icon: Icons.cloud_outlined,
          onTap: () => navigateTo(const WeatherRebound()),
          title: "Weather Rebound")
    ];
  }
}

class ListItemModel {
  String title;
  IconData icon;
  VoidCallback onTap;
  ListItemModel({required this.icon, required this.onTap, required this.title});
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.item}) : super(key: key);

  final ListItemModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(item.icon),
            const SizedBox(
              width: 15,
            ),
            Text(
              item.title,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
