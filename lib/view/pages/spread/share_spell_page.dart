import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/custom_appbar.dart';
import 'package:hakat/view/global/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/icons.dart';

class ShareSpellPage extends StatefulWidget {
  final OracleCard cardModel;

  const ShareSpellPage({super.key, required this.cardModel});

  @override
  State<StatefulWidget> createState() => _ShareSpellPageState();
}

class _ShareSpellPageState extends State<ShareSpellPage> {
  final Random _random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a1a27),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppIcon.swirl_bg, fit: BoxFit.cover),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 80),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AddHeight(15),
                          CachedNetworkImage(
                            imageUrl: widget.cardModel.image ?? '',
                            fit: BoxFit.cover,
                            width: 160,
                            height: 280,
                            placeholder: (context, url) => Container(
                              width: 160,
                              height: 280,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 160,
                              height: 280,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                          AddHeight(15),
                          Text(
                            widget.cardModel.title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Garamond",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                          AddHeight(30),
                          widget.cardModel.keywords!=null?SizedBox(
                            height: 45,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: widget.cardModel.keywords?.length??0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getRandomColor().withAlpha(80),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.cardModel.keywords?[index]??'',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ):Container(),
                          AddHeight(40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.brightness_low_outlined, color: Colors.white,),
                                AddWidth(10),
                                Expanded(child: Text(
                                  widget.cardModel.title ?? '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Garamond",
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                ),)
                              ],
                            ),
                          ),
                          AddHeight(40),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.cardModel.description ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          AddHeight(50)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }
  Color getRandomColor() {
    int min = 40;
    int max = 180;

    return Color.fromARGB(
      255,
      min + _random.nextInt(max - min),
      min + _random.nextInt(max - min),
      min + _random.nextInt(max - min),
    );
  }

  Widget _buildBottomActionBar(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black87.withAlpha(80),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomButton(
            icon: Icons.share,
            label: "Share",
            onTap: () {
              shareCard(widget.cardModel);
            },
          ),
          _BottomButton(
            icon: Icons.note_alt_outlined,
            label: "My Notes",
            onTap: () {
              print("Notes tapped");
            },
          ),
          _BottomButton(
            icon: Icons.favorite_border,
            label: "Favorite",
            onTap: () {
              print("Favorite tapped");
            },
          ),
        ],
      ),
    );
  }

  void shareCard(OracleCard card) {
    final String content = '''
✨ ${card.title ?? ''}

${card.description ?? ''}

Mantra: ${card.mantra ?? ''}
Shadow Wisdom: ${card.shadowWisdom ?? ''}
Call to Intuition: ${card.callToIntuition ?? ''}
Sigil Activation: ${card.sigilActivation ?? ''}

Keywords: ${card.keywords?.join(', ') ?? ''}
  ''';

    Share.share(content, subject: card.title ?? "Oracle Card");
  }
}

class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          AddHeight(25),
        ],
      ),
    );
  }
}
