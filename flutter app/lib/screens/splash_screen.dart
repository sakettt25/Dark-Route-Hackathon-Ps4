import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'roll_input_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController up;
  late AnimationController down;
  late AnimationController rotate;
  late AnimationController textPop;

  @override
  void initState() {
    super.initState();

    up = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    down = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    rotate = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    textPop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const RollInputScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    up.dispose();
    down.dispose();
    rotate.dispose();
    textPop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ANIMATION AREA
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _column(up, true),
                  _column(down, false),
                  _centerCore(),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// APP NAME
            AnimatedBuilder(
              animation: textPop,
              builder: (_, __) {
                final scale =
                    Curves.easeOutBack.transform(textPop.value);
                return Transform.scale(
                  scale: scale,
                  child: const Text(
                    "recgroot",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 5,
                      color: Color(0xFF7DD3FC),
                      shadows: [
                        Shadow(
                          color: Color(0xFF38BDF8),
                          blurRadius: 25,
                        ),
                        Shadow(
                          color: Color(0xFF0EA5E9),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _column(AnimationController controller, bool hearts) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final offset =
            lerpDouble(0, hearts ? -120 : 120, controller.value)!;
        return Transform.translate(
          offset: Offset(hearts ? -60 : 60, offset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (_) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: hearts ? _heart() : _robot(),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _centerCore() {
    return AnimatedBuilder(
      animation: rotate,
      builder: (_, __) {
        return Transform.rotate(
          angle: rotate.value * 2 * pi,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.6),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(
              Icons.close,
              color: Colors.black,
              size: 32,
            ),
          ),
        );
      },
    );
  }

  Widget _heart() {
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        width: 24,
        height: 24,
        color: Colors.red,
        child: Stack(
          children: [
            Positioned(left: -12, child: _circle()),
            Positioned(top: -12, child: _circle()),
          ],
        ),
      ),
    );
  }

  Widget _circle() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _robot() {
    return Container(
      width: 42,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _Eye(),
          _Eye(),
        ],
      ),
    );
  }
}

/* ---------------- EYES ---------------- */

class _Eye extends StatefulWidget {
  const _Eye();

  @override
  State<_Eye> createState() => _EyeState();
}

class _EyeState extends State<_Eye> {
  bool blink = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 700), (_) {
      setState(() => blink = !blink);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: 6,
      height: blink ? 2 : 6,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
