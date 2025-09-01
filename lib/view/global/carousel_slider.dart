import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final List<String>? images;
  final double? height;
  final bool isFlipped;

  const SliderWidget({
    super.key,
    this.images,
    this.height,
    required this.isFlipped,
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
            },
          ),
          items: widget.images?.map((image) {
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
                      ? _buildFrontCard(image)
                      : _buildBackCard(),
                );
              },
            );
          }).toList(),
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
        child: Image.asset(
          image,
          width: 160,
          height: 280,
          fit: BoxFit.cover,
        ),
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
