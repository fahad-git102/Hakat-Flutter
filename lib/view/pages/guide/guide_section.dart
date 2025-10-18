import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/models/guide_list.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GroundingRitualPage extends StatefulWidget {
  GroundingRitualPage({super.key, required this.guideModel});
  GuideModel guideModel;

  @override
  State<GroundingRitualPage> createState() => _GroundingRitualPageState();
}

class _GroundingRitualPageState extends State<GroundingRitualPage> {
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
              child: Image.asset(AppIcon.guide_bg, fit: BoxFit.fill),
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
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                              colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                            ),
                                        child: Text(
                                          widget.guideModel.title??'',
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(
                                            fontSize: 28,
                                            fontFamily: "Garamond",
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1,
                                          ).copyWith(
                                              color: Colors.white
                                          ), // Color must be set, but it will be masked
                                        ),
                                      ),
                                    ),
                                    AddHeight(30),

                                    widget.guideModel.description??Container(),
                                    AddHeight(30)
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
