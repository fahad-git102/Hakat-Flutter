import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/controllers/whispers_controller.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/deck/deck_page.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/spread_card.dart';
import 'package:hakat/view/pages/spread/spread_page.dart';
import '../../../controllers/root_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  State<JournalListPage> createState() => _JournalListPageState();
}

class _JournalListPageState extends State<JournalListPage> {
  bool showFirst = false;

  bool showSecond = false;

  bool showThird = false;
  final whispersController = Get.find<WhispersController>();
  final UserController usersController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    animateWidgets();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
    final uid = usersController.currentUser.value?.uid;
    if (uid != null) {
      whispersController.getWhispers(uid);
    }
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

                  const SizedBox(height: 40),

                  // Scrollable content container
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0d0d10),
                              Color(0xFFD4D4D4),
                              Color(0xFFD4D4D4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {

                                      Get.to(
                                            () =>
                                            TheWhisperPage(showTextMain: false),
                                        transition: Transition.fadeIn,
                                        duration: Duration(milliseconds: 400),
                                      );
                                    },
                                    child: _buildJournalButton("+ NEW READING"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.offAll(
                                            () => BottomNavScreen(
                                              initialIndex: 2,
                                            ),
                                      );
                                    },
                                    child: _buildJournalButton("+ NEW SPREAD"),
                                  ),
                                ],
                              ),
                              AddHeight(20),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Date - Latest First",
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Garamond",
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        letterSpacing: 1,
                                      ).copyWith(
                                        color: Colors.white,
                                      ), // Color must be set, but it will be masked
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      whispersController.myWhispers.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return JournalEntryItem(
                                      date:
                                          whispersController
                                              .myWhispers[index]
                                              .date ??
                                          '',
                                      title:
                                          whispersController
                                              .myWhispers[index]
                                              .title ??
                                          '',
                                      iconType: IconType.multiple,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  _buildJournalButton(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/gold_effect.jpg'),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5F7A83).withOpacity(0.6),
                  Color(0xFF5F7A83).withOpacity(0.6),
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10,
                ),
                child: Text(
                  title,
                  style:
                      TextStyle(
                        fontSize: 12,
                        fontFamily: "Literata",
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

enum IconType { single, multiple }

class JournalEntryItem extends StatelessWidget {
  final String date;
  final String title;
  final IconType iconType;

  const JournalEntryItem({
    Key? key,
    required this.date,
    required this.title,
    required this.iconType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF3A5A6B), width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 16),
              child: _buildIcon(),
            ),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFF8B9CA8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Close/X button
            Container(
              width: 24,
              height: 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  // Handle close action
                },
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF8B9CA8),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconType == IconType.single) {
      // Single card icon
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF4A6B7D),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Icon(
            Icons.description_outlined,
            color: Color(0xFF8B9CA8),
            size: 24,
          ),
        ),
      );
    } else {
      // Multiple cards icon
      return Stack(
        children: [
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF3A5A6B),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            left: 4,
            top: 4,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF4A6B7D),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF5A7B8D),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Icon(
                  Icons.description_outlined,
                  color: Color(0xFF8B9CA8),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

// Alternative implementation using SVG icons
class JournalEntryItemWithSVG extends StatelessWidget {
  final String date;
  final String title;
  final IconType iconType;

  const JournalEntryItemWithSVG({
    Key? key,
    required this.date,
    required this.title,
    required this.iconType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF3A5A6B), width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 16),
              child: _buildSVGIcon(),
            ),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFF8B9CA8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Close/X button with SVG
            Container(
              width: 24,
              height: 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  // Handle close action
                },
                icon: SvgPicture.string(
                  '''<svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M18 6L6 18M6 6L18 18" stroke="#8B9CA8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>''',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSVGIcon() {
    if (iconType == IconType.single) {
      // Single card SVG
      return SvgPicture.string(
        '''<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
          <rect width="48" height="48" rx="4" fill="#4A6B7D"/>
          <rect x="12" y="12" width="24" height="24" rx="2" fill="none" stroke="#8B9CA8" stroke-width="2"/>
          <line x1="16" y1="20" x2="32" y2="20" stroke="#8B9CA8" stroke-width="1"/>
          <line x1="16" y1="24" x2="32" y2="24" stroke="#8B9CA8" stroke-width="1"/>
          <line x1="16" y1="28" x2="28" y2="28" stroke="#8B9CA8" stroke-width="1"/>
        </svg>''',
        width: 48,
        height: 48,
      );
    } else {
      // Multiple cards SVG
      return SvgPicture.string(
        '''<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
          <rect x="8" y="8" width="32" height="32" rx="4" fill="#3A5A6B"/>
          <rect x="4" y="4" width="32" height="32" rx="4" fill="#4A6B7D"/>
          <rect x="0" y="0" width="32" height="32" rx="4" fill="#5A7B8D"/>
          <rect x="6" y="6" width="20" height="20" rx="2" fill="none" stroke="#8B9CA8" stroke-width="1.5"/>
          <line x1="9" y1="12" x2="23" y2="12" stroke="#8B9CA8" stroke-width="1"/>
          <line x1="9" y1="16" x2="23" y2="16" stroke="#8B9CA8" stroke-width="1"/>
          <line x1="9" y1="20" x2="19" y2="20" stroke="#8B9CA8" stroke-width="1"/>
        </svg>''',
        width: 48,
        height: 48,
      );
    }
  }
}
