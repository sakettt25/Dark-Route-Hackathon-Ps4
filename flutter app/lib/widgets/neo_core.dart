import 'dart:math';
import 'package:flutter/material.dart';

class NeoCore extends StatefulWidget {
  const NeoCore({super.key});

  @override
  State<NeoCore> createState() => _NeoCoreState();
}

class _NeoCoreState extends State<NeoCore>
    with TickerProviderStateMixin {
  late AnimationController slow;
  late AnimationController fast;

  @override
  void initState() {
    super.initState();

    slow = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();

    fast = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    slow.dispose();
    fast.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _ring(slow, 260, 10, const Color(0xFF38BDF8)),
              _ring(fast, 220, 6, const Color(0xFF0EA5E9)),
              _ring(slow, 180, 4, const Color(0xFF0284C7)),
              _core(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ring(AnimationController c, double size, double stroke, Color color) {
    return AnimatedBuilder(
      animation: c,
      builder: (_, __) => Transform.rotate(
        angle: c.value * 2 * pi,
        child: CustomPaint(
          size: Size(size, size),
          painter: _RingPainter(stroke, color),
        ),
      ),
    );
  }

  Widget _core() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF38BDF8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF38BDF8).withOpacity(0.8),
            blurRadius: 30,
          )
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double stroke;
  final Color color;

  _RingPainter(this.stroke, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..shader = SweepGradient(
        colors: [
          color.withOpacity(0.1),
          color,
          color.withOpacity(0.1),
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
