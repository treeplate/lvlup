import 'package:flutter/material.dart';
import 'page.dart';
import 'general_cells.dart';

class L2Page extends StatelessWidget {
  L2Page({Key key, @required this.parent, @required this.nextLevel}) : super(key: key);
  
  final LevelWrapperState parent;
  final Widget nextLevel;

  Widget build(BuildContext context) {
    return GridPage(
      mainPage: Text(
          "Welcome to Level 2. From now on, you will see a grid of squares visible below the left and right buttons. Each square has a 'UI' visible at the bottom when you are there. This 'UI' sometimes has things to do. You can also move left and right. Move to the green square to continue"),
      grid: [
        EmptyCell(),
        EmptyCell(),
        L2GoalCell(parent, nextLevel),
      ],
    );
  }
}

class L2GoalCell extends GridCell {
  L2GoalCell(this.parent, this.nextLevel);
  final LevelWrapperState parent;
  final Widget nextLevel;

  void paint(Canvas canvas, Size size, Offset offset, bool char) {
    canvas.drawRect(offset & size, Paint()..color = Colors.green);
    if (char)
      canvas.drawCircle(offset + Offset((size / 2).width, (size / 2).height),
          size.width / 2, Paint()..color = Colors.yellow);
  }

  Widget ui(GridPageState _) => Column(
        children: [
          Text("Here is the button to press. Go ahead and press it"),
          TextButton(
            child: Text("Level Up"),
            onPressed: () {
              parent.newLevel(nextLevel);
            },
          )
        ],
      );
}