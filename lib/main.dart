
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hakat/services/bindings.dart';
import 'package:hakat/services/revenue_cat_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hakat/view/pages/auth/login_page.dart';
import 'package:hakat/view/pages/deck/deck_info.dart';
import 'package:hakat/view/pages/deck/deck_page.dart';
import 'package:hakat/view/pages/deck/join_deck.dart';
import 'package:hakat/view/pages/guide/guide_section.dart';
import 'package:hakat/view/pages/journals/journal_list.dart';
import 'package:hakat/view/pages/journals/view_journal.dart';
import 'package:hakat/view/pages/journals/whisper_back.dart';
import 'package:hakat/view/pages/onboarding/welcom_page.dart';
import 'package:hakat/view/pages/profile/contact_us.dart';
import 'package:hakat/view/pages/profile/my_account_page.dart';

import 'package:hakat/view/pages/profile/profile_page.dart';
import 'package:hakat/view/pages/root_page.dart';
import 'package:hakat/view/pages/spread/circle_of_self.dart';
import 'package:hakat/view/pages/spread/portal_path_page.dart';
import 'package:hakat/view/pages/spread/show_whisper.dart';
import 'package:hakat/view/pages/spread/spiral_of_becoming.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RevenueCatService.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Hakat_App",
      initialBinding: AppBinding(),
      themeMode: ThemeMode.light,
    //  theme: AppTheme.lightTheme,
      navigatorKey: navigatorKey,
    //  darkTheme: AppTheme.darkTheme,
   //   initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      }),
      home:LoginPage(),
      // getPages: AppRoutes.routes,
      // locale: LocalizationService.locale,
      // fallbackLocale: LocalizationService.fallbackLocale,
      // translations: LocalizationService(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),

    );
  }
}
