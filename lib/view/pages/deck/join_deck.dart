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
  DeckWaitlistPage({super.key, this.showBack});
  bool? showBack = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppIcon.deck_bg),
              fit: BoxFit.fill
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      AnimatedOpacity(
                        opacity: showFirst ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              LinearGradient(
                                colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: widget.showBack == true?Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/back.svg",width: 24,height: 24,)),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Join the waitlist for",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "Garamond_Italic",
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                    ).copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 29,),
                              ],
                            ):Text(
                              "Join the waitlist for",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Garamond_Italic",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ).copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      AnimatedOpacity(
                        opacity: showSecond ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              LinearGradient(
                                colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                          child: Text(
                            "THE PRINTED DECK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: "Sanford",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ).copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedOpacity(
                        opacity: showThird ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.83,
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
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
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