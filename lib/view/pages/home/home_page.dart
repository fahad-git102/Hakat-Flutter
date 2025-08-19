import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  AddHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Get.to(()=>ProfilePage());
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
                  AddWidth(15),
                  Text(
                    "Your story is stirring.",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(
                          fontSize: 24,
                          fontFamily: "Garamond",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                  AddHeight(40),
                  Text(
                    "Choose how it will\nspeak today",
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
                  SizedBox(
                    width: Get.width,
                    height: 330,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        bool isActive = index == _currentPage;
                        return SizedBox(
                          width: 200,
                          height: 290,
                          child: Center(
                            child: Transform.scale(
                              scale: isActive ? 1.0 : 0.8,
                              // Scale active container larger
                              child: Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/images/home_card_one.png"),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 40,bottom: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "DRAW A\nCARD",
                                              textAlign: TextAlign.center,
                                              style:
                                              TextStyle(
                                                fontSize: 22,
                                                fontFamily: "Sanford",
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                              ).copyWith(
                                                color: Colors.white,
                                              ), // Color must be set, but it will be masked
                                            ),
                                        Image.asset("assets/images/onboarding/card_one_icon.png",width: 150,height: 150,),
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                    colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                                                  ).createShader(
                                                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                                  ),
                                              child: Text(
                                                "Receive a Whisper",
                                                style:
                                                TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Garamond_Italic",
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1,
                                                ).copyWith(
                                                  color: Colors.white,
                                                ), // Color must be set, but it will be masked
                                              ),
                                            ),
                                            Text(
                                              "ONE CARD, ONE TRUTH",
                                              style:
                                              TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Literata",
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1,
                                              ).copyWith(
                                                color: Colors.white.withOpacity(0.5),
                                              ), // Color must be set, but it will be masked
                                            )
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
                  const SizedBox(height: 26),
                  // Page indicator dots
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
