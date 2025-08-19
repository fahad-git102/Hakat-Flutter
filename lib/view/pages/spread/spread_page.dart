import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/circle_of_self.dart';
import 'package:hakat/view/pages/spread/portal_path_page.dart';
import 'package:hakat/view/pages/spread/spiral_of_becoming.dart';
import 'package:hakat/view/pages/spread/spread_card.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SpreadPage extends StatefulWidget {
  const SpreadPage({super.key});

  @override
  State<SpreadPage> createState() => _SpreadPageState();
}

class _SpreadPageState extends State<SpreadPage> {
  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  RootController _rootcontroller = Get.find<RootController>();

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

  int _currentPage = 1;

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
              child: Image.asset(AppIcon.swirl_bg, fit: BoxFit.fill),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ProfilePage());
                        },
                        child: Image.asset(
                          "assets/icons/profile_icon.png",
                          height: 27,
                          width: 27,
                        ),
                      ),
                      AddWidth(16),
                    ],
                  ),
                  AddHeight(20),
                  Text(
                    "Choose a Guided Spread",
                    textAlign: TextAlign.center,
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
                  AddHeight(35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Get.to(()=>FadeInScreen(child: TheWhisperPage()));
                        },
                        child: SizedBox(
                          width: 160,
                          height: 200,
                          child: Center(
                            child: Transform.scale(
                              scale:  1,
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/spread_card.png",
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "THE\nWHISPER",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Sanford",
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.55,
                                            color: Color(0xFFEBCD8C),
                                          ), // Color must be set, but it will be masked
                                    ),
                                    Image.asset(
                                      "assets/images/onboarding/card_one_icon.png",
                                      width: 100,
                                      height: 80,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Get.to(()=>FadeInScreen(child: ThePortalPathPage()));
                        },
                        child: SizedBox(
                          width: 160,
                          height: 200,
                          child: Center(
                            child: Transform.scale(
                              scale:  1,
                              // Scale active container larger
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/spread_card.png",
                                    ),
                                  ),
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      //   top: 18,
                                      //   bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "THE\nPORTAL PATH",
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Sanford",
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.55,
                                            color: Color(0xFFEBCD8C),
                                          ), // Color must be set, but it will be masked
                                        ),
                                        Image.asset(
                                          "assets/images/spread_card_two.png",
                                          width: 120,
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AddHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Get.to(()=>SpiralOfBecomingPage());
                        },
                        child: SizedBox(
                          width: 160,
                          height: 200,
                          child: Center(
                            child: Transform.scale(
                              scale:  1,
                              // Scale active container larger
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/spread_card.png",
                                    ),
                                  ),
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      //   top: 18,
                                      //   bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "THE SPIRAL\nOF BECOMING",
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Sanford",
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.55,
                                            color: Color(0xFFEBCD8C),
                                          ), // Color must be set, but it will be masked
                                        ),
                                        Image.asset(
                                          "assets/images/spread_card_three.png",
                                          width: 120,
                                          height: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>CircleOfSelfPage());
                        },
                        child: SizedBox(
                          width: 160,
                          height: 200,
                          child: Center(
                            child: Transform.scale(
                              scale:  1,
                              // Scale active container larger
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/spread_card.png",
                                    ),
                                  ),
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      //   top: 18,
                                      //   bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "THE CIRCLE\nOF SELF",
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Sanford",
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.55,
                                            color: Color(0xFFEBCD8C),
                                          ), // Color must be set, but it will be masked
                                        ),
                                        Image.asset(
                                          "assets/images/spread_card_four.png",
                                          width: 110,
                                          height:115,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                ),
              ),
            ),
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
