import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/controllers/cards_controller.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/deck/deck_info.dart';
import 'package:hakat/view/pages/deck/join_deck.dart';
import 'package:hakat/view/pages/guide/guide_section.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DeckPage extends StatefulWidget {
  const DeckPage({super.key});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  final RootController _rootcontroller = Get.find<RootController>();

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

  int _currentPage = 1;

  final PageController _pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );

  final List<String> groups = [
    "INNER CIRCLE",
    "SELF AND IDENTITY",
    "PATHS OF CHANGE",
    "FORCES BEYOND THE SELF",
    "NATURE’S POWERS",
    "ETERNAL PRESENCE",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CardsController>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Image.asset(AppIcon.deck_bg, fit: BoxFit.cover),
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
                  AddHeight(8),
                  CustomAppBar(text: "MEET THE CATS"),
                  AddHeight(30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: groups.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3.8,
                          ),
                      itemBuilder: (context, index) {
                        final title = groups[index];
                        final isSelected = controller.selectedGroup.value == title;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.selectedGroup.value = title;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFFD4A15D), // gold border
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: isSelected
                                      ? Color(0xffbad3d5).withAlpha(163) // 64%
                                      : Color(0xffbad3d5).withAlpha(61), // 24%
                                ),
                                child: Center(
                                  child: Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Literata",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AddHeight(5),
                  Expanded(child: GridViewPage()),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: Get.width,
              height: 10,
              decoration: BoxDecoration(
                color: _rootcontroller.bgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                ),
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

class GridViewPage extends StatelessWidget {
  final cardsController = Get.find<CardsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx((){
              final filtered = cardsController.filteredCards;
              return filtered.isNotEmpty==true?GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.4,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return GridItemWidget(item: filtered[index]);
                },
              ):Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0),
                child: Center(
                  child: Text(
                    'No cards in this group',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: "Literata",
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
            AddHeight(15),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF385475), width: 1),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF385475),
                      blurRadius: 5
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffE4F4F8).withAlpha(70),
                    Color(0xff939498).withAlpha(17),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        LinearGradient(
                          colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: Text(
                      'Bring The Archetypes Home',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(
                            fontSize: 24,
                            fontFamily: "Sanford",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ).copyWith(
                              color: Colors.white
                          ), // Color must be set, but it will be masked
                    ),
                  ),
                  AddHeight(10),
                  Text(
                    "Join the waitlist for the printed deck.",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(
                          fontSize: 20,
                          fontFamily: "Garamond_Italic",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                  AddHeight(20),
                  InkWell(
                    onTap: () {
                      Get.to(() => DeckWaitlistPage(showBack: true,));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                                  Color(0xFF8ec5d1).withOpacity(0.7),
                                  Color(0xFF8ec5d1),
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
                                  'JOIN THE WAITLIST',
                                  style:
                                      TextStyle(
                                        fontSize: 16,
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
                    ),
                  ),
                ],
              ),
            ),
            AddHeight(5),
          ],
        ),
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final OracleCard item;

  const GridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DeckInfo(card: item,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: CachedNetworkImage(
              imageUrl: item.image??'',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    LinearGradient(
                      colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Text(
                  item.title??'',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(
                        fontSize: 18,
                        fontFamily: "Garamond",
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridItem {
  final String title;
  final String imageUrl;

  GridItem(this.title, this.imageUrl);
}
