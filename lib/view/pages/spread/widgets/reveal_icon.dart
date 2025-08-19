import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SwipeUpAnimation extends StatefulWidget {
  const SwipeUpAnimation({super.key});

  @override
  State<SwipeUpAnimation> createState() => _SwipeUpAnimationState();
}

class _SwipeUpAnimationState extends State<SwipeUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Loop the animation

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly below
      end: const Offset(0, -0.2),  // Move slightly above
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/click.svg'
            ),
            const SizedBox(height: 4),
            Text(
              "Reveal your card",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 20,
                fontFamily: "Garamond_Italic",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
          ],
        ),
      ),
    );
  }
}
