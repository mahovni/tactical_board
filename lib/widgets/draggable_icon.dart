import 'package:flutter/material.dart';

class DraggableIcon extends StatefulWidget {
  const DraggableIcon({required this.child, super.key});

  final Widget child;

  @override
  DraggableIconState createState() => DraggableIconState();
}

class DraggableIconState extends State<DraggableIcon>
     {
  Alignment _dragAlignment = Alignment.bottomRight;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {},
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {},
      child: Align(
        alignment: _dragAlignment,
        child: widget.child,
      ),
    );
  }
}