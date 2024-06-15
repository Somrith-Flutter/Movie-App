import 'package:flutter/material.dart';

class DotIndicatorWidget extends StatefulWidget {
  final int currentPage;
  final int itemCount;

  const DotIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.itemCount,
  });

  @override
  State<DotIndicatorWidget> createState() => _DotIndicatorWidgetState();
}

class _DotIndicatorWidgetState extends State<DotIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.itemCount, (index) {
        return Dot(
          isActive: widget.currentPage == index,
        );
      }),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;

  const Dot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: isActive ? Colors.red : Colors.white.withOpacity(0.4),
      ),
      child: isActive
          ? Center(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(
                    parent: const AlwaysStoppedAnimation<double>(1), curve: Curves.easeInOut)),
              ),
            )
          : null,
    );
  }
}
