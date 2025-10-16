import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../services/revenue_cat_service.dart';

class SubscriptionsController extends GetxController{
  var offerings = Rxn<Offerings>();

  @override
  void onInit() {
    super.onInit();
    getSubscriptions();
  }

  List<Package> get availablePackages {
    final current = offerings.value?.current;
    if (current == null) return [];
    return current.availablePackages;
  }

  getSubscriptions() async {
    try {
      Offerings? result = await RevenueCatService.getOfferings();
      offerings.value = result;

      if (result == null || result.current == null) {
        debugPrint("❌ Offerings are null – check RevenueCat dashboard setup.");
      } else {
        debugPrint("✅ Offerings loaded: ${result.current!.identifier}");
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching offerings: $e");
    }
  }
}