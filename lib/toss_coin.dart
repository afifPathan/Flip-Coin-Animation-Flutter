import 'package:cointossanimation/staggered_animation.dart';
import 'package:flutter/material.dart';

class TossCoin extends StatefulWidget {
  @override
  _TossCoinState createState() => _TossCoinState();
}

class _TossCoinState extends State<TossCoin> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..addListener(() {
            if (controller.value >= 0.4 && controller.value < 0.5) {
              reverseAndElevateDown();
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> reverseAndElevateDown() async {
    await controller.animateBack(0.0);
    await controller.forward(from: 0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        tooltip: "Press Here",
        onPressed: () {
          controller.reset();
          controller.forward();
        },
      ),
      body: StaggeredAnimation(controller: controller),
    );
  }
}
