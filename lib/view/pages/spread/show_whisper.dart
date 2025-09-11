import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:hakat/controllers/cards_controller.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/carousel_slider.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/journals/whisper_back.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/widgets/reveal_icon.dart';
import 'package:hakat/view/pages/spread/widgets/scroll_icon.dart';
import '../../global/spacing.dart';
import 'package:flutter_svg/svg.dart';

class ShowWhisperPage extends StatefulWidget {
  const ShowWhisperPage({super.key, required this.cardsList});

  // final int cardsCount;
  final List<OracleCard> cardsList;

  @override
  State<ShowWhisperPage> createState() => _ShowWhisperPageState();
}

class _ShowWhisperPageState extends State<ShowWhisperPage>
    with TickerProviderStateMixin {
  double imageWidth = 120;
  double imageHeight = 180;
  bool flipAll = false;
  double overlapPercentage = 0.65;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late ScrollController _horizontalScrollController;

  bool showDetails = false;
  final CardsController cardsController = Get.find<CardsController>();

  int selectedIndex = 10;
  final int itemCount = 20;
  int currentIndex = 0;

  // final List<String> cards = [];

  @override
  void initState() {
    super.initState();

    // for (int i = 0; i < widget.cardsCount; i++) {
    //   cards.add("assets/images/shadow.png");
    // }

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _horizontalScrollController = ScrollController();

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double centerIndex = (itemCount - 1) / 2;
    double curveStrength = 20;
    double totalWidth =
        imageWidth * (1 + (itemCount - 1) * (1 - overlapPercentage));

    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < -10) {
            setState(() {
              showDetails = true;
              flipAll = true;
            });
          }
        },
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: Image.asset(AppIcon.swirl_bg, fit: BoxFit.fill),
            ),

            // Main Content
            Positioned.fill(
              child: SafeArea(
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AddHeight(8),
                          CustomAppBar(text: "The\nWhisper"),
                          AddHeight(40),
                          SliderWidget(
                            height: 290,
                            cards: widget.cardsList,
                            isFlipped: flipAll,
                            onIndexChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                              print("Current slider index: $currentIndex");
                            },
                          ),
                          AddHeight(20),

                          // Show scrollable content after swipe up
                          if (showDetails) ...[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF6F738E33).withOpacity(0.5),
                                        Color(0xFF7E8B97).withOpacity(0.5),
                                        Color(0xFF7E8B97).withOpacity(0.5),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.cardsList[currentIndex].description??'',
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 1.5,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () => WhisperBackPage(),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/whisper_back.svg',
                                                      width: 44,
                                                      height: 44,
                                                    ),
                                                    AddHeight(8),
                                                    Text(
                                                      "Whisper Back",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Literata",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){

                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/speel.svg',
                                                      width: 44,
                                                      height: 44,
                                                    ),
                                                    AddHeight(8),
                                                    Text(
                                                      "Share The Spell",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Literata",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          AddHeight(30),
                                          // Simulate long content
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.offAll(()=> FadeInScreen(child: BottomNavScreen()));
                                                },
                                                child: Container(
                                                  width: 280,
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      width: 300,
                                                      height: 42,
                                                      decoration: BoxDecoration(
                                                        border: BoxBorder.all(
                                                          color: Color(
                                                            0xFFC2BAD5,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                        color: Colors.white,
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xFF49415D,
                                                                ),
                                                                Color(
                                                                  0xFF786F8E,
                                                                ),
                                                              ],
                                                            ).withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: ShaderMask(
                                                          shaderCallback: (bounds) =>
                                                              LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                    0xFFC2BAD5,
                                                                  ),
                                                                  Color(
                                                                    0xFF786F8E,
                                                                  ),
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
                                                            "END THE RITUAL",
                                                            style:
                                                                TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      "Literata",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  letterSpacing:
                                                                      1,
                                                                ).copyWith(
                                                                  color: Colors
                                                                      .white,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: const SwipeUpAnimation(),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}
