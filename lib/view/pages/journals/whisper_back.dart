import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/journals/journal_list.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../global/subscribe_dialogue.dart';

class WhisperBackPage extends StatefulWidget {
  const WhisperBackPage({super.key});

  @override
  State<WhisperBackPage> createState() => _WhisperBackPageState();
}

class _WhisperBackPageState extends State<WhisperBackPage> {

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

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedTopic = 'General Inquiry';

  final List<String> _topics = [
    'General Inquiry',
    'Technical Support',
    'Feedback',
    'Business Inquiry',
    'Other'
  ];

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
            top: 30,
            bottom: 15,
            left: 15,
            right: 15,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Color(0xFF0d0d10),
                    Color(0xFFD4D4D4),
                    Color(0xFFD4D4D4)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                LinearGradient(
                                  colors: [
                                    Color(0xFFEBCD8C),
                                    Color(0xFFA47E4D)
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height),
                                ),
                            child: Text(
                              "Whisper Back",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(
                                fontSize: 28,
                                fontFamily: "Garamond",
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: 1,
                              ).copyWith(
                                color: Colors.white,
                              ), // Color must be set, but it will be masked
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFFD4AF37), // Golden color
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          LinearGradient(
                            colors: [Color(0xFFEBCD8C), Color(0xFFA47E4D)],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        "The card has spoken. Now it’s your turn.",
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(
                          fontSize: 18,
                          fontFamily: "Garamond_Italic",
                          fontWeight: FontWeight.w400,
                          height: 1,
                          letterSpacing: 1,
                        ).copyWith(
                          color: Colors.white,
                        ), // Color must be set, but it will be masked
                      ),
                    ),
                    AddHeight(20),


                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Name field
                            _buildLabel(
                                '10/4/2025',''),
                            SizedBox(height: 8),
                            _buildTextField(_nameController, 'Name your whisper'),
                            // Message field
                            AddHeight(30),
                            _buildLabel(
                                'Write what rose inside you:', ''),
                            SizedBox(height: 8),
                            _buildMessageField(),

                            SizedBox(height: 40),

                            // Submit button
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSubmitButton('SAVE WHISPER',(){
                                    Get.to(()=>JournalListPage());
                                  }),
                                  _buildSubmitButton('SAVE READING',(){

                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return const SubscriptionDialog();
                                      },
                                    );

                                  }),
                                ],
                              ),
                            ),

                            SizedBox(height: 40),
                          ],
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
    );
  }

  Widget _buildLabel(String main, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          main,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Garamond",
            fontWeight: FontWeight.w500,
          ),
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedTopic,
        dropdownColor: Color(0xFF2A2A2A),
        style: TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFFD4AF37),
        ),
        items: _topics.map((String topic) {
          return DropdownMenuItem<String>(
            value: topic,
            child: Text(topic),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedTopic = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildMessageField() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextField(
        controller: _messageController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Type your message here...',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(String title,VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Literata",

            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Handle form submission logic here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2A2A2A),
          title: Text(
            'Message Sent',
            style: TextStyle(color: Color(0xFFD4AF37)),
          ),
          content: Text(
            'Your whisper has been received. We\'ll reply with care.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: Color(0xFFD4AF37)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
