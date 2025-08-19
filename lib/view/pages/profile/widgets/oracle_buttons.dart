import 'package:flutter/material.dart';

class HakatOracleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;

  const HakatOracleButton({
    Key? key,
    required this.text,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isFirst ? 16 : 0),
            topRight: Radius.circular(isFirst ? 16 : 0),
            bottomLeft: Radius.circular(isLast ? 16 : 0),
            bottomRight: Radius.circular(isLast ? 16 : 0),
          ),


        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Garamond",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFD4AF37), // Golden color
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HakatOracleButtons extends StatelessWidget {
  const HakatOracleButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Color(0xFF201C27).withOpacity(0.8),Color(0xFF282433).withOpacity(0.7)]),// Dark background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HakatOracleButton(
            text: 'About The Hakat Oracle',
            isFirst: true,
            isLast:false,
            onTap: () {
              print('About The Hakat Oracle tapped');
              // Handle navigation to about page
            },
          ),
          HakatOracleButton(
            text: 'Contact The Hakat Oracle',
            isFirst: false,
            isLast: true,
            onTap: () {
              print('About The Hakat Oracle tapped');
              // Handle navigation to about page
            },
          ),

        ],
      ),
    );
  }
}

// Alternative single button widget for individual use
class SingleHakatOracleButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const SingleHakatOracleButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  State<SingleHakatOracleButton> createState() => _SingleHakatOracleButtonState();
}

class _SingleHakatOracleButtonState extends State<SingleHakatOracleButton>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
        _animationController.reverse();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        setState(() => isPressed = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 320,
              height: 56,
              decoration: BoxDecoration(
                color: isPressed
                    ? const Color(0xFF3D3D3D)
                    : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: isPressed ? 5 : 8,
                    offset: Offset(0, isPressed ? 1 : 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: isPressed
                          ? const Color(0xFFE6C558)
                          : const Color(0xFFD4AF37),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Example usage
class HakatOracleExample extends StatelessWidget {
  const HakatOracleExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Grouped buttons (matches your image exactly)
            const HakatOracleButtons(),

            const SizedBox(height: 40),

            // Individual buttons with press animation
            SingleHakatOracleButton(
              text: 'About The Hakat Oracle',
              onTap: () {
                print('About tapped');
              },
            ),

            const SizedBox(height: 16),

            SingleHakatOracleButton(
              text: 'Contact The Hakat Oracle',
              onTap: () {
                print('Contact tapped');
              },
            ),
          ],
        ),
      ),
    );
  }
}