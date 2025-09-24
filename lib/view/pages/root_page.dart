import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakat/view/pages/deck/deck_page.dart';
import 'package:hakat/view/pages/guide/guide_page.dart';
import 'package:hakat/view/pages/onboarding/first_step_page.dart';
import 'package:hakat/view/pages/spread/spread_card.dart';
import 'package:hakat/view/pages/spread/spread_page.dart' hide HomePage;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../constants/icons.dart';
import 'deck/join_deck.dart';
import 'home/home_page.dart';
import 'package:get/get.dart';
import 'package:hakat/controllers/root_controller.dart';

class FadeInScreen extends StatefulWidget {
  final Widget child;
  final int? duration ;

  const FadeInScreen({super.key, required this.child,this.duration});

  @override
  State<FadeInScreen> createState() => _FadeInScreenState();
}

class _FadeInScreenState extends State<FadeInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration ?? 400),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade, child: widget.child);
  }
}

class BottomNavScreen extends StatefulWidget {
  final int? initialIndex;
  const BottomNavScreen({super.key, this.initialIndex});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late PersistentTabController _controller;
  late final RootController rootController;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex??0);
    rootController = Get.put(RootController());
    rootController.updateIndex(widget.initialIndex ?? 0);
    rootController.updateColor(widget.initialIndex ?? 0);
  }

  // List of tab configs (screens + nav items)
   List<PersistentTabConfig> _tabs (int index) {
     return [
       PersistentTabConfig(
         screen: FadeInScreen(child: HomePage()),
         item: _navItem('assets/icons/home.svg', 'HOME',index == 0),
       ),
       PersistentTabConfig(
         screen: FadeInScreen(child:TheWhisperPage(showTextMain: false,)),
         item: _navItem('assets/icons/draw.svg', 'PULL',index == 1),
       ),
       PersistentTabConfig(
         screen: const FadeInScreen(
           child: SpreadPage(),
         ),
         item: _navItem('assets/icons/spread.svg', 'SPREAD',index == 2),
       ),
       PersistentTabConfig(
         screen: FadeInScreen(child:DeckWaitlistPage()),

         item: _navItem('assets/icons/deck.svg', 'DECK',index == 3),
       ),
       PersistentTabConfig(
         screen: const FadeInScreen(
           child: GuidePage(),
         ),
         item: _navItem('assets/icons/guide.svg', 'GUIDE',index == 4),
       ),
     ];
   }

     // Generate nav item with active/inactive icon color
     ItemConfig _navItem(String assetPath, String title,bool active) {
       return ItemConfig(
         icon: SvgPicture.asset(
           assetPath,
           height: 38,
           width: 38,
           color: active ? Colors.white : Color(0xFF7A7286) ,
           //   inactiveColorPrimary: Colors.grey.shade600,
           //    colorFilter: const ColorFilter.mode(BlendMode.srcIn),
         ),
         textStyle: TextStyle(
           fontSize: 10,
           fontWeight: FontWeight.w400,
           letterSpacing: 1.2,
           height: 4,
           fontFamily: "Literata"
         ),
         title: title,
         activeForegroundColor: Colors.white,
         //   activeColorSecondary: Colors.red,
         //  inactiveBackgroundColor: Colors.red,
         inactiveForegroundColor: Color(0xFF7A7286),
       );
     }


     @override
     Widget build(BuildContext context) {
       return GetBuilder(
         init: rootController,
         builder: (RootController controller) {
           return Scaffold(
             body: PersistentTabView(
               tabs: _tabs(controller.index),
               controller: _controller,
               onTabChanged: (int i){
                 controller.updateIndex(i);
                 controller.updateColor(i);
               },
               hideNavigationBar: controller.index == 1,
               backgroundColor: controller.bgColor,
               navBarBuilder: (navBarConfig) => Style7BottomNavBar(
                 navBarConfig: navBarConfig,
                 height: 92,
                 navBarDecoration: NavBarDecoration(
                   padding: EdgeInsets.only(left: 20, right: 20),
                   color: controller.bgColor,
                   // color: Colors.white,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(18),
                     topRight: Radius.circular(18),
                   ),
                 ),
               ),
             ),
           );
         },
       );
     }
   }
