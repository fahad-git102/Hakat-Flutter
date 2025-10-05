import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hakat/services/bindings.dart';
import 'package:hakat/services/revenue_cat_service.dart';
import 'package:hakat/view/global/session_manager.dart';
import 'package:hakat/view/pages/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RevenueCatService.init();
  await SharedPrefService.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Hakat_App",
      initialBinding: AppBinding(),
      themeMode: ThemeMode.light,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      }),
      home:LoginPage(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),

    );
  }
}
