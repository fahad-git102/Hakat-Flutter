import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/deck/deck_page.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ViewJournalPage extends StatefulWidget {
  const ViewJournalPage({super.key});

  @override
  State<ViewJournalPage> createState() => _ViewJournalPageState();
}

class _ViewJournalPageState extends State<ViewJournalPage> {
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
              child: Image.asset(AppIcon.journal_bg, fit: BoxFit.fill),
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
                  CustomAppBar(text: "MY WHISPERS"),
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

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('12/7/2025',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "Literata"),),
                                          Text('Delete',style: TextStyle(color: Colors.white),),

                                        ],
                                      ),
                                    ),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildCardWidget(),
                                        _buildCardWidget(),
                                        _buildCardWidget(),

                                      ],
                                    ),
                                    Text(
                                          "Card Title, Journey Entry\n Title or Question",
                                          textAlign: TextAlign.start,
                                          style:
                                          TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Garamond",
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                            letterSpacing: 1,
                                          ).copyWith(
                                            color: Colors.white,
                                          ), // Color must be set, but it will be masked
                                        ),
                                    AddHeight(30),
                                    // Step 1
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'My Whisper',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontFamily: "Garamond_Italic",
                                            // Golden color
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const Text(
                                          'Edit',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontFamily: "Inter",
                                            // Golden color
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Begin by creating a calm, quiet environment. Light a candle to represent the illumination of wisdom and understanding. Place the cards in front of you, on a clean cloth or altar space, ensuring they are undisturbed. Surround yourself with elements that resonate with you—crystals, stones, incense, or symbols of your ancestors. These items help activate the energy of your practice and bring your intentions to life.',
                                      style: TextStyle(
                                        fontSize: 12,
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

  _buildCardWidget(){
    return Column(
      children: [
        Image.asset(
          'assets/deck/universe.png',
          fit: BoxFit.cover,
          width: 75,
          height: 160,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: Icon(
                Icons.image_not_supported,
                size: 40,
                color: Colors.grey[600],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              'Ambo, The\n Universe',
              textAlign: TextAlign.center,
              style:
              TextStyle(
                fontSize: 18,
                fontFamily: "Garamond",
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ).copyWith(
                color: Colors.black,
              ), // Color must be set, but it will be masked
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
