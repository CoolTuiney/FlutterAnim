import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animation/CartDetails/custom_bottom_nav.dart';

class SubscribeInteraction extends StatelessWidget {
  const SubscribeInteraction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('SUBSCRIBE BUTTON'),
      ),
      body: const SubscribeBtn(),
    );
  }
}

class SubscribeBtn extends StatefulWidget {
  const SubscribeBtn({Key? key}) : super(key: key);

  @override
  State<SubscribeBtn> createState() => _SubscribeBtnState();
}

class _SubscribeBtnState extends State<SubscribeBtn> {
  final txtStyle = const TextStyle(color: Colors.white, fontSize: 20);
  bool isSubscribing = false;
  Widget emailTF = const SizedBox();
  TextEditingController emailTxtController = TextEditingController();
  String btnText = "Subscribe";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          alignment: Alignment.centerRight,
          height: 60,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 2),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: isSubscribing,
                child: emailTF,
              ),
              AnimatedContainer(
                alignment: Alignment.center,
                height: 60,
                width: (isSubscribing) ? 60 : 300,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5,
                          spreadRadius: 2),
                    ]),
                duration: const Duration(milliseconds: 200),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: getAnimatedChild(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAnimatedChild() {
    if (isSubscribing) {
      return const Icon(
        Icons.double_arrow_rounded,
        color: Colors.white,
        size: 30,
      );
    }
    return Text(
      btnText,
      style: txtStyle,
    );
  }

  onTap() {
    var textfield = getEmailTextField();
    if (!isSubscribing) {
      Future.delayed(const Duration(milliseconds: 200), () {
        emailTF = textfield;
        setState(() {});
      });
    } else {
      if (emailTxtController.text.isNotEmpty) {
        btnText = "Thanks for Subscribing";
      } else {
        btnText = "Subscribe";
      }
      emailTxtController.clear();

      setState(() {});
      emailTF = const SizedBox();
    }
    setState(() {
      isSubscribing = !isSubscribing;
      emailTxtController.clear();
    });
  }

  Padding getEmailTextField() {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
            width: 200,
            child: TextField(
              controller: emailTxtController,
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.teal,
                  hintText: "Enter your Email",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            )));
  }
}
