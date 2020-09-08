import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabBarCupertinoWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const TabBarCupertinoWidget({
    @required this.index,
    @required this.onChangedTab,
    Key key,
  }) : super(key: key);

  @override
  _TabBarCupertinoWidgetState createState() => _TabBarCupertinoWidgetState();
}

class _TabBarCupertinoWidgetState extends State<TabBarCupertinoWidget> {
  ValueListenable<ScaffoldGeometry> geometryListenable;

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('Search'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.mail_outline),
      title: Text('Emails'),
    ),
    BottomNavigationBarItem(
      icon: Container(),
      title: Container(),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text('Profile'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('Settings'),
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return buildNotchedCupertino(
      child: CupertinoTabBar(
        items: items,
        currentIndex: widget.index >= 2 ? widget.index + 1 : widget.index,
        inactiveColor: Colors.black,
        onTap: (index) {
          final newIndex = getIndex(index);

          if (newIndex == null) {
            /// Ignore index == 2
            return;
          } else {
            widget.onChangedTab(newIndex);
          }
        },
      ),
    );
  }

  int getIndex(int index) {
    if (index == 2) return null;

    final newIndex = index > 2 ? index - 1 : index;
    return newIndex;
  }

  Widget buildNotchedCupertino({@required Widget child}) {
    final colorCupertinoBorder = CupertinoDynamicColor.withBrightness(
      color: Color(0x4C000000),
      darkColor: Color(0x29000000),
    );

    return CustomPaint(
      painter: _BottomAppBarPainter(
        color: colorCupertinoBorder,
        shape: CircularNotchedRectangle(),
        geometry: geometryListenable,
        notchMargin: 4,
      ),
      child: PhysicalShape(
        clipper: _BottomAppBarClipper(
          shape: CircularNotchedRectangle(),
          geometry: geometryListenable,
          notchMargin: 4,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: Material(color: Colors.transparent, child: child),
      ),
    );
  }
}

class _BottomAppBarPainter extends CustomPainter {
  const _BottomAppBarPainter({
    @required this.color,
    @required this.geometry,
    @required this.shape,
    @required this.notchMargin,
  })  : assert(geometry != null),
        assert(shape != null),
        assert(notchMargin != null);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop * -1.0,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;

    final path =
        shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    @required this.geometry,
    @required this.shape,
    @required this.notchMargin,
  })  : assert(geometry != null),
        assert(shape != null),
        assert(notchMargin != null),
        super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop * -1.0,
    );
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}
