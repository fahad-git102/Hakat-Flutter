import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DeckInfo extends StatefulWidget {
  OracleCard card;
  DeckInfo({super.key, required this.card});

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
                                        height: 270,
                                        width: 160,
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
                                          child:  CachedNetworkImage(
                                            imageUrl: widget.card.image??'',
                                            fit: BoxFit.fill,
                                            placeholder: (context, str){
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            },
                                            errorWidget: (context, error, stackTrace) {
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
                                          widget.card.title??'',
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(
                                            fontSize: 28,
                                            fontFamily: "Garamond",
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                            letterSpacing: 1,
                                          ).copyWith(
                                            color: Colors.white,
                                          ), // Color must be set, but it will be masked
                                        ),
                                      ),
                                    ),
                                    AddHeight(10),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.card.keywords!=null?widget.card.keywords!.join(', '):'',
                                        textAlign: TextAlign.center,
                                        style:
                                        TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Garamond",
                                          fontWeight: FontWeight.w600,
                                          height: 1,
                                          letterSpacing: 1,
                                        ).copyWith(
                                          color: Colors.white,
                                        ), // Color must be set, but it will be masked
                                      ),
                                    ),
                                    AddHeight(30),
                                    // Step 1
                                    Text(
                                      widget.card.description??'',
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
