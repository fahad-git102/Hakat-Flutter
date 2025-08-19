
import 'package:flutter/material.dart';
import 'dart:ui';

class SubscriptionDialog extends StatelessWidget {
  const SubscriptionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2A3A52).withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),

              ShaderMask(
                shaderCallback: (bounds) =>
                    LinearGradient(
                      colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Text(
                  'This step requires a\nfull access subscription.',
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(
                    fontSize: 26,
                    fontFamily: "Garamond_Italic",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.7,
                    height: 1.1
                  ).copyWith(
                    color: Colors.white,
                  ), // Color must be set, but it will be masked
                ),
              ),
              // Title text
              const SizedBox(height: 16),
              Text(
                'Subscribe to continue your journey.',
                textAlign: TextAlign.center,
                style:
                TextStyle(
                    fontSize: 20,
                    fontFamily: "Garamond",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.7,
                    height: 1.1
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
              ),
              // Subtitle
              const SizedBox(height: 32),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 242,
                  height: 42,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/gold_effect.jpg'),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 240,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A4A62),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFD4AF37),
                          width: 1.5,
                        ),
                      ),
                      child:   Center(
                        child: Text(
                          "SUBSCRIBE",
                          style:
                          TextStyle(
                            fontSize: 18,
                            fontFamily: "Sanford",
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            color: Colors.white,
                          ), // Color must be set, but it will be masked
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Subscribe button
              const SizedBox(height: 20),
              Text(
                'USD \$5.99/month, USD \$49.99/year',
                textAlign: TextAlign.center,
                style:
                TextStyle(
                    fontSize: 14,
                    fontFamily: "Garamond",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.7,
                    height: 1.1
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
              ),
              // Pricing text
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}