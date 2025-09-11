import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
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
  final RootController _rootcontroller = Get.find<RootController>() ;

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

  int _currentPage = 1 ;


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
                  AddHeight(8),
                  CustomAppBar(text: "MEET THE CATS",backbutton: false,),
                  AddHeight(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDeckButton("INNER CIRCLE", (){}),
                      AddWidth(10),
                      _buildDeckButton("SELF AND IDENTITY", (){}),
                    ],
                  ),
                  AddHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddWidth(6),
                      _buildDeckButton("PATHS OF CHANGE", (){}),
                      AddWidth(4),
                      _buildDeckButton("FORCES BEYOND THE SELF", (){}),
                      AddWidth(6),

                    ],
                  ),
                  AddHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDeckButton("NATURE’S POWERS", (){
                        Get.to(()=>DeckInfo());
                      }),
                      AddWidth(10),
                      _buildDeckButton("ETERNAL PRESENCE", (){}),
                    ],
                  ),
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
                borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24)),
              ),
            )
          ),
        ],
      ),
    );
  }


  _buildDeckButton(String title, VoidCallback action){
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration:  BoxDecoration(
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
                gradient: LinearGradient(colors: [
                  Color(0xFF8ec5d1).withOpacity(0.7),
                  Color(0xFF8ec5d1),
                ],),

              ),
              child:   Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
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
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _buildCard(
    String text,
    String icon,
    String image,
    VoidCallback onPressed,
    bool show,
  ) {
    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: Duration(microseconds: 1000),
      child: Container(
        width: 280,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
        ),
        child: GestureDetector(
          onTap: () => onPressed,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(icon, width: 110, height: 80),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(
                          fontSize: 20,
                          fontFamily: "Sanford",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class GridViewPage extends StatelessWidget {
  final List<GridItem> items = [
    GridItem('Abou, The\nUniverse', 'assets/deck/universe.png'),
    GridItem('Amba, The\nAries', 'assets/deck/AmbatheAries.png'),
    GridItem('Ash, the\nfire', 'assets/deck/Ashthefire.png'),
    GridItem('Anbar, the\nPisces', 'assets/deck/Anbar the Pisces.png'),
    GridItem('Bernie, the\nMagician', 'assets/deck/BernietheMagician.png'),
    GridItem('Bibi, the\nTrickster', 'assets/deck/BibitheTrickster.png'),
    GridItem('Bobo, the\nChild', 'assets/deck/BobotheChild.png'),
    GridItem('Coco, the\nDragon', 'assets/deck/CocotheDragon.png'),
    GridItem('Cupcake, the\nPachamama', 'assets/deck/CupcakethePachamama.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.4, // Adjust height ratio
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GridItemWidget(item: items[index]);
              },
            ),
            AddHeight(15),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2C6A78).withAlpha(80),
                    Color(0xFF0F2E3D).withAlpha(80),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0, 6),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ],
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
                        height: 1,
                      ).copyWith(
                        color: Colors.white,
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
                    onTap: (){
                      Get.to(()=> FadeInScreen(child: DeckWaitlistPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration:  BoxDecoration(
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
                              gradient: LinearGradient(colors: [
                                Color(0xFF8ec5d1).withOpacity(0.7),
                                Color(0xFF8ec5d1),
                              ],),

                            ),
                            child:   Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
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
                  )
                ],
              ),
            ),
            AddHeight(30)
          ],
        ),
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final GridItem item;

  const GridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: (){
    Get.to(()=>DeckInfo());
    },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
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
                  item.title,
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