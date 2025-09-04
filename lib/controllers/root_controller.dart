import 'dart:ui';

import 'package:get/get.dart';

class RootController extends GetxController {


  int index = 0 ;

  var content = 0.obs ;

  Color bgColor = Color(0xFF272033) ;

  List<Color> colors = [
    Color(0xFF272033),
    Color(0xFF272033),
    Color(0xFF1A253C),
    Color(0xFF0E293A),
    Color(0xFF272033)
  ];


  @override
  void onInit() {
    super.onInit();
  }


  setContent(int index){
    content.value = index ;
    print(content.value);
    update() ;
  }

  var navBarItems = [
    "HOME",
    "DRAW",
    "SPREAD",
    "DECK",
    "GUIDE"
  ] ;

  updateIndex(int inde){
    index = inde ;
    update() ;
  }

  updateColor(int inde){
    bgColor = colors[inde]  ;
    update() ;
  }


}