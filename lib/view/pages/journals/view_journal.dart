import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/constants/theme/colors.dart';
import 'package:hakat/controllers/cards_controller.dart';
import 'package:hakat/controllers/whispers_controller.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/pages/deck/deck_page.dart';
import 'package:hakat/view/pages/profile/profile_page.dart';
import '../../../controllers/root_controller.dart';
import '../../../models/new_cards.dart';
import '../../../models/whipers_model.dart';
import '../../global/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewJournalPage extends StatefulWidget {
  const ViewJournalPage({super.key, this.whispersModel});

  final WhispersModel? whispersModel;

  @override
  State<ViewJournalPage> createState() => _ViewJournalPageState();
}

class _ViewJournalPageState extends State<ViewJournalPage> {
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

  int _currentPage = 1;

  final PageController _pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );

  // Colors for the 4 items
  @override
  Widget build(BuildContext context) {
    final cardsController = Get.find<CardsController>();
    final whispersController = Get.find<WhispersController>();
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
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            widget.whispersModel?.date??'',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: "Literata",
                                            ),
                                          ),
                                          Spacer(),
                                          _buildDeleteButton(whispersController)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 290,
                                      child: ListView.separated(
                                        padding: EdgeInsets.all(16),
                                        itemCount:
                                            widget
                                                .whispersModel
                                                ?.cards
                                                ?.length ??
                                            0,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        separatorBuilder: (context, index){
                                          return AddWidth(10);
                                        },
                                        itemBuilder: (context, index) {
                                          OracleCard? card = getCardById(
                                            widget
                                                    .whispersModel
                                                    ?.cards?[index] ??
                                                '',
                                            cardsController.cards.toList(),
                                          );
                                          if (card != null) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(0xffd6c9e9),
                                                        blurRadius: 9,
                                                        spreadRadius: 1,
                                                        offset: const Offset(0, 0),
                                                      )
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: CachedNetworkImage(
                                                      width: 130,
                                                      height: 210,
                                                      imageUrl: card.image ?? '',
                                                      fit: BoxFit.fill,
                                                      placeholder: (context, str) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      },
                                                      errorWidget:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) {
                                                            return Container(
                                                              color:
                                                                  Colors.grey[300],
                                                              child: Icon(
                                                                Icons
                                                                    .image_not_supported,
                                                                size: 40,
                                                                color: Colors
                                                                    .grey[600],
                                                              ),
                                                            );
                                                          },
                                                    ),
                                                  ),
                                                ),
                                                AddHeight(5),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      card.title ?? '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Garamond",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0.8,
                                                          ).copyWith(
                                                            color: Colors.black,
                                                          ), // Color must be set, but it will be masked
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      widget.whispersModel?.title??'',
                                      textAlign: TextAlign.start,
                                      style:
                                          TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Garamond",
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                            letterSpacing: 1,
                                          ).copyWith(
                                            color: Colors.white,
                                          ), // Color must be set, but it will be masked
                                    ),
                                    AddHeight(30),
                                    // Step 1
                                    const Text(
                                      'My Whisper',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: "Garamond_Italic",
                                        // Golden color
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      widget.whispersModel?.description??'',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(height: 32),
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

  Widget _buildDeleteButton(WhispersController whispersController){
    return InkWell(
      onTap: (){
        Get.defaultDialog(
          title: "Delete Whisper",
          middleText:
          "Are you sure you want to delete this Whisper?",
          textCancel: "Cancel",
          textConfirm: "Delete",
          confirmTextColor: Colors.white,
          onConfirm: () {
            whispersController.deleteWhisper(widget.whispersModel?.id??'').then((_){
              Get.back();
              Get.back();
            });
          },
        );

      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.close, color: Colors.white, size: 17,),
            AddWidth(4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  OracleCard? getCardById(String id, List<OracleCard> allCards) {
    try {
      return allCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
