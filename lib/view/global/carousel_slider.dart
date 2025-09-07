import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hakat/models/new_cards.dart';
import 'package:hakat/view/global/spacing.dart';

class SliderWidget extends StatefulWidget {
  final List<OracleCard>? cards;
  final double? height;
  final bool isFlipped;
  final ValueChanged<int>? onIndexChanged;

  const SliderWidget({
    super.key,
    this.cards,
    this.height,
    required this.isFlipped, this.onIndexChanged,
  });

  @override
  State<StatefulWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: widget.height ?? 300,
            enlargeCenterPage: true,
            autoPlay: false,
            enableInfiniteScroll: false,
            viewportFraction: 0.5,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              if (widget.onIndexChanged != null) {
                widget.onIndexChanged!(index);
              }
            },
          ),
          items: widget.cards?.map((card) {
            return Builder(
              builder: (BuildContext context) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                    return AnimatedBuilder(
                      animation: rotate,
                      child: child,
                      builder: (context, child) {
                        final isUnder = (ValueKey(widget.isFlipped) != child!.key);
                        final value = isUnder ? min(rotate.value, pi / 2) : rotate.value;
                        return Transform(
                          transform: Matrix4.rotationY(value),
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                    );
                  },
                  layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
                  child: widget.isFlipped
                      ? _buildFrontCard(card.image??'')
                      : _buildBackCard(),
                );
              },
            );
          }).toList(),
        ),
        AddHeight(20),
        ShaderMask(
          shaderCallback: (bounds) =>
              const LinearGradient(
                colors: [
                  Color(0xFFEBCD8C),
                  Color(0xFFA47E4D),
                ],
              ).createShader(
                Rect.fromLTWH(
                  0,
                  0,
                  bounds.width,
                  bounds.height,
                ),
              ),
          child: Text(
            widget.cards?[_currentIndex].title??'',
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
        ),
      ],
    );
  }

  Widget _buildFrontCard(String image) {
    return Container(
      key: const ValueKey("front"),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
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
        // child: Image.asset(
        //   image,
        //   width: 160,
        //   height: 280,
        //   fit: BoxFit.cover,
        // ),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          width: 160,
          height: 280,
          placeholder: (context, url) => Container(
            width: 160,
            height: 280,
            color: Colors.transparent, // 👈 transparent background
            alignment: Alignment.center,
            child: SizedBox(
              width: 30, // 👈 smaller loader size
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: 160,
            height: 280,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Icon(Icons.error, color: Colors.red),
          ),
        )
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      key: const ValueKey("back"),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
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
        child: Image.asset(
          "assets/images/card.png",
          width: 160,
          height: 280,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
