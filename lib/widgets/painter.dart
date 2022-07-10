import 'package:flutter/material.dart';


class Signature extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final CustomPainter? backgroundPainter;
  final Function? onSign;

  const Signature({
    this.color = Colors.black,
    this.strokeWidth = 5.0,
    this.backgroundPainter,
    this.onSign,
    Key? key,
  }) : super(key: key);

  @override
  SignatureState createState() => SignatureState();

  static SignatureState? of(BuildContext context) {
    return context.findAncestorStateOfType<SignatureState>();
  }
}

class _SignaturePainter extends CustomPainter {
  final double strokeWidth;
  final List<Offset?> points;
  final Color strokeColor;
  late Paint _linePaint;

  _SignaturePainter(
      {required this.points,
      required this.strokeColor,
      required this.strokeWidth}) {
    _linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, _linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter other) => other.points != points;
}

class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset?>[];
  
  _SignaturePainter? _painter;

  SignatureState();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    _painter = _SignaturePainter(
        points: _points,
        strokeColor: widget.color,
        strokeWidth: widget.strokeWidth);
    return ClipRect(
      child: CustomPaint(
        painter: widget.backgroundPainter,
        foregroundPainter: _painter,
        child: GestureDetector(
          onPanUpdate: _onDragUpdate,
          onPanEnd: _onDragEnd,
        ),
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    RenderBox referenceBox = context.findRenderObject() as RenderBox;
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

    setState(() {
      _points = List.from(_points)..add(localPosition);
      if (widget.onSign != null) {
        widget.onSign!();
      }
    });
  }

  void _onDragEnd(DragEndDetails details) => _points.add(null);

  bool get hasPoints => _points.isNotEmpty;

  List<Offset?> get points => _points;

  afterFirstLayout(BuildContext context) {}
}
