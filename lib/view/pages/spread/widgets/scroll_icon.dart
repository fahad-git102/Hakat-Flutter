import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScrollIcon extends StatelessWidget {
  const ScrollIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/images/scroll.png',width: 86,height: 12,),
          Text(
            "Scroll",
            textAlign: TextAlign.center,
            style:
            TextStyle(
              fontSize: 20,
              fontFamily: "Garamond_Italic",
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ).copyWith(
              color: Colors.white,
            ), // Color must be set, but it will be masked
          ),
        ],
      ),
    );
  }
}
