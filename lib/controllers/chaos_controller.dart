import 'package:get/get.dart';

import '../view/global/session_manager.dart';

class ChaosController extends GetxController {
  RxBool chaosActive = true.obs;
  @override
  void onInit() {
    super.onInit();
    loadFlag();
  }

  void loadFlag() {
    bool savedFlag = SharedPrefService.getBool('chaos_active', defaultValue: true);
    chaosActive.value = savedFlag;
  }

  void setFlag(bool value) {
    chaosActive.value = value;
    SharedPrefService.saveBool('chaos_active', value);
  }
}
