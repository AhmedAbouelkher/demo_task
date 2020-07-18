import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

class CustomDrawer extends AnimatedWidget {
  final VoidCallback onTap;
  const CustomDrawer({this.onTap, Key key, Animation controller})
      : super(key: key, listenable: controller);

  Animation<double> get animationValue => listenable;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SwipeGestureRecognizer(
      onSwipeLeft: onTap,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Opacity(
              opacity: animationValue.value,
              child: Visibility(
                visible: animationValue.value > 0,
                // visible: true,
                child: BlurryContainer(
                  height: height,
                  width: width,
                  bgColor: Color(0xff11243D),
                  child: Container(),
                  blur: animationValue.value * 4,
                  // blur: 4,
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Transform.translate(
                offset: Offset(
                    (animationValue.value - 1).abs() * (-width * 0.60), 0),
                child: Container(
                  height: height * 0.89,
                  width: width * 0.60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text("Drawer contant goes here."),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
