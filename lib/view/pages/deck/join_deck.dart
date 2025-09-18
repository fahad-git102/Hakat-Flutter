import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/deck/widgets/waitlist_container.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/profile/widgets/Chaos_toggle.dart';
import 'package:hakat/view/pages/profile/widgets/oracle_buttons.dart';
import 'package:hakat/view/pages/profile/widgets/settings_container.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DeckWaitlistPage extends StatefulWidget {
  const DeckWaitlistPage({super.key});

  @override
  State<DeckWaitlistPage> createState() => _DeckWaitlistPageState();
}

class _DeckWaitlistPageState extends State<DeckWaitlistPage> {
  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  RootController _rootcontroller = Get.put(RootController());

  @override
  void initState() {
    super.initState();
    animateWidgets();
    _pageController.addListener(() {});
  }

  void animateWidgets() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() => showFirst = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => showSecond = true);
    await Future.delayed(Duration(milliseconds: 150));
    setState(() => showThird = true);
  }

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
                  AddHeight(4),
                  // CustomAppBar(text: "WAITLIST"),
                  const SizedBox(height: 20),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        LinearGradient(
                          colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: Text(
                      "Join the waitlist for",
                      style:
                      TextStyle(
                        fontSize: 25,
                        fontFamily: "Garamond_Italic",
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ).copyWith(
                        color: Colors.white,
                      ), // Color must be set, but it will be masked
                    ),
                  ),
                  SizedBox(height: 6),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        LinearGradient(
                          colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: Text(
                      "THE PRINTED DECK",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(
                        fontSize: 28,
                        fontFamily: "Sanford",
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 135,
                          left: 15,
                          right: 15,
                          child: WaitlistContainer()
                        ),
                        Positioned(
                          top: -40,
                          child: Image.asset(
                            "assets/deck/printed_deck.png",
                            width: 350,
                            height: 350,
                          ),
                        ),
                      ],
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
