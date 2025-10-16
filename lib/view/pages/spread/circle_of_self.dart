import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/show_whisper.dart';
import 'package:hakat/view/pages/spread/widgets/scroll_icon.dart';
import '../../../controllers/cards_controller.dart';
import '../../global/spacing.dart';

class CircleOfSelfPage extends StatefulWidget {
  const CircleOfSelfPage({super.key});

  @override
  State<CircleOfSelfPage> createState() => _CircleOfSelfPageState();
}

class _CircleOfSelfPageState extends State<CircleOfSelfPage>
    with TickerProviderStateMixin {
  double imageWidth = 120;
  double imageHeight = 180;
  double overlapPercentage = 0.65;
  bool showText = true;
  final cardsController = Get.find<CardsController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late ScrollController _horizontalScrollController;

  int selectedIndex = 10;
  List<OracleCard> selectedCards = [];
  // final int itemCount = 20;
  List<int>? selectedCardsIndexes;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _horizontalScrollController = ScrollController();
    selectedCardsIndexes = [];
    _animationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showText = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double centerIndex = (cardsController.cards.length - 1) / 2;
    double curveStrength = 20;
    double totalWidth =
        imageWidth * (1 + (cardsController.cards.length - 1) * (1 - overlapPercentage));

    return Scaffold(
      body: Stack(
        children: [
          // Background with Gradient Overlay
          Positioned.fill(
            child: Image.asset(AppIcon.swirl_bg, fit: BoxFit.fill),
          ),
          // Main Content
          Positioned.fill(
            bottom: 10,
            child: SingleChildScrollView(
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
                          CustomAppBar(text: "THE CIRCLE\nOF SELF"),
                          AddHeight(40),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: showText
                                ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  margin: EdgeInsets.only(top: 150),
                                  key: const ValueKey("text"),
                                  child: Center(
                                    child: Text(
                                      "“All your selves are here. You are not one self. You are many eyes seeing from many places. This spread reveals the constellation of you. You are not a single story. You are the circle, remembering itself.”",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "Sanford",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 30,
                                                  ),

                                                  child: _buildBlankRow(
                                                    "THE INNER\nPULSE",
                                                    0,
                                                  ),
                                                ),
                                                _buildBlankRow(
                                                  "THE GATE\nKEEPER",
                                                  1,
                                                ),
                                                _buildBlankRow(
                                                  "THE\nCOMPANION",
                                                  2,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 30,
                                                  ),

                                                  child: _buildBlankRow(
                                                    "THE\nHORIZON",
                                                    3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 30,
                                                  ),

                                                  child: _buildBlankRow(
                                                    "THE OUTER\nSELF",
                                                    4,
                                                  ),
                                                ),
                                                _buildBlankRow(
                                                  "THE \nCALLER",
                                                  5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 30,
                                                  ),

                                                  child: _buildBlankRow(
                                                    "THE CORE\nTHREAD",
                                                    6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      AddHeight(50),
                                      Center(
                                        child: SizedBox(
                                          height:
                                              imageHeight + curveStrength + 60,
                                          child: NotificationListener<ScrollNotification>(
                                            onNotification: (notification) {
                                              if (notification
                                                  is ScrollUpdateNotification) {
                                                double offset =
                                                    _horizontalScrollController
                                                        .offset;
                                                double cardSpacing =
                                                    imageWidth *
                                                    (1 - overlapPercentage);
                                                int newIndex =
                                                    (offset / cardSpacing)
                                                        .round();
                                                if (newIndex != selectedIndex &&
                                                    newIndex >= 0 &&
                                                    newIndex < cardsController.cards.length) {
                                                  setState(
                                                    () => selectedIndex =
                                                        newIndex,
                                                  );
                                                }
                                              }
                                              return false;
                                            },
                                            child: SingleChildScrollView(
                                              controller:
                                                  _horizontalScrollController,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: SizedBox(
                                                width: totalWidth + 100,
                                                child: Stack(
                                                  children: List.generate(cardsController.cards.length, (
                                                    index,
                                                  ) {
                                                    final double xOffset =
                                                        50 +
                                                        index *
                                                            imageWidth *
                                                            (1 -
                                                                overlapPercentage);

                                                    final double
                                                    normalizedDistance =
                                                        (index - centerIndex) /
                                                        centerIndex;
                                                    final double yOffset =
                                                        curveStrength *
                                                        pow(
                                                          normalizedDistance,
                                                          2,
                                                        ).toDouble() *
                                                        (1 -
                                                            0.3 *
                                                                cos(
                                                                  normalizedDistance *
                                                                      pi,
                                                                ));

                                                    final bool isSelected =
                                                        index == selectedIndex;
                                                    final bool isNearSelected =
                                                        (index - selectedIndex)
                                                            .abs() <=
                                                        1;

                                                    return Positioned(
                                                      left: xOffset,
                                                      top: yOffset,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if(selectedCardsIndexes?.length==7){
                                                            return;
                                                          }
                                                          double targetOffset =
                                                              (index *
                                                                  imageWidth *
                                                                  (1 -
                                                                      overlapPercentage)) -
                                                              (Get.width / 2) +
                                                              (imageWidth / 2);

                                                          _horizontalScrollController
                                                              .animateTo(
                                                                targetOffset.clamp(
                                                                  0.0,
                                                                  totalWidth -
                                                                      Get.width,
                                                                ),
                                                                duration:
                                                                    const Duration(
                                                                      milliseconds:
                                                                          500,
                                                                    ),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              )
                                                              .then((_) {
                                                            final selectedCard =
                                                            cardsController
                                                                .cards[index];
                                                            final alreadySelected =
                                                            selectedCards.any(
                                                                  (c) =>
                                                              c.id ==
                                                                  selectedCard.id,
                                                            );

                                                            if (alreadySelected) {
                                                              Get.snackbar(
                                                                'Already Selected',
                                                                'This card is already selected.',
                                                                snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM,
                                                                duration: const Duration(
                                                                  seconds:
                                                                  2,
                                                                ),
                                                              );
                                                              return;
                                                            }
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                  selectedCardsIndexes
                                                                      ?.add(
                                                                        index,
                                                                      );
                                                                  selectedCards.add(cardsController.cards[index]);
                                                                  if (selectedCardsIndexes
                                                                          ?.length ==
                                                                      7) {
                                                                    Future.delayed(
                                                                      Duration(
                                                                        seconds:
                                                                            1,
                                                                      ),
                                                                      () {
                                                                        Get.off(
                                                                          () => ShowWhisperPage(
                                                                            cardsList: selectedCards,
                                                                            title: 'THE CIRCLE OF SELF',
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                });
                                                              });
                                                        },
                                                        child: AnimatedContainer(
                                                          duration:
                                                              const Duration(
                                                                milliseconds:
                                                                    300,
                                                              ),
                                                          width: imageWidth,
                                                          height: imageHeight,
                                                          transform:
                                                              Matrix4.identity()
                                                                ..rotateY(
                                                                  normalizedDistance *
                                                                      0.15,
                                                                ),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  16,
                                                                ),
                                                            image: const DecorationImage(
                                                              image: AssetImage(
                                                                "assets/images/card.png",
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    isSelected
                                                                    ? Colors
                                                                          .white
                                                                          .withOpacity(
                                                                            0.3,
                                                                          )
                                                                    : Colors
                                                                          .black54,
                                                                blurRadius:
                                                                    isSelected
                                                                    ? 20
                                                                    : 12,
                                                                offset: Offset(
                                                                  0,
                                                                  isSelected
                                                                      ? 8
                                                                      : 6,
                                                                ),
                                                                spreadRadius:
                                                                    isSelected
                                                                    ? 2
                                                                    : 0,
                                                              ),
                                                            ],
                                                            border: isSelected
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                          0.5,
                                                                        ),
                                                                    width: 2,
                                                                  )
                                                                : null,
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              if (isSelected)
                                                                Positioned.fill(
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            16,
                                                                          ),
                                                                      gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter,
                                                                        colors: [
                                                                          Colors
                                                                              .transparent,
                                                                          Colors.black.withOpacity(
                                                                            0.6,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ScrollIcon(),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBlankRow(String title, int index) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Literata",

            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        AddHeight(6),
        Image.asset(
          selectedCardsIndexes!.length > index
              ? "assets/images/card.png"
              : "assets/images/spread_blank_card.png",
          width: 60,
          height: 120,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}
