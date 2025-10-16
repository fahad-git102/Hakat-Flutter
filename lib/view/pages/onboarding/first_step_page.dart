import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/controllers/root_controller.dart';
import 'package:hakat/controllers/user_controller.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/circle_of_self.dart';
import 'package:hakat/view/pages/spread/portal_path_page.dart';
import 'package:hakat/view/pages/spread/spiral_of_becoming.dart';
import 'package:hakat/view/pages/spread/spread_page.dart';
import 'package:hakat/view/pages/spread/the_whisper.dart';
import '../../global/spacing.dart';

class FirstStepPage extends StatefulWidget {
  const FirstStepPage({super.key});

  @override
  State<FirstStepPage> createState() => _FirstStepPageState();
}

class _FirstStepPageState extends State<FirstStepPage> {
  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    animateWidgets();
  }

  void animateWidgets() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => showFirst = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => showSecond = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => showThird = true);
  }

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
            top: 120,
            bottom: 70,
            left: 36,
            right: 36,
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      LinearGradient(
                        colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    "Choose your first step",
                    style:
                        TextStyle(
                          fontSize: 24,
                          fontFamily: "Garamond_Italic",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                ),
                AddHeight(40),
                InkWell(
                  onTap: (){
                    Get.to(()=> TheWhisperPage());
                  },
                  child: _buildCard("PULL\n A CARD","assets/images/onboarding/card_one_icon.png","assets/images/onboarding/card_one.png", (){},showFirst),
                ),
                AddHeight(20),
                InkWell(
                    onTap: (){
                      Get.to(()=> BottomNavScreen(initialIndex: 2,));
                    },
                    child: _buildCard("CHOOSE\n A SPREAD","assets/images/onboarding/card_two_icon.png","assets/images/onboarding/card_two.png", (){},showSecond),
                ),
                AddHeight(20),
                InkWell(
                  onTap: (){
                    if(userController.currentUser.value?.isSubscribed==true){
                      final screens = [
                        TheWhisperPage(),
                        ThePortalPathPage(),
                        SpiralOfBecomingPage(),
                        CircleOfSelfPage(),
                      ];
                      final randomIndex = Random().nextInt(screens.length);
                      Get.to(() => screens[randomIndex]);
                    }else{
                      Get.to(()=> TheWhisperPage());
                    }
                  },
                  child: _buildCard("LET\nINTUITION\nCHOOSE","assets/images/onboarding/card_three_icon.png","assets/images/onboarding/card_three.png", (){},showThird),
                ),

                AddHeight(45),
                Text(
                  "Not sure where to start?",
                  style:
                  TextStyle(
                    fontSize: 18,
                    fontFamily: "Garamond_Italic",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    color: Colors.white
                  ), // Color must be set, but it will be masked
                ),
                AddHeight(10),
                GestureDetector(
                  onTap: (){
                    Get.offAll(()=>BottomNavScreen(initialIndex: 4,));
                  },
                  child: Container(
                    width: 280,
                    height: 38,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 42,
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color: Color(0xFFC2BAD5)),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          gradient: LinearGradient(colors: [
                            Color(0xFF49415D),
                            Color(0xFF786F8E),
                          ],).withOpacity(0.1),

                        ),
                        child:   Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                LinearGradient(
                                  colors: [Color(0xFFC2BAD5), Color(0xFF786F8E)],
                                ).createShader(
                                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                ),
                            child: Text(
                              "LET THE HAKAT ORACLE GUIDE YOU",
                              style:
                              TextStyle(
                                fontSize: 12,
                                fontFamily: "Literata",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ).copyWith(
                                color: Colors.white,
                              ), // Color must be set, but it will be masked
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCard(String text,String icon,String image,VoidCallback onPressed,bool show){
    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: Duration(microseconds: 1000),
      child: Container(
          width: 280,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(image),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(icon,width: 110,height: 80,),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(
                    fontSize: 20,
                    fontFamily: "Sanford",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ).copyWith(
                    color: Colors.white,
                  ), // Color must be set, but it will be masked
                ),


              ],
            ),
          )
      ),
    );
  }

}