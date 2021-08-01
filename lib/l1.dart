import 'package:flutter/material.dart';
import 'page.dart';

class L1Page extends StatelessWidget {
  L1Page({
    Key key,
    @required this.parent,
    @required this.nextLevel,
  }) : super(key: key);

  final LevelWrapperState parent;
  final Widget nextLevel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Welcome to Level 1. The goal of this game is to press the button below. Go on, press it."),
        TextButton(
          child: Text("Level Up"),
          onPressed: () {
            parent.newLevel(nextLevel);
          },
        )
      ],
    );
  }
}
