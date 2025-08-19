import 'dart:math';
import 'package:flutter/material.dart';

class CurvedOverlayListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const int itemCount = 10;
    const double cardWidth = 150.0;
    const double overlapPercentage = 0.8;
    const double radius = 300.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            padding: EdgeInsets.symmetric(horizontal: 40),
            itemBuilder: (context, index) {
              // Calculate arc angle
              double angle = (index - itemCount / 2) * pi / 22;

              // Curved Y offset
              double yOffset = -radius * (1 - cos(angle));

              // Horizontal overlap shift
              double xOffset = -cardWidth * overlapPercentage;

              return Transform.translate(
                offset: Offset(index == 0 ? 0 : xOffset, yOffset),
                child: Transform.rotate(
                  angle: angle * 0.3, // slight tilt
                  child: Container(
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Card $index',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
