import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:why/screens/home_shell.dart';

class RollInputScreen extends StatefulWidget {
  const RollInputScreen({super.key});

  @override
  State<RollInputScreen> createState() => _RollInputScreenState();
}

class _RollInputScreenState extends State<RollInputScreen>
    with TickerProviderStateMixin {
  final controller = TextEditingController();

  late AnimationController glowAnim;
  late AnimationController ballAnim;

  bool showLoadingText = false;
  bool showBallLoader = false;

  @override
  void initState() {
    super.initState();

    glowAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.7,
      upperBound: 1,
    )..repeat(reverse: true);

    ballAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    glowAnim.dispose();
    ballAnim.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> go() async {
    if (controller.text.trim().isEmpty) return;

    await Future.delayed(const Duration(seconds: 1));
    setState(() => showLoadingText = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      showLoadingText = false;
      showBallLoader = true;
    });

    ballAnim.forward(from: 0);

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeShell(rollNo: controller.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF020617),
              Color(0xFF020617),
              Color(0xFF0F172A),
              Color(0xFF020617),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: showBallLoader
                ? BallLoader(animation: ballAnim)
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        top: 100, // recgroot LOADER (fixed)
                        child: const GeneratingLoader(),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        top: 450 - keyboard * 0.6, // 🔥 moves with keyboard
                        child: terminalInput(),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        top: 610 - keyboard * 0.6, // 🔥 moves with keyboard
                        child: showLoadingText
                            ? const LoadingText()
                            : spaceButton(),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget terminalInput() {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.25),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF334155), Color(0xFF020617)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: const Row(
              children: [
                Dot(Colors.red),
                Dot(Colors.yellow),
                Dot(Colors.green),
                SizedBox(width: 8),
                Text(
                  "user@recgroot:~",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Text("\$", style: TextStyle(color: Colors.greenAccent)),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "//username",
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget terminalInput2() {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.25),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF334155), Color(0xFF020617)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: const Row(
              children: [
                Dot(Colors.red),
                Dot(Colors.yellow),
                Dot(Colors.green),
                SizedBox(width: 8),
                Text(
                  "user@recgroot:~",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Text("\$", style: TextStyle(color: Colors.greenAccent)),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "//password",
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget spaceButton() {
    return GestureDetector(
      onTap: go,
      child: AnimatedBuilder(
        animation: glowAnim,
        builder: (_, __) => Transform.scale(
          scale: glowAnim.value,
          child: Container(
            width: 210,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3B82F6),
                  Color(0xFF06B6D4),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.6),
                  blurRadius: 25,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              "ENTER",
              style: TextStyle(
                letterSpacing: 5,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------- recgroot LOADER ---------------- */

class GeneratingLoader extends StatefulWidget {
  const GeneratingLoader({super.key});

  @override
  State<GeneratingLoader> createState() => _GeneratingLoaderState();
}

class _GeneratingLoaderState extends State<GeneratingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController rotate;

  @override
  void initState() {
    super.initState();
    rotate = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    rotate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const text = "recgroot";

    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: rotate,
            builder: (_, __) {
              return Transform.rotate(
                angle: rotate.value * 2 * pi,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 20,
                        spreadRadius: -10,
                      ),
                      BoxShadow(
                        color: Color(0xFFAD5FFF),
                        blurRadius: 40,
                        spreadRadius: -20,
                      ),
                      BoxShadow(
                        color: Color(0xFF471EEC),
                        blurRadius: 60,
                        spreadRadius: -30,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(text.length, (i) {
              return AnimatedBuilder(
                animation: rotate,
                builder: (_, __) {
                  final t = (rotate.value + i * 0.1) % 1;
                  return Transform.scale(
                    scale: t < 0.2 ? 1.15 : 1,
                    child: Opacity(
                      opacity: t < 0.2 ? 1 : 0.4,
                      child: Text(
                        text[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

/* ---------------- LOADERS & UTILS ---------------- */

class LoadingText extends StatelessWidget {
  const LoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Loading",
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        letterSpacing: 2,
      ),
    );
  }
}

class BallLoader extends StatelessWidget {
  final Animation<double> animation;
  const BallLoader({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        final t = animation.value;
        return Transform.rotate(
          angle: lerpDouble(-0.26, 0.26, t)!,
          child: Container(
            width: 200,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDAAF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: lerpDouble(160, -20, t),
                  bottom: 25,
                  child: Transform.rotate(
                    angle: t * 2 * pi,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Align(
                        alignment: Alignment(0.4, 0.4),
                        child: CircleAvatar(
                          radius: 2.5,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;
  const Dot(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
