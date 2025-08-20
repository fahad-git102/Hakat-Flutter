import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/show_whisper.dart';
import 'package:hakat/view/pages/spread/widgets/scroll_icon.dart';
import '../../global/spacing.dart';

class ThePortalPathPage extends StatefulWidget {
  const ThePortalPathPage({super.key});

  @override
  State<ThePortalPathPage> createState() => _ThePortalPathPageState();
}

class _ThePortalPathPageState extends State<ThePortalPathPage>
    with TickerProviderStateMixin {
  double imageWidth = 120;
  double imageHeight = 180;
  double overlapPercentage = 0.65;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late ScrollController _horizontalScrollController;

  int selectedIndex = 10;
  final int itemCount = 20;

  List<int>? selectedCardsIndexes;
  final labels = ["PAST\nNARRATIVE", "PRESENT\nENERGY", "PORTAL OF\nRECLAMATION"];

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
    selectedCardsIndexes = [];
  }

  @override
  Widget build(BuildContext context) {
    double centerIndex = (itemCount - 1) / 2;
    double curveStrength = 20;
    double totalWidth =
        imageWidth * (1 + (itemCount - 1) * (1 - overlapPercentage));

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
                        CustomAppBar(text: "THE\nPORTAL PATH"),
                        AddHeight(40),
                       SizedBox(height: 300,
                       child: _threeCardsWidget(),),
                  //      SizedBox(
                  //        height: 250,
                  //        child: Row(
                  //          crossAxisAlignment: CrossAxisAlignment.end,
                  //          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //          children: [
                  //            Padding(padding: EdgeInsets.only(top: 30),
                  //
                  //            child: _buildBlankRow("PAST\nNARRATIVE"),
                  //            ),
                  //            _buildBlankRow("PRESENT\nNERGY"),
                  //            Padding(padding: EdgeInsets.only(top: 30),
                  //
                  //            child:_buildBlankRow("PORTAL OF\nRECLAMATION"),
                  // ),
                  //          ],
                  //        ),
                  //      ),
                        Spacer(),
                        Center(
                          child: SizedBox(
                            height: imageHeight + curveStrength + 60,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollUpdateNotification) {
                                  double offset =
                                      _horizontalScrollController.offset;
                                  double cardSpacing =
                                      imageWidth * (1 - overlapPercentage);
                                  int newIndex = (offset / cardSpacing).round();
                                  if (newIndex != selectedIndex &&
                                      newIndex >= 0 &&
                                      newIndex < itemCount) {
                                    setState(() => selectedIndex = newIndex);
                                  }
                                }
                                return false;
                              },
                              child: SingleChildScrollView(
                                controller: _horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: SizedBox(
                                  width: totalWidth + 100,
                                  child: Stack(
                                    children: List.generate(itemCount, (index) {
                                      final double xOffset =
                                          50 +
                                          index *
                                              imageWidth *
                                              (1 - overlapPercentage);

                                      final double normalizedDistance =
                                          (index - centerIndex) / centerIndex;
                                      final double yOffset =
                                          curveStrength *
                                          pow(
                                            normalizedDistance,
                                            2,
                                          ).toDouble() *
                                          (1 -
                                              0.3 *
                                                  cos(normalizedDistance * pi));

                                      final bool isSelected =
                                          index == selectedIndex;
                                      final bool isNearSelected =
                                          (index - selectedIndex).abs() <= 1;

                                      return Positioned(
                                        left: xOffset,
                                        top: yOffset,
                                        child: GestureDetector(
                                          onTap: () {
                                            double targetOffset =
                                                (index *
                                                    imageWidth *
                                                    (1 - overlapPercentage)) -
                                                (Get.width / 2) +
                                                (imageWidth / 2);

                                            _horizontalScrollController
                                                .animateTo(
                                                  targetOffset.clamp(
                                                    0.0,
                                                    totalWidth - Get.width,
                                                  ),
                                                  duration: const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                )
                                                .then((_) {
                                                  setState(() {
                                                    selectedIndex = index;
                                                    // print("working");
                                                    // Future.delayed(Duration(seconds: 1), () {
                                                    //   Get.to(()=>ShowWhisperPage());
                                                    // });
                                                    selectedCardsIndexes?.add(index);
                                                    if(selectedCardsIndexes?.length == 3){
                                                      Future.delayed(Duration(seconds: 1), () {
                                                        Get.to(()=>ShowWhisperPage(cardsCount: 3,));
                                                      });
                                                    }
                                                  });
                                                });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            width: imageWidth,
                                            height: imageHeight,
                                            transform: Matrix4.identity()
                                              ..rotateY(
                                                normalizedDistance * 0.15,
                                              ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/card.png",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: isSelected
                                                      ? Colors.white
                                                            .withOpacity(0.3)
                                                      : Colors.black54,
                                                  blurRadius: isSelected
                                                      ? 20
                                                      : 12,
                                                  offset: Offset(
                                                    0,
                                                    isSelected ? 8 : 6,
                                                  ),
                                                  spreadRadius: isSelected
                                                      ? 2
                                                      : 0,
                                                ),
                                              ],
                                              border: isSelected
                                                  ? Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
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
                                                            Colors.transparent,
                                                            Colors.black
                                                                .withOpacity(
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBlankRow(String title){
    return  Column(
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
        AddHeight(10),
        Image.asset(
          "assets/images/spread_blank_card.png",
          width: 90,
          height: 170,
        ),
      ],
    );
  }

  _threeCardsWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return Column(
          children: [
            index != 1 ? SizedBox(height: 70,):Container(),
            Text(
              labels[index],
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Literata",

                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            AddHeight(10),
            Image.asset(
              selectedCardsIndexes!.length>index?"assets/images/card.png":"assets/images/spread_blank_card.png",
              width: 90,
              height: 170,
            ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}


