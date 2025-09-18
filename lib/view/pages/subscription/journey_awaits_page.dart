import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/view/pages/subscription/subscription_page.dart';

import '../../../constants/icons.dart';
import '../../global/custom_appbar.dart';
import '../../global/spacing.dart';
import '../onboarding/first_step_page.dart';
import '../root_page.dart';
import '../spread/spread_card.dart';
import '../spread/spread_page.dart';

class JourneyAwaitspage extends StatefulWidget {
  const JourneyAwaitspage({super.key});

  @override
  State<StatefulWidget> createState() => _JourneyAwaitsState();
}

class _JourneyAwaitsState extends State<JourneyAwaitspage> {
  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppIcon.smokey_bg, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                const AddHeight(4),
                CustomAppBar(text: "MY ACCOUNT"),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: height * 0.08,
                        left: width * 0.04,
                        right: width * 0.04,
                        child: _buildWidget(width, height),
                      ),
                      Positioned(
                        top: height * 0.015,
                        child: Image.asset(
                          "assets/logo.png",
                          width: width * 0.25,
                          height: height * 0.12,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Gradient text helper
  Widget _gradientText(String text, TextStyle style,
      {TextAlign align = TextAlign.center}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, textAlign: align, style: style.copyWith(color: Colors.white)),
    );
  }

  Widget _buildWidget(double width, double height) {
    // scale factor for fonts
    double textScale = width / 390; // baseline iPhone 12 width

    return Container(
      width: width,
      padding: EdgeInsets.only(top: height * 0.07),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF201C27).withOpacity(0.8),
            const Color(0xFF282433).withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _gradientText(
              "Your Journey Awaits",
              TextStyle(
                fontSize: 27 * textScale,
                fontFamily: "Garamond_Italic",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: height * 0.01),
            _gradientText(
              "UNLOCK FULL ACCESS",
              TextStyle(
                fontSize: 13 * textScale,
                fontFamily: "Literata",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: height * 0.045),
            Text(
              "Subscribe to unlock all spreads, Chaos Mode, journaling, and the power to save your readings.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19 * textScale,
                fontFamily: "Garamond",
                letterSpacing: 1.2,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: height * 0.03),
            Text(
              "Your 1-card pull\nremains free forever.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20 * textScale,
                fontFamily: "Garamond_Italic",
                letterSpacing: 1.2,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: height * 0.04),

            /// 🔹 Subscribe Button
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
                          fontSize: 20 * textScale,
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

            /// 🔹 Guest Button
            InkWell(
              onTap: () => Get.to(() => const FirstStepPage()),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06,
                  vertical: height * 0.018,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(80),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                    fontSize: 16 * textScale,
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

            /// 🔹 Pull a Card
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
                      fontSize: 21 * textScale,
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
