import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/view/pages/onboarding/welcom_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../services/auth.dart';
import '../root_page.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{
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
                SizedBox(height: 150,),

                if (Platform.isIOS)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    width: 242,
                    height: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: SignInWithAppleButton(
                          onPressed: () async {
                            bool status = await Auth.signInWithApple(context);
                            if(status == true){
                              Get.to(()=>FadeInScreen(child: WelcomPage()));
                            }else{
                              print('login failed');
                              // Get.showSnackbar(GetSnackBar(title: 'Login failed',));
                            }
                          }
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

}