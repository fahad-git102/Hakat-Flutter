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

class TheWhisperPage extends StatefulWidget {
  const TheWhisperPage({super.key});

  @override
  State<TheWhisperPage> createState() => _TheWhisperPageState();
}

class _TheWhisperPageState extends State<TheWhisperPage>
    with TickerProviderStateMixin {
  double imageWidth = 120;
  double imageHeight = 180;
  double overlapPercentage = 0.65;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late ScrollController _horizontalScrollController;

  int selectedIndex = 10;
  final int itemCount = 20;

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
                        CustomAppBar(text: "THE\nWHISPER"),
                        AddHeight(40),
                        Image.asset(
                          "assets/images/spread_blank_card.png",
                          width: 160,
                          height: 270,
                        ),
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
                                                    print("working");
                                                    Future.delayed(Duration(seconds: 1), () {
                                                      Get.to(()=>ShowWhisperPage());
                                                    });
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

  @override
  void dispose() {
    _animationController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hakat/constants/icons.dart';
// import 'package:hakat/view/pages/profile/profile_page.dart';
// import '../../global/spacing.dart';
//
// class TheWhisperPage extends StatefulWidget {
//   const TheWhisperPage({super.key});
//
//   @override
//   State<TheWhisperPage> createState() => _TheWhisperPageState();
// }
//
// class _TheWhisperPageState extends State<TheWhisperPage>
//     with TickerProviderStateMixin {
//   double imageWidth = 120;
//   double imageHeight = 180;
//   double overlapPercentage = 0.65;
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late ScrollController _horizontalScrollController;
//
//   int selectedIndex = 10;
//   final int itemCount = 20;
//   Set<int> flippedCards = {}; // Track flipped cards
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.elasticOut,
//     ));
//
//     _horizontalScrollController = ScrollController();
//     _animationController.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double centerIndex = (itemCount - 1) / 2;
//     double curveStrength = 20;
//     double totalWidth = imageWidth * (1 + (itemCount - 1) * (1 - overlapPercentage));
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Stack(
//               children: [
//                 Image.asset(AppIcon.smokey_bg, fit: BoxFit.fill),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.3),
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.5),
//                       ],
//                       stops: const [0.0, 0.4, 1.0],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned.fill(
//             child: SafeArea(
//               child: AnimatedBuilder(
//                 animation: _fadeAnimation,
//                 builder: (context, child) {
//                   return Opacity(
//                     opacity: _fadeAnimation.value,
//                     child: Column(
//                       children: [
//                         AddHeight(8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(() => ProfilePage());
//                               },
//                               child: AnimatedScale(
//                                 scale: _scaleAnimation.value,
//                                 duration: const Duration(milliseconds: 300),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(20),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.black26,
//                                         blurRadius: 8,
//                                         offset: Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Image.asset(
//                                     "assets/icons/profile_icon.png",
//                                     height: 27,
//                                     width: 27,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             AddWidth(16),
//                           ],
//                         ),
//                         AddHeight(80),
//                         Transform.scale(
//                           scale: _scaleAnimation.value,
//                           child: Column(
//                             children: [
//                               Text(
//                                 "The Whisper",
//                                 style: TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   shadows: [
//                                     Shadow(
//                                       offset: Offset(0, 2),
//                                       blurRadius: 4,
//                                       color: Colors.black54,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               AddHeight(8),
//                               Text(
//                                 "Discover the mysteries within",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white.withOpacity(0.8),
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         AddHeight(40),
//                         Expanded(
//                           child: Center(
//                             child: SizedBox(
//                               height: imageHeight + curveStrength + 60,
//                               child: NotificationListener<ScrollNotification>(
//                                 onNotification: (notification) {
//                                   if (notification is ScrollUpdateNotification) {
//                                     double offset = _horizontalScrollController.offset;
//                                     double cardSpacing = imageWidth * (1 - overlapPercentage);
//                                     int newIndex = (offset / cardSpacing).round();
//                                     if (newIndex != selectedIndex &&
//                                         newIndex >= 0 &&
//                                         newIndex < itemCount) {
//                                       setState(() => selectedIndex = newIndex);
//                                     }
//                                   }
//                                   return false;
//                                 },
//                                 child: SingleChildScrollView(
//                                   controller: _horizontalScrollController,
//                                   scrollDirection: Axis.horizontal,
//                                   physics: const BouncingScrollPhysics(),
//                                   child: SizedBox(
//                                     width: totalWidth + 100,
//                                     child: Stack(
//                                       children: List.generate(itemCount, (index) {
//                                         final double xOffset = 50 + index * imageWidth * (1 - overlapPercentage);
//                                         final double normalizedDistance = (index - centerIndex) / centerIndex;
//                                         final double yOffset = curveStrength *
//                                             pow(normalizedDistance, 2).toDouble() *
//                                             (1 - 0.3 * cos(normalizedDistance * pi));
//                                         final bool isSelected = index == selectedIndex;
//
//                                         return Positioned(
//                                           left: xOffset,
//                                           top: yOffset,
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               if (!flippedCards.contains(index)) {
//                                                 setState(() {
//                                                   flippedCards.add(index);
//                                                 });
//                                               }
//                                             },
//                                             child: AnimatedSwitcher(
//                                               duration: const Duration(milliseconds: 600),
//                                               transitionBuilder: (child, animation) {
//                                                 final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
//                                                 return AnimatedBuilder(
//                                                   animation: rotateAnim,
//                                                   child: child,
//                                                   builder: (context, child) {
//                                                     final isUnder = (ValueKey(flippedCards.contains(index)) !=
//                                                         child!.key);
//                                                     var tilt = (animation.value - 0.5).abs() - 0.5;
//                                                     tilt *= isUnder ? -0.003 : 0.003;
//                                                     return Transform(
//                                                       transform: Matrix4.rotationY(rotateAnim.value)
//                                                         ..setEntry(3, 0, tilt),
//                                                       alignment: Alignment.center,
//                                                       child: child,
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                               layoutBuilder: (widget, list) => Stack(
//                                                 children: [widget!, ...list],
//                                               ),
//                                               switchInCurve: Curves.easeInBack,
//                                               switchOutCurve: Curves.easeOutBack,
//                                               child: flippedCards.contains(index)
//                                                   ? Container(
//                                                 key: const ValueKey(true),
//                                                 width: imageWidth,
//                                                 height: imageHeight,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.deepPurple[400],
//                                                   borderRadius: BorderRadius.circular(16),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.black38,
//                                                       blurRadius: 12,
//                                                       offset: Offset(0, 6),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "Back ${index + 1}",
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 16,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                                   : Container(
//                                                 key: const ValueKey(false),
//                                                 width: imageWidth,
//                                                 height: imageHeight,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(16),
//                                                   image: const DecorationImage(
//                                                     image: AssetImage("assets/images/card.png"),
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.black54,
//                                                       blurRadius: 12,
//                                                       offset: Offset(0, 6),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         AddHeight(20),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               width: Get.width,
//               height: 12,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.green.withOpacity(0.8),
//                     Colors.green,
//                     Colors.green.shade700,
//                   ],
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(24),
//                   topLeft: Radius.circular(24),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.green.withOpacity(0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _horizontalScrollController.dispose();
//     super.dispose();
//   }
// }
