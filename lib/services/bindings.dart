import 'package:get/get.dart';

import '../controllers/subscriptions_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionsController(), permanent: true);
  }
}