import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/controllers/user_controller.dart';
import 'package:hakat/models/home_card_data.dart';
import 'package:hakat/view/dialogs/subscription_dialog.dart';
import 'package:hakat/view/pages/deck/deck_page.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/spread_card.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../spread/circle_of_self.dart';
import '../spread/portal_path_page.dart';
import '../spread/spiral_of_becoming.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  RootController _rootcontroller = Get.find<RootController>();

  List<HomeCardData> homeList = [
    HomeCardData(
      title: 'MEET THE CATS',
      icon: 'assets/logo.png',
      text1: 'Learn the Archetypes',
      text2: 'EVERY CAT CARRIES A TRUTH',
    ),
    HomeCardData(
      title: 'PULL A CARD',
      icon: 'assets/images/onboarding/card_one_icon.png',
      text1: 'Receive a Whisper',
      text2: 'ONE CARD, ONE TRUTH',
    ),
    HomeCardData(
      title: 'CHOOSE A SPREAD',
      icon: 'assets/logo.png',
      text1: 'Enter the Portal',
      text2: 'A GUIDED JOURNEY AWAITS',
    ),
    HomeCardData(
      title: 'LET INTUITION CHOOSE',
      icon: 'assets/icons/intuition.png',
      text1: 'Follow the Unseen',
      text2: 'THE DECK LEADS THE WAY',
    ),
  ];

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
    final controller = Get.find<UserController>();
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
                      itemCount: homeList.length,
                      itemBuilder: (context, index) {
                        bool isActive = index == _currentPage;
                        return SizedBox(
                          width: Get.width * 0.85,
                          height: 290,
                          child: Center(
                            child: Transform.scale(
                              scale: isActive ? 1.0 : 0.8,
                              // Scale active container larger
                              child: Container(
                                width: Get.width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/home_card_one.png",
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    if(index == 0){
                                      Get.to(()=> FadeInScreen(child: DeckPage()));
                                    }else if(index == 1){
                                      Get.to(()=> FadeInScreen(child: TheWhisperPage(showTextMain: false,)));
                                    }else if(index == 2){
                                      if(controller.currentUser.value?.isSubscribed == true){
                                        Get.offAll((FadeInScreen(child: BottomNavScreen(initialIndex: 2,),)));
                                      }else{
                                        showSubscriptionDialog();
                                      }
                                    }else if(index == 3){
                                      if(controller.currentUser.value?.isSubscribed == true){
                                        final screens = [
                                          TheWhisperPage(),
                                          ThePortalPathPage(),
                                          SpiralOfBecomingPage(),
                                          CircleOfSelfPage(),
                                        ];
                                        final randomIndex = Random().nextInt(screens.length);
                                        Get.to(() => FadeInScreen(child: screens[randomIndex]));
                                      }else{
                                        showSubscriptionDialog();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 10,
                                      left: 10,
                                      right: 10
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          homeList[index].title??'',
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
                                        Image.asset(
                                          homeList[index].icon??'',
                                          width: 120,
                                          height: 120,
                                        ),
                                        ShaderMask(
                                          shaderCallback: (bounds) =>
                                              LinearGradient(
                                                colors: [
                                                  Color(0xFFEBCD8C),
                                                  Color(0xFFA47E4D),
                                                ],
                                              ).createShader(
                                                Rect.fromLTWH(
                                                  0,
                                                  0,
                                                  bounds.width,
                                                  bounds.height,
                                                ),
                                              ),
                                          child: Text(
                                            homeList[index].text1??'',
                                            style:
                                                TextStyle(
                                                  fontSize: 20,
                                                  fontFamily:
                                                      "Garamond_Italic",
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1,
                                                ).copyWith(
                                                  color: Colors.white,
                                                ), // Color must be set, but it will be masked
                                          ),
                                        ),
                                        Text(
                                          homeList[index].text2??'',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Literata",
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1,
                                              ).copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ), // Color must be set, but it will be masked
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

  void showSubscriptionDialog(){
    showDialog(
      context: context,
      builder: (context){
        return SubscriptionDialog();
      }
    );
  }
}
