import 'package:flutter/material.dart';
import 'l1.dart';
import 'l2.dart';
import 'l3.dart';
import 'l4.dart';
import 'page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Levelup',
    home: LevelWrapper(
      initialPage: (LevelWrapperState parent) => L1Page(
        parent: parent,
        nextLevel: L2Page(
          parent: parent,
          nextLevel: L3Page(
            parent: parent,
            nextLevel: L4Page(
              parent: parent,
              nextLevel: Text("The end (for now)"),
            ),
          ),
        ),
      ),
    ),
  ));
}
