import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/guide/guide_section.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  RootController _rootcontroller = Get.find<RootController>() ;

  @override
  void initState() {
    super.initState();
    animateWidgets();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void animateWidgets() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() => showFirst = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => showSecond = true);
    await Future.delayed(Duration(milliseconds: 150));
    setState(() => showThird = true);
  }

  final List<Color> _itemColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
  ];

  int _currentPage = 1 ;


  final PageController _pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );

  // Colors for the 4 items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: Get.width,
              height: Get.height,
              child: Image.asset(AppIcon.guide_bg, fit: BoxFit.fill),
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
                  AddHeight(8),
                  CustomAppBar(text: "THE GUIDE",backbutton: false,),
                  AddHeight(30),
                  Text(
                    "As you embark on the path of the",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
          Text(
            "Intuitive Cat Oracle Cards,",
            textAlign: TextAlign.center,
            style:
            TextStyle(
              fontSize: 14,
              fontFamily: "Inter_Italic",
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ).copyWith(
              color: Colors.white,
            ), // Color must be set, but it will be masked
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Text(
              "It is important to honour the space and energy you are about to enter. Learn more about how to work with oracle cards here.",
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 14,
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(
                color: Colors.white,
              ), // Color must be set, but it will be masked
            ),
          ),
                  AddHeight(35),
                  SizedBox(
                    width: Get.width,
                    height: 230,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        bool isActive = index == _currentPage;
                        return SizedBox(
                          width: 170,
                          height: 210,
                          child: Center(
                            child: Transform.scale(
                              scale: isActive ? 1.0 : 0.8,
                              // Scale active container larger
                              child: Container(
                                  width: 170,
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/images/guide_card.png"),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.to(()=>FadeInScreen(child: GroundingRitualPage()));
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30,bottom: 30),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "WHAT IS\nAN ORACLE\nCARD?",
                                              textAlign: TextAlign.center,
                                              style:
                                              TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Sanford",
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                height: 1
                                              ).copyWith(
                                                color: Colors.white,
                                              ), // Color must be set, but it will be masked
                                            ),
                                        Image.asset("assets/images/onboarding/card_one_icon.png",width: 100,height: 70,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white54,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Ready to begin?",
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 142,
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
                            width: 140,
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
                                "PULL A CARD",
                                style:
                                TextStyle(
                                  fontSize: 14,
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
                      Container(
                        width: 187,
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
                            width: 185,
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
                                "CHOOSE A SPREAD",
                                style:
                                TextStyle(
                                  fontSize: 14,
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
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: Get.width,
              height: 10,
              decoration: BoxDecoration(
                color: _rootcontroller.bgColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24)),
              ),
            )
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _buildCard(
    String text,
    String icon,
    String image,
    VoidCallback onPressed,
    bool show,
  ) {
    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: Duration(microseconds: 1000),
      child: Container(
        width: 280,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
        ),
        child: GestureDetector(
          onTap: () => onPressed,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(icon, width: 110, height: 80),
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
            ),
          ),
        ),
      ),
    );
  }



}
