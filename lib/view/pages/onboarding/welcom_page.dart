import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/controllers/root_controller.dart';
import 'package:hakat/controllers/user_controller.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/pages/bulk_upload_screen.dart';
import 'package:hakat/view/pages/onboarding/first_step_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/subscription/journey_awaits_page.dart';

import '../../../services/revenue_cat_service.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  State<WelcomPage> createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {

  final controller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: Get.width,
              height: Get.height,
              child: Image.asset(
                "assets/images/onboarding/onboarding_bg.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 90,
            bottom: 90,
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
                    "Welcome to the",
                    style:
                        TextStyle(
                          fontSize: 24,
                          fontFamily: "Garamond_Italic",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                ),
                SizedBox(height: 6),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      LinearGradient(
                        colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    "INTUITIVE CATS\nORACLE CARDS",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(
                          fontSize: 24,
                          fontFamily: "Sanford",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                ),
                SizedBox(height: 70),
                Image.asset("assets/logo.png", height: 150, width: 140),
                SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "by",
                      style:
                      TextStyle(
                        fontSize: 18,
                        fontFamily: "Garamond_Italic",
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                    ),
                    SizedBox(width: 8,),
                    Image.asset(
                      "assets/images/onboarding/hakat_text2.png",
                      height: 28,
                      width: 80,
                    ),

                  ],
                ),
                SizedBox(height: 50,),
                Text(
                  "This is not just a deck",
                  style:
                  TextStyle(
                    fontSize: 22,
                    fontFamily: "Garamond",
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                  ).copyWith(
                    color: Colors.black,
                  ), // Color must be set, but it will be masked
                ),
                Text(
                  "It's a potral,",
                  style:
                  TextStyle(
                    fontSize: 22,
                    fontFamily: "Garamond",
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ).copyWith(
                    color: Colors.black,
                  ), // Color must be set, but it will be masked
                ),
                Text(
                  "The unseen is whispering—\nAre you ready to listen?",
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(
                    fontSize: 22,
                    fontFamily: "Garamond_italic",
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                  ).copyWith(
                    color: Colors.black,
                  ), // Color must be set, but it will be masked
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () async {
                    if(controller.currentUser.value?.isSubscribed==true){
                      Get.to(()=>FirstStepPage());
                    }else{
                      Get.to(()=>JourneyAwaitspage());
                    }
                    // Get.to(()=> OracleCardsUploadScreen());
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
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          gradient: LinearGradient(colors: [
                            Color(0xFF49415D),
                            Color(0xFF786F8E),
                          ],),

                        ),
                        child:   Center(
                          child: Text(
                            "ENTER THE PORTAL",
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
                SizedBox(height: 30,),
                ElevatedButton(onPressed: (){
                  controller.signOut();
                }, child: Text('Log out'))
              ],
            ),
          ),
        ],
      ),
    );
  }

}
