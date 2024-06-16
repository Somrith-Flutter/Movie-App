import 'dart:math';
import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  late Animation<Color?> _colorAnimation3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation1 = TweenSequence<Color?>([
      TweenSequenceItem(tween: ColorTween(begin: Colors.black, end: Colors.redAccent.withOpacity(0.7)), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.redAccent.withOpacity(0.7), end: Colors.black), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.black, end: Colors.blueGrey), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation2 = TweenSequence<Color?>([
      TweenSequenceItem(tween: ColorTween(begin: Colors.blueGrey, end: Colors.redAccent.withOpacity(0.7)), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.redAccent.withOpacity(0.7), end: Colors.black), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.black, end: Colors.blueGrey), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation3 = TweenSequence<Color?>([
      TweenSequenceItem(tween: ColorTween(begin: Colors.black, end: Colors.blueGrey), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.blueGrey, end: Colors.redAccent.withOpacity(0.7)), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.redAccent.withOpacity(0.7), end: Colors.black), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward().whenComplete(() {
      AppRoute().pushReplacement(context, const BottomNavigation());
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _colorAnimation1.value!,
                  _colorAnimation2.value!,
                  _colorAnimation3.value!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Transform.scale(
                scale: 1 + 0.1 * sin(_animationController.value * pi * 2),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    AssetPath.appLogo,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
