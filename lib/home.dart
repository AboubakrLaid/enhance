import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) =>  LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                 transform: SliverTransform(_animationController.value),
                colors: const [
                  Colors.red,
                  Colors.white,
                  Colors.red,
                ],
              ).createShader(bounds),
              child: child,
            );
          },
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ],
          ),
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
    return Matrix4.translationValues(0,- bounds.height* y, 0);
  }
}
