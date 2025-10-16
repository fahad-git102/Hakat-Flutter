import 'package:flutter/material.dart';
import 'package:hakat/view/global/spacing.dart';
import 'package:get/get.dart';
import '../../constants/theme/colors.dart';
import '../pages/profile/profile_page.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
   final String text ;
   final bool? backbutton ;
   final VoidCallback? onBackTap;
   final double? fontSize;
   CustomAppBar({Key? key,required this.text,this.backbutton, this.onBackTap, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackTap ?? (){
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    width: 24,
                    height: 24,
                    child: backbutton ?? true ? SvgPicture.asset("assets/icons/back.svg",width: 24,height: 24,) : Container()),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      LinearGradient(
                        colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(
                      fontSize: fontSize??24,
                      fontFamily: "Sanford",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      height: 1,
                    ).copyWith(
                      color: Colors.white,
                    ), // Color must be set, but it will be masked
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ProfilePage());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/icons/profile_icon.png",
                  height: 27,
                  width: 27,
                ),
              ),
            ),],
        ),
      ),
    );
  }
}
