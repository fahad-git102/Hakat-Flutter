import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakat/view/global/spacing.dart';
import 'package:hakat/view/pages/profile/widgets/Chaos_toggle.dart';
import 'package:get/get.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/subscription/annual_subscriber.dart';
import 'package:hakat/view/pages/subscription/subscription_page.dart';
import '../../../../constants/theme/colors.dart';
import '../../../../controllers/user_controller.dart';

class SettingsContainer extends StatefulWidget {
  const SettingsContainer({Key? key}) : super(key: key);

  @override
  State<SettingsContainer> createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  bool soundEffects = false;
  bool backgroundMusic = false;
  bool notifications = true;
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 355,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFF201C27).withOpacity(0.8),
            Color(0xFF282433).withOpacity(0.7),
          ],
        ), // Dark background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'My Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: "Garamond_Italic",
            ),
          ),

          const SizedBox(height: 10),

          // Username row
          _buildInfoRow(
            'Username',
            userController.currentUser.value != null
                ? userController.currentUser.value?.name != null &&
                          userController.currentUser.value?.name?.isNotEmpty ==
                              true
                      ? userController.currentUser.value?.name??'thedarlingtree'
                      : 'thedarlingtree'
                : 'thedarlingtree',
          ),

          const SizedBox(height: 10),

          // Email row
          _buildInfoRow(
            'Email',
            userController.currentUser.value != null
                ? userController.currentUser.value?.email != null &&
                userController.currentUser.value?.email?.isNotEmpty ==
                    true
                ? userController.currentUser.value?.email??'jo@thedarlingtree.com'
                : 'jo@thedarlingtree.com'
                : 'jo@thedarlingtree.com',
            onEdit: () {
              // Handle email edit
              print('Edit email');
            },
          ),

          const SizedBox(height: 14),

          // Change password button
          // GestureDetector(
          //   onTap: () {
          //     // Handle change password
          //     print('Change password');
          //   },
          //   child: Center(
          //     child: Container(
          //       padding: const EdgeInsets.only(bottom: 2),
          //       decoration: const BoxDecoration(
          //         border: Border(
          //           bottom: BorderSide(color: Colors.white, width: 1),
          //         ),
          //       ),
          //       child: const Text(
          //         'CHANGE PASSWORD',
          //         style: TextStyle(
          //           fontFamily: "Inter",
          //           color: Colors.white,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500,
          //           letterSpacing: 1.2,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(height: 14),

          // Sound Effects toggle
          SettingToggle(title: "Sound Effects", onChanged: (bool value) {}),
          SettingToggle(title: "Background Music", onChanged: (bool value) {}),
          SettingToggle(title: "Notifications", onChanged: (bool value) {}),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {VoidCallback? onEdit}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFA79EBB),
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        onEdit!=null?GestureDetector(
          onTap: onEdit,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        ):Container(),
      ],
    );
  }

  Widget _buildToggleRow(
    String label,
    bool isOn,
    Color activeColor, {
    required Function(bool) onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15),
        child: Row(
          children: [
            // Left side - Chaos Mode text
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Garamond",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),

            // Right side - Toggle switch
            Container(
              width: 55,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF313A5B).withOpacity(0.9),
                    const Color(0xFF1F253E).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // OFF text
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isOn ? 1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ON text
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isOn ? 1.0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'ON',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sliding toggle button
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: isOn ? 29 : 2,
                    top: 2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomToggle(
    bool value,
    Color activeColor,
    Function(bool) onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 100,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // OFF text
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: value ? 0.3 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    'OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // ON text
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: value ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    'ON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Toggle button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: value ? 68 : 4,
              top: 4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: value ? activeColor : const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAccountWidget extends StatefulWidget {
  const MyAccountWidget({super.key});

  @override
  State<MyAccountWidget> createState() => _MyAccountWidgetState();
}

class _MyAccountWidgetState extends State<MyAccountWidget> {
  bool soundEffects = false;
  bool backgroundMusic = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFF201C27).withOpacity(0.8),
            Color(0xFF282433).withOpacity(0.7),
          ],
        ), // Dark background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Text(
              "Unlock Full Access",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "Garamond_Italic",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ).copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 6),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Text(
              "A DEEPER JOURNEY BEGINS HERE.",
              textAlign: TextAlign.center,
              style:
                  TextStyle(
                    fontSize: 12,
                    fontFamily: "Literata",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ).copyWith(
                    color: Colors.white,
                  ), // Color must be set, but it will be masked
            ),
          ),
          AddHeight(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Image.asset('assets/stars.png', width: 20, height: 100),
              ),
              AddWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Unlimited readings. No ads.",
                    style:
                        TextStyle(
                          fontSize: 20,
                          fontFamily: "Garamond",
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                  AddHeight(10),
                  Text(
                    "Go deeper with full card spreads.",
                    style:
                        TextStyle(
                          fontSize: 20,
                          fontFamily: "Garamond",
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                  AddHeight(10),
                  Text(
                    "Save your readings and whisper\nback with journaling.",
                    style:
                        TextStyle(
                          fontSize: 20,
                          fontFamily: "Garamond",
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                  ),
                ],
              ),
            ],
          ),
          AddHeight(30),
          InkWell(
            onTap: () {
              Get.to(() => SubscriptionsPage());
            },
            child: Container(
              width: 187,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/gold_effect.jpg'),
                ),
              ),
              child: Center(
                child: Container(
                  width: 185,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    gradient: LinearGradient(
                      colors: [Color(0xFF49415D), Color(0xFF786F8E)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "SUBSCRIBE",
                      style:
                          TextStyle(
                            fontSize: 14,
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
          AddHeight(25),
          Text(
            "USD \$5.99/month, USD \$49.99/year",
            style:
                TextStyle(
                  fontSize: 18,
                  fontFamily: "Garamond_Italic",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w400,
                ).copyWith(
                  color: Colors.white,
                ), // Color must be set, but it will be masked
          ),
          AddHeight(20),
          Container(height: 1, width: Get.width, color: Colors.black),
          AddHeight(20),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFC2BAD5), Color(0xFF786F8E)],
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Text(
              "WANT TO OPEN THE PORTAL \n FOR SOMEONE ELSE?",
              textAlign: TextAlign.center,
              style:
                  TextStyle(
                    fontSize: 12,
                    fontFamily: "Literata",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ).copyWith(
                    color: Colors.white,
                  ), // Color must be set, but it will be masked
            ),
          ),
          AddHeight(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Image.asset(
                  'assets/gift_subscription.png',
                  width: 55,
                  height: 40,
                ),
              ),
              AddWidth(10),
              Text(
                "Gift a Subscription",
                style:
                    TextStyle(
                      fontSize: 18,
                      fontFamily: "Garamond",
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w400,
                    ).copyWith(
                      color: Colors.white,
                    ), // Color must be set, but it will be masked
              ),
            ],
          ),

          // Title
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {VoidCallback? onEdit}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFA79EBB),
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(
    String label,
    bool isOn,
    Color activeColor, {
    required Function(bool) onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15),
        child: Row(
          children: [
            // Left side - Chaos Mode text
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Garamond",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),

            // Right side - Toggle switch
            Container(
              width: 55,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF313A5B).withOpacity(0.9),
                    const Color(0xFF1F253E).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // OFF text
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isOn ? 1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ON text
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isOn ? 1.0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'ON',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sliding toggle button
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: isOn ? 29 : 2,
                    top: 2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomToggle(
    bool value,
    Color activeColor,
    Function(bool) onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 100,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // OFF text
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: value ? 0.3 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    'OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // ON text
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: value ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    'ON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Toggle button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: value ? 68 : 4,
              top: 4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: value ? activeColor : const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
