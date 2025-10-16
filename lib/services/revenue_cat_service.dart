import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static const String _apiKey = "appl_DkHjJxutQqZyIRkyownrHtQgDLK";

  /// Initialize RevenueCat (anonymous by default)
  static Future<void> init({String? appUserId}) async {
    await Purchases.configure(
      PurchasesConfiguration(_apiKey)..appUserID = appUserId,
    );
  }

  /// Login with a custom userId
  static Future<LogInResult?> logIn(String appUserId) async {
    try {
      final customerInfo = await Purchases.logIn(appUserId);
      debugPrint("✅ RevenueCat logged in as $appUserId");
      return customerInfo;
    } catch (e, st) {
      debugPrint("❌ RevenueCat login failed: $e\n$st");
      return null;
    }
  }

  /// Logout to anonymous user
  static Future<CustomerInfo?> logOut() async {
    try {
      final customerInfo = await Purchases.logOut();
      debugPrint("✅ RevenueCat logged out");
      return customerInfo;
    } catch (e, st) {
      debugPrint("❌ RevenueCat logout failed: $e\n$st");
      return null;
    }
  }

  /// Get current offerings
  static Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } catch (e, st) {
      debugPrint("❌ Error fetching offerings: $e\n$st");
      return null;
    }
  }

  /// Purchase a package
  static Future<PurchaseResult?> purchasePackage(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return customerInfo;
    } catch (e, st) {
      debugPrint("❌ Purchase failed: $e\n$st");
      return null;
    }
  }

  /// Restore purchases
  static Future<CustomerInfo?> restorePurchases() async {
    try {
      return await Purchases.restorePurchases();
    } catch (e, st) {
      debugPrint("❌ Restore failed: $e\n$st");
      return null;
    }
  }

  /// Get customer info
  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } catch (e, st) {
      debugPrint("❌ Error fetching customer info: $e\n$st");
      return null;
    }
  }

  /// Check if user is premium
  static Future<bool> isPremiumUser() async {
    final info = await getCustomerInfo();
    return info?.entitlements.active.containsKey("premium") ?? false;
  }
}
