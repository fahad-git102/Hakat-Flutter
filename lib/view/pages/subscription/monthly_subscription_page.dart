import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/icons.dart';
import '../../global/custom_appbar.dart';
import '../../global/spacing.dart';

class MonthlySubscriberScreen extends StatefulWidget {
  const MonthlySubscriberScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MonthlySubscriberState();
}

class _MonthlySubscriberState extends State<MonthlySubscriberScreen> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                "You're an monthly subscriber!",
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: "Garamond_Italic",
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ).copyWith(color: Colors.white),
              ),
            ),
          ),
          AddHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                "Enjoying the app? Upgrade to the Annual Plan and save 30%",
                style:
                TextStyle(
                  fontSize: 20,
                  fontFamily: "Garamond",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w400,
                ).copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center
            ),
          ),
          AddHeight(15),
          InkWell(
            onTap: (){},
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
                      "UPGRADE",
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
          Divider(color: Colors.black,),
          AddHeight(20),
          ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(
                  colors: [Color(0xFFC2BAD5), Color(0xFF786F8E)],
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            child: Text(
              "WANT TO OPEN THE PORTAL \n FOR SOMEONE ELSE?",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 14,
                fontFamily: "Literata",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ),
            ),
          ),
          AddHeight(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Image.asset('assets/gift_subscription.png',width: 55,height: 40,),
              ),
              AddWidth(10),
              Text(
                "Gift a Subscription",
                style:
                TextStyle(
                  fontSize: 18,
                  fontFamily: "Garamond",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w400,
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
              ),
            ],
          ),
          AddHeight(20),
          Divider(color: Colors.black,),
          AddHeight(20),
          Text(
              "Rate the Magic",
              style:
              TextStyle(
                fontSize: 21,
                fontFamily: "Garamond_Italic",
                letterSpacing: 1.2,
                fontWeight: FontWeight.w400,
              ).copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center
          ),
          AddHeight(15),
          ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(
                  colors: [Color(0xFFC2BAD5), Color(0xFF786F8E)],
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            child: Text(
              "YOUR FEEDBACK HELPS THE\nORACLE REACH MORE SEEKERS",
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
          AddHeight(30),
        ],
      ),
    );
  }
}
