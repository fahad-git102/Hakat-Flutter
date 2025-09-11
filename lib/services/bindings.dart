import 'package:get/get.dart';
import 'package:hakat/controllers/cards_controller.dart';
import 'package:hakat/controllers/root_controller.dart';
import 'package:hakat/controllers/whispers_controller.dart';

import '../controllers/subscriptions_controller.dart';
import '../controllers/user_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> RootController(), fenix: true);
    Get.put(UserController(), permanent: true);
    Get.put(SubscriptionsController(), permanent: true);
    Get.put(CardsController(), permanent: true);
    Get.put(WhispersController(), permanent: true);
  }
}