import 'package:flutter/material.dart';

class AddHeight extends StatelessWidget {

  final double height ;
  const AddHeight(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}


class AddWidth extends StatelessWidget {

  final double width ;
  const AddWidth(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width,
    );
  }
}