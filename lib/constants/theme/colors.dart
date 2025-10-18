import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {

  static const Color lightScaffoldBackground = Color(0xFFEEEEEE);
  static const Color darkScaffoldBackground = Color(0xFF111111);

  static const Color blackColor = Color(0xFF111111);
  static const Color whiteColor = Color(0xFFFFFFFF);

  static const Color primaryColor = Color(0xFFC7333C);
  static const Color secondaryColor = Color(0xFF3D6E39);

  static const Color greyColor = Color(0xFF667085);
  static const Color hintColor = Color(0xFFA8A8A8);
  static const Color textFieldBgdColor = Color(0xFFF9FAFB);

  static const Color secondaryText = Color(0xFF74788D);
  static const Color goldText = Color(0xFFEBCD8C);
  static const Color darkGoldText = Color(0xFFA47E4D);


  static const Color authButtonColor = Color(0xFF6056A0);
  static const Color profileButtonColor = Color(0xFF5649DF);

  static Color getPrimary(BuildContext context) {
    // Return Based On Theme Mode
    return Theme.of(context).primaryColor ;
  }

  static Color getSecondary(BuildContext context){
    return secondaryColor ;
  }

  static Color getAuthScaffoldColor(){
    return Get.isDarkMode ? AppColor.darkScaffoldBackground : AppColor.whiteColor ;
  }

}
