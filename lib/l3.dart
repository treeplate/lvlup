import 'package:flutter/material.dart';
import 'general_cells.dart';
import 'page.dart';

class L3Page extends StatelessWidget {
  L3Page({Key key, @required this.parent, @required this.nextLevel})
      : super(key: key);

  final LevelWrapperState parent;
  final Widget nextLevel;

  Widget build(BuildContext context) {
    return GridPage(
      mainPage: Text(
          "Welcome to Level 3. To continue, you need to go to the yellow square."),
      grid: [
        EmptyCell(),
        KeyCell(),
        L3GoalCell(parent, nextLevel),
      ],
    );
  }
}

class L3GoalCell extends GridCell {
  L3GoalCell(this.parent, this.nextLevel);
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

class KeyCell extends GridCell {
  KeyCell();

  void paint(Canvas canvas, Size size, Offset offset, bool char) {
    canvas.drawRect(offset & size, Paint()..color = Colors.yellowAccent);
    if (char)
      canvas.drawCircle(offset + Offset((size / 2).width, (size / 2).height),
          size.width / 2, Paint()..color = Colors.yellow);
  }

  Widget ui(GridPageState gridPage) => Column(
        children: [
          Text("Here you get the key. Get it, then go to the green square"),
          TextButton(
            child: Text("Get Key"),
            onPressed: () {
              gridPage.getKey();
            },
          ),
        ],
      );
}
