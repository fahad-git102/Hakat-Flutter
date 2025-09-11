import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/subscription/subscription_page.dart';

import '../../../constants/icons.dart';
import '../../global/custom_appbar.dart';
import '../../global/spacing.dart';
import '../onboarding/first_step_page.dart';
import '../spread/spread_card.dart';
import '../spread/spread_page.dart';

class JourneyAwaitspage extends StatefulWidget {
  const JourneyAwaitspage({super.key});

  @override
  State<StatefulWidget> createState() => _JorneyAwaitsState();
}

class _JorneyAwaitsState extends State<JourneyAwaitspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: Get.width,
              height: Get.height,
              child: Image.asset(AppIcon.smokey_bg, fit: BoxFit.fill),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  AddHeight(4),
                  CustomAppBar(text: "MY ACCOUNT"),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: Get.height / 1.3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 68,
                          left: 15,
                          right: 15,
                          child: _buildWidget(),
                        ),
                        Positioned(
                          top: 15,
                          child: Image.asset(
                            "assets/logo.png",
                            width: 105,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildWidget() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFF201C27).withOpacity(0.8),
            Color(0xFF282433).withOpacity(0.7),
          ],
        ), // Dark background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(
                  colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            child: Text(
              "Your Journey Awaits",
              style:
              TextStyle(
                fontSize: 27,
                fontFamily: "Garamond_Italic",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(
                  colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            child: Text(
              "UNLOCK FULL ACCESS",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 13,
                fontFamily: "Literata",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
          ),
          AddHeight(36),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Subscribe to unlock all spreads, Chaos Mode, journaling, and the power to save your readings.",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 19,
                fontFamily: "Garamond",
                letterSpacing: 1.2,
                fontWeight: FontWeight.w400,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
          ),
          AddHeight(25),
          Text(
            "Your 1-card pull\nremains free forever.",
            textAlign: TextAlign.center,
            style:
            TextStyle(
              fontSize: 20,
              fontFamily: "Garamond_Italic",
              letterSpacing: 1.2,
              fontWeight: FontWeight.w400,
            ).copyWith(
              color: Colors.white,
            ), // Color must be set, but it will be masked
          ),
          AddHeight(28),
          InkWell(
            onTap: (){
              Get.to(()=>SubscriptionsPage());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              height: 60,
              width: 160,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/gold_effect.jpg'),
                ),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    gradient: LinearGradient(colors: [
                      Color(0xFF49415D),
                      Color(0xFF786F8E),
                    ],),

                  ),
                  child:   Center(
                    child: Text(
                      "SUBSCRIBE",
                      style:
                      TextStyle(
                        fontSize: 20,
                        fontFamily: "Sanford",
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                    ),
                  ),
                ),
              ),
            ),
          ),
          AddHeight(20),
          InkWell(
            onTap: (){
              Get.to(()=>FirstStepPage());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(80),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                "Continue as Guest",
                style:
                TextStyle(
                  fontSize: 16,
                  fontFamily: "Sanford",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
              ),
            ),
          ),
          AddHeight(25),
          Divider(color: Colors.black,),
          AddHeight(20),
          InkWell(
            onTap: (){
              Get.to(() => FadeInScreen(child: TheWhisperPage(showTextMain: false,)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Image.asset('assets/gift_subscription.png',width: 55,height: 40,),
                ),
                AddWidth(10),
                Text(
                  "PULL A CARD",
                  style:
                  TextStyle(
                    fontSize: 21,
                    fontFamily: "Garamond",
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ).copyWith(
                    color: Colors.white,
                  ), // Color must be set, but it will be masked
                ),
              ],
            ),
          ),
          AddHeight(30)
        ],
      ),
    );
  }
}
