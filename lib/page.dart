import 'package:flutter/material.dart';

typedef LevelPageConstructor = Widget Function(LevelWrapperState parent);

class LevelWrapper extends StatefulWidget {
  LevelWrapper({Key key, @required this.initialPage}) : super(key: key);

  final LevelPageConstructor initialPage;
 
  @override
  LevelWrapperState createState() => LevelWrapperState();
}

class LevelWrapperState extends State<LevelWrapper> {
  Widget page;

  void newLevel(Widget level) {
    setState(() {
      page = level;
    });
  }

  void initState() {
    super.initState();
    page = widget.initialPage(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: page,
      ),
    );
  }
}

class GridPage extends StatefulWidget {
  GridPage({@required this.mainPage, @required this.grid});

  final Widget mainPage;
  final List<GridCell> grid;

  @override
  GridPageState createState() => GridPageState();
}

class GridPageState extends State<GridPage> {
  Widget get ui => widget.grid[x].ui(this);
  int x = 0;
  bool hasKey = false;
  int keyFragments = 0;

  void getKey() {
    setState(() {
      hasKey = true;
    });
  }

  void getFactoryKey() {
    setState(() {
      keyFragments -= 2;
      hasKey = true;
    });
  }

  void getKeyFragment() {
    setState(() {
      keyFragments++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(500.0, 0, 500.0, 0),
          child: widget.mainPage,
        ),
        hasKey ? Text("You have the key") : Container(),
        keyFragments == 0
            ? Container()
            : Text("You have $keyFragments key fragments"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("Left"),
              onPressed: () {
                setState(() {
                  if (x > 0) x--;
                });
              },
            ),
            TextButton(
              child: Text("Right"),
              onPressed: () {
                setState(() {
                  if (x < widget.grid.length - 1) x++;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is the grid: "),
            GridPainter(widget.grid, x),
          ],
        ),
        ui,
      ],
    );
  }
}

class GridPainter extends StatelessWidget {
  GridPainter(this.grid, this.position);
  final List<GridCell> grid;
  final int position;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridCustomPainter(grid, position),
    );
  }
}

class GridCustomPainter extends CustomPainter {
  GridCustomPainter(this.grid, this.position);
  final List<GridCell> grid;
  final int position;

  void paint(Canvas canvas, Size size) {
    int offset = 0;
    for (GridCell cell in grid) {
      cell.paint(canvas, Size(40, 40), Offset(offset.toDouble(), 0),
          offset / 40 == position.toDouble());
      offset += 40;
    }
  }

  bool shouldRepaint(GridCustomPainter old) => true;
}

abstract class GridCell {
  void paint(Canvas canvas, Size size, Offset offset, bool character);
  Widget ui(GridPageState gridPage);
}