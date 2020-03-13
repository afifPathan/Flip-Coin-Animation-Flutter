import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StaggeredAnimation extends StatelessWidget {
  StaggeredAnimation({Key key, this.controller})
      : flip = Tween(begin: 0.0, end: pi * 4).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.4, curve: Curves.easeInOutQuint))),
        size = Tween(begin: 120.0, end: 250.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.4, curve: Curves.elasticInOut))),

        super(key: key);

  final Animation<double> flip;
  final Animation<double> size;

  final AnimationController controller;
  bool odd = false;
  String text = "";
  Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    checkHeadTail();

    return Stack(children: [
      Image.asset(
        "assets/images/blur.jpg",
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      Container(
        color: Colors.grey.withOpacity(0.2),
        height: double.infinity,
        width: double.infinity,
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 200.0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.rotationX(flip.value),
              child: Container(
                  height: controller.value < 0.5 ? size.value : 120.0,
                  width: controller.value < 0.5 ? size.value : 120.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: ExactAssetImage(
                        odd ? "assets/images/tell.png" : "assets/images/head.png",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  )),
            ),
          )),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 100.0),
            color: color,
            width: double.infinity,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36.0, color: Colors.white),
            )),
      ),
    ]);
  }

  checkHeadTail() {
    var newString = controller.value.toString().split(".");
    String value = newString[1];
    int number = int.parse(value);
    if (number.isEven) {
      odd = !odd;
    }

    if (controller.isCompleted) {
      text = odd ? "Tail" : "Head";
      color = Colors.grey.withOpacity(0.5);
    } else {
      text = "";
      color = Colors.transparent;
    }
  }
}
