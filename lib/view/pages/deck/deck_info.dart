import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DeckInfo extends StatefulWidget {
  const DeckInfo({super.key});

  @override
  State<DeckInfo> createState() => _DeckInfoState();
}

class _DeckInfoState extends State<DeckInfo> {


  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;

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
              child: Image.asset(AppIcon.deck_bg, fit: BoxFit.fill),
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
                  // Top bar with close button


                  // Main content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [


                          const SizedBox(height: 40),

                          // Scrollable content container
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(colors: [Color(0xFF0d0d10),Color(0xFFD4D4D4),Color(0xFFD4D4D4)],begin: Alignment.topLeft,end:  Alignment.bottomRight),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    IconButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          icon: const Icon(
                                            Icons.close,
                                            color: Color(0xFFD4AF37), // Golden color
                                            size: 24,
                                          ),
                                        ),


                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFD6C9E9D4),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            "assets/images/shadow.png",
                                            width: 160,
                                            height: 270,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AddHeight(20),

                                    Align(
                                      alignment: Alignment.center,
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                              colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                            ),
                                        child: Text(
                                          "Create a \n Grounding Ritual",
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(
                                            fontSize: 28,
                                            fontFamily: "Garamond",
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                            letterSpacing: 1,
                                          ).copyWith(
                                            color: Colors.white,
                                          ), // Color must be set, but it will be masked
                                        ),
                                      ),
                                    ),
                                    AddHeight(30),
                                    // Step 1
                                    const Text(
                                      '1. Create a Sacred Space',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: "Garamond_Italic",
                                        // Golden color
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Begin by creating a calm, quiet environment. Light a candle to represent the illumination of wisdom and understanding. Place the cards in front of you, on a clean cloth or altar space, ensuring they are undisturbed. Surround yourself with elements that resonate with you—crystals, stones, incense, or symbols of your ancestors. These items help activate the energy of your practice and bring your intentions to life.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(height: 32),

                                    // Step 2
                                    const Text(
                                      '2. Clear the Mind and Heart',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: "Garamond_Italic",
                                        // Golden color
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Sit comfortably, close your eyes, and take a few deep breaths. With each inhale, draw in light, clarity, and strength. With each exhale, release any tension or distractions. Allow your body to relax and your mind to clear. As you breathe, focus on your connection to the earth beneath you. Visualize your roots extending deep into the ground, like the paws of the Cat moving silently through the earth. Feel the stability and grounding energy flowing upward through your body, anchoring you in the present moment.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(height: 32),

                                    // Additional space for potential more content
                                    Container(
                                      height: 100,
                                      child: const Center(
                                        child: Text(
                                          'Continue scrolling for more steps...',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white54,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                        ],
                      ),
                    ),
                  ),
                ],
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
}
