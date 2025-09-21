import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/onboarding/first_step_page.dart';
import '../pages/root_page.dart';
import '../pages/spread/spread_card.dart';
import '../pages/subscription/subscription_page.dart';

class SubscriptionDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFF385475), width: 1),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF385475),
              blurRadius: 5
            )
          ],
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF385475),
              Color(0xFF000000),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            ShaderMask(
              shaderCallback: (bounds) =>
                  LinearGradient(
                    colors: [
                      Color(0xFFEBCD8C),
                      Color(0xFFA47E4D),
                    ],
                  ).createShader(
                    Rect.fromLTWH(
                      0,
                      0,
                      bounds.width,
                      bounds.height,
                    ),
                  ),
              child: Text(
                "This step requires a\nfull access subscription.",
                textAlign: TextAlign.center,
                style:
                TextStyle(
                  fontSize: 24,
                  fontFamily:
                  "Garamond_Italic",
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Subscribe to continue your journey.",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 16,
                fontFamily: "Literata",
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
            const SizedBox(height: 24),

            InkWell(
              onTap: () => Get.to(() => SubscriptionsPage()),
              child: Container(
                height: height * 0.075,
                width: width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/gold_effect.jpg'),
                  ),
                ),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(2),
                    height: height * 0.075,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF49415D), Color(0xFF786F8E)],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Center(
                      child: Text(
                        "SUBSCRIBE",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Sanford",
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            InkWell(
              onTap: () => Get.to(() => FadeInScreen(child: BottomNavScreen())),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06,
                  vertical: height * 0.018,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2E3B50),
                      Color(0xFF1A202E),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Sanford",
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            const Divider(color: Colors.white24),
            SizedBox(height: height * 0.025),
            InkWell(
              onTap: () => Get.to(
                    () => FadeInScreen(
                  child: TheWhisperPage(showTextMain: false),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/gift_subscription.png',
                    width: width * 0.15,
                    height: height * 0.05,
                  ),
                  SizedBox(width: width * 0.03),
                  Text(
                    "PULL A CARD",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Garamond",
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }

}