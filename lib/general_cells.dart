import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'page.dart';

class FactoryKeyCell extends GridCell {
  FactoryKeyCell();

  void paint(Canvas canvas, Size size, Offset offset, bool char) {
    canvas.drawRect(offset & size, Paint()..color = Colors.yellowAccent);
    if (char)
      canvas.drawCircle(offset + Offset((size / 2).width, (size / 2).height),
          size.width / 2, Paint()..color = Colors.yellow);
  }

  Widget ui(GridPageState gridPage) => gridPage.keyFragments >= 2
      ? Column(
          children: [
            Text("Here you get the key. Get it, then go to the green square"),
            TextButton(
              child: Text("Get Key"),
              onPressed: () {
                gridPage.getFactoryKey();
              },
            ),
          ],
        )
      : gridPage.hasKey
          ? Text("Go to the green square")
          : Text(
              "Get ${2 - gridPage.keyFragments} key fragments at the yellow half-square, then get back here");
}

class EmptyCell extends GridCell {
  void paint(Canvas canvas, Size size, Offset offset, bool char) {
    canvas.drawRect(offset & size, Paint()..color = Colors.grey);
    if (char)
      canvas.drawCircle(offset + Offset((size / 2).width, (size / 2).height),
          size.width / 2, Paint()..color = Colors.yellow);
  }

  Widget ui(GridPageState _) => Text("Nothing to see here");
}