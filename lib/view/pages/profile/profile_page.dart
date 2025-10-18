import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:hakat/controllers/chaos_controller.dart';
import 'package:hakat/controllers/user_controller.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/journals/journal_list.dart';
import 'package:hakat/view/pages/profile/my_account_page.dart';
import 'package:hakat/view/pages/profile/widgets/Chaos_toggle.dart';
import 'package:hakat/view/pages/profile/widgets/oracle_buttons.dart';
import 'package:hakat/view/pages/profile/widgets/settings_container.dart';
import '../../global/spacing.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool showFirst = false;
  bool showSecond = false;
  bool showThird = false;
  final controller = Get.find<UserController>();
  final chaosController = Get.find<ChaosController>();

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
              child: Image.asset(AppIcon.smokey_bg, fit: BoxFit.fill),
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
                  CustomAppBar(text: "My Profile"),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap:(){
                                  // Get.to(()=>ContactUsPage());
                                  Get.to(()=> JournalListPage());
                                },
                                child: Container(
                                  height: 42,
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/images/gold_effect.jpg'),
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      margin: EdgeInsets.symmetric(horizontal: 1.3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF49415D),
                                          Color(0xFF786F8E),
                                        ],),

                                      ),
                                      child:   Center(
                                        child: Text(
                                          "MY WHISPERS",
                                          style:
                                          TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Sanford",
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
                            AddWidth(10),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Get.to(()=>MyAccountPage());
                                },
                                child: Container(
                                  height: 42,
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/images/gold_effect.jpg'),
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 1.3),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF49415D),
                                          Color(0xFF786F8E),
                                        ],),

                                      ),
                                      child:   Center(
                                        child: Text(
                                          "MY ACCOUNT",
                                          style:
                                          TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Sanford",
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
                          ],
                        ),
                        AddHeight(25),
                        // ChaosModeToggle(),
                        Obx(() => ChaosModeToggle(
                          key: ValueKey(chaosController.chaosActive.value),
                          initialValue: chaosController.chaosActive.value,
                          onChanged: (value) {
                            chaosController.setFlag(value);
                          },
                        )),
                        AddHeight(20),
                        SettingsContainer(),
                        AddHeight(20),

                        HakatOracleButtons(),
                        AddHeight(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap:(){
                                _launchURL('https://docs.google.com/document/d/1sNcHvoOI7LYSL8-xx2G5eTT_O3B7OgkU/edit?usp=drive_link&ouid=104642938585168375158&rtpof=true&sd=true');
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text("TEMRS & CONDITIONS",
                                  style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 11,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                _launchURL('https://docs.google.com/document/d/1JvWlSIc-7NFgQxYEpxcVhiVG3eVN2uze/edit?usp=drive_link&ouid=104642938585168375158&rtpof=true&sd=true');
                              },
                              child: Text("Privacy Policy",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 11,
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),),
                            ),
                            InkWell(
                              onTap: (){
                                showLogoutDialog();
                              },
                              child: Text("Logout",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 11,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                ),),
                            )
                          ],),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLogoutDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: Colors.redAccent,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Logout?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to log out of your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        foregroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.back(), // close dialog
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        controller.signOut();
                        Get.back();
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
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
