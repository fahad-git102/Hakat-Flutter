import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/controllers/cards_controller.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/carousel_slider.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/journals/whisper_back.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/widgets/reveal_icon.dart';
import 'package:share_plus/share_plus.dart';
import '../../global/spacing.dart';
import 'package:flutter_svg/svg.dart';

class ShowWhisperPage extends StatefulWidget {
  const ShowWhisperPage({super.key, required this.cardsList, required this.title});

  final List<OracleCard> cardsList;
  final String title;

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
                          CustomAppBar(
                            text: widget.title,
                            fontSize: 21,
                            onBackTap: () {
                              widget.cardsList.clear();
                              Get.back();
                            },
                          ),
                          AddHeight(22),
                          SliderWidget(
                            height: 290,
                            cards: widget.cardsList,
                            isFlipped: flipAll,
                            onIndexChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          AddHeight(20),

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
                                        Color(0xFF7E8B97).withOpacity(0.5),
                                        Color(0xFF7E8B97).withOpacity(0.5),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: AppColor.whiteColor.withAlpha(30)
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              AddHeight(16),
                                              ShaderMask(
                                                shaderCallback: (bounds) =>
                                                    const LinearGradient(
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
                                                  widget
                                                      .cardsList[currentIndex]
                                                      .title ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 29,
                                                    fontFamily: "Garamond",
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1,
                                                    height: 1,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              AddHeight(15),
                                              Text(
                                                widget
                                                    .cardsList[currentIndex]
                                                    .keywords != null ? widget
                                                    .cardsList[currentIndex]
                                                    .keywords?.join(', ')??'' : '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Garamond",
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                  height: 1,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              AddHeight(25),
                                              Text(
                                                widget
                                                    .cardsList[currentIndex]
                                                    .description ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 25),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Shadow Wisdom:",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                  TextStyle(
                                                    fontSize: 22,
                                                    fontFamily: "Garamond_Italic",
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 1,
                                                  ).copyWith(
                                                    color: Colors.white,
                                                  ), // Color must be set, but it will be masked
                                                ),
                                              ),
                                              AddHeight(10),
                                              Text(
                                                widget
                                                    .cardsList[currentIndex]
                                                    .shadowWisdom ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              AddHeight(30),
                                              widget
                                                  .cardsList[currentIndex]
                                                  .mantra?.isNotEmpty==true?Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteColor.withAlpha(45),
                                                  border: Border.all(
                                                    color: const Color(0xFFD4AF37),
                                                    width: 1.2,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.08),
                                                      blurRadius: 6,
                                                      offset: const Offset(2, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(padding: EdgeInsets.all(12), child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "The Mantra",
                                                      textAlign: TextAlign.center,
                                                      style:
                                                      TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: "Garamond_Italic",
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 1,
                                                      ).copyWith(
                                                        color: Colors.white,
                                                      ), // Color must be set, but it will be masked
                                                    ),
                                                    AddHeight(7),
                                                    Text(
                                                      widget
                                                          .cardsList[currentIndex]
                                                          .mantra ??
                                                          '',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        height: 1.5,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),),
                                              ):Container(),
                                              SizedBox(height: 25),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Call to Intuition:",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                  TextStyle(
                                                    fontSize: 22,
                                                    fontFamily: "Garamond_Italic",
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 1,
                                                  ).copyWith(
                                                    color: Colors.white,
                                                  ), // Color must be set, but it will be masked
                                                ),
                                              ),
                                              AddHeight(10),
                                              Text(
                                                widget
                                                    .cardsList[currentIndex]
                                                    .callToIntuition ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              AddHeight(30),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteColor.withAlpha(45),
                                                  border: Border.all(
                                                    color: const Color(0xFFD4AF37),
                                                    width: 1.2,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.08),
                                                      blurRadius: 6,
                                                      offset: const Offset(2, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "Sigil Activation",
                                                        textAlign: TextAlign.center,
                                                        style:
                                                        TextStyle(
                                                          fontSize: 21,
                                                          fontFamily: "Garamond_Italic",
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 1,
                                                        ).copyWith(
                                                          color: Colors.white,
                                                        ), // Color must be set, but it will be masked
                                                      ),
                                                      AddHeight(7),
                                                      Text(
                                                        widget
                                                            .cardsList[currentIndex]
                                                            .sigilActivation ??
                                                            '',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      AddHeight(10),
                                                      CachedNetworkImage(
                                                        height: 230,
                                                        imageUrl: widget.cardsList[currentIndex].sigilUrl ?? '',
                                                        fit: BoxFit.fill,
                                                        placeholder: (context, str) {
                                                          return Center(
                                                            child:
                                                            CircularProgressIndicator(color: AppColor.authButtonColor,),
                                                          );
                                                        },
                                                        errorWidget:
                                                            (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                            ) {
                                                          return Container(
                                                            color:
                                                            Colors.grey[300],
                                                            child: Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              size: 40,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AddHeight(20),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                      () =>
                                                      WhisperBackPage(
                                                        cardsList: widget
                                                            .cardsList,),
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
                                                    "Save & Journal",
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
                                              onTap: () {
                                                shareCard(
                                                  widget
                                                      .cardsList[currentIndex],
                                                );
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
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.offAll(
                                                        () =>
                                                        BottomNavScreen()
                                                );
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
                                                        shaderCallback: (
                                                            bounds) =>
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
                                        AddHeight(20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ] else
                            ...[
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

  void shareCard(OracleCard card) {
    final String content =
    '''
✨ Check out my oracle card reading
from the Hakat Oracle App! -- ${card.title ?? ''}

${card.description ?? ''}

Mantra: ${card.mantra ?? ''}
Shadow Wisdom: ${card.shadowWisdom ?? ''}
Call to Intuition: ${card.callToIntuition ?? ''}
Sigil Activation: ${card.sigilActivation ?? ''}

Keywords: ${card.keywords?.join(', ') ?? ''}
  ''';

    Share.share(content, subject: card.title ?? "Oracle Card");
  }

  @override
  void dispose() {
    _animationController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}
