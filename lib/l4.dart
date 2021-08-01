import 'package:flutter/material.dart';

import 'general_cells.dart';
import 'page.dart';

class L4Page extends StatelessWidget {
  L4Page({Key key, @required this.parent, @required this.nextLevel})
      : super(key: key);

  final LevelWrapperState parent;
  final Widget nextLevel;

  Widget build(BuildContext context) {
    return GridPage(
      mainPage: Text(
          "Welcome to Level 4. To continue, you need to go to the yellow half-square."),
      grid: [
        EmptyCell(),
        KeyFragmentCell(),
        FactoryKeyCell(),
        L4GoalCell(parent, nextLevel),
      ],
    );
  }
}

class KeyFragmentCell extends GridCell {
  KeyFragmentCell();

  void paint(Canvas canvas, Size size, Offset offset, bool char) {
    canvas.drawRect(offset & Size(size.height, size.width / 2),
        Paint()..color = Colors.yellowAccent);
    if (char)
      canvas.drawCircle(offset + Offset((size / 2).width, (size / 2).height),
          size.width / 2, Paint()..color = Colors.yellow);
  }

  Widget ui(GridPageState gridPage) => Column(
        children: [
          Text(
              "Here you get key fragments. Get two, then go to the yellow square"),
          TextButton(
            child: Text("Get Key Fragment"),
            onPressed: () {
              gridPage.getKeyFragment();
            },
          ),
        ],
      );
}

class L4GoalCell extends GridCell {
  L4GoalCell(this.parent, this.nextLevel);
  final LevelWrapperState parent;
  final Widget nextLevel;

  void paint(Canvas canvas, Size size, Offset offset, bool char) {
    canvas.drawRect(offset & size, Paint()..color = Colors.green);
    if (char)
      canvas.drawCircle(offset + Offset((size / 2).width, (size / 2).height),
          size.width / 2, Paint()..color = Colors.yellow);
  }

  Widget ui(GridPageState gridPage) => gridPage.hasKey
      ? Column(
          children: [
            Text("Here is the button to press. Go ahead and press it"),
            TextButton(
              child: Text("Level Up"),
              onPressed: () {
                parent.newLevel(nextLevel);
              },
            )
          ],
        )
      : Text("Get the key first (the yellow square will help)");
}
