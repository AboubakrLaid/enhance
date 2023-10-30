import 'package:flutter/material.dart';
import 'dart:math' as mt;

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: 0, max: 2, period: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double angle = mt.pi * _animationController.value;
            return Transform(
              origin: const Offset(0.5, 0.5),
              transform: Matrix4.identity()..setEntry(3, 2, 0.002)..rotateY(angle),
              alignment: Alignment.center,
              child: Container(
                color: const Color.fromRGBO(244, 67, 54, 1),
                height: 200,
                width: 300,
                alignment: Alignment.center,
                child: const Text(
                  "E",
                  style: TextStyle(fontSize: 100),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SliverTransform extends GradientTransform {
  final double y;
  const SliverTransform(this.y);
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.rotationX(y);
  }
}
